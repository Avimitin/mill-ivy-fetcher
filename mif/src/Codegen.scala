package in.avimit.dev.mif

import coursier._
import coursier.cache.FileCache

case class CodegenParams(
    projectOutDir: os.Path,
    cacheDir: os.Path,
    codegenPath: os.Path
)

class Codegen(param: CodegenParams) {
  import param.*

  def getAllDependencies() = os
    .walk(projectOutDir)
    .filter(p => {
      p.last == "transitiveCoursierProjects.json"
    })
    .map(p => {
      val json = ujson.read(os.read(p))
      json
        .obj("value")
        .arr
        .map(mod =>
          mod
            .obj("dependencies")
            .arr
            .map(deps => {
              val spec = deps.arr(1).obj
              val org = spec("module").obj("organization").obj("value").str
              val name = spec("module").obj("name").obj("value").str
              val version = spec("version").str
              val module =
                Module(Organization(org), ModuleName(name), Map.empty)
              val versionConstraint = VersionConstraint(version)
              Dependency(module, versionConstraint)
            })
        )
        .flatten
        .distinct
    })
    .flatten
    .distinct
    .filter(x => !x.module.orgName.contains("mill-internal"))

  def getMillDependencies() = {
    os
      .walk(projectOutDir)
      .filter(p => {
        val segs = p.segments.toIndexedSeq.reverse
        p.last == "scalacPluginClasspath.json"
        || (segs(0) == "classpath.json" && segs(1) == "ZincWorkerModule")
      })
      .map(p => ujson.read(os.read(p)))
      .map(json => {
        json
          .obj("value")
          .arr
          .map(v => os.Path(v.str.split(":").last))
          .map(path => {
            val it = path.segments.toSeq.reverse
              .takeWhile(_ != "maven2")
              .drop(1)
            it match
              case version :: modName :: orgSlice =>
                val module = Module(
                  Organization(orgSlice.reverse.mkString(".")),
                  ModuleName(modName),
                  Map.empty
                )
                val versionConstraint = VersionConstraint(version)
                Dependency(module, versionConstraint)
              case _ => throw new Exception("Invalid classpath")
          })
      })
      .flatten
      .distinct
  }

  def fetch(depsList: Seq[Dependency]) = {
    depsList
      .map(dep => {
        val uniqName =
          (dep.module.organization.value + "_" + dep.module.name.value + "_" + dep.versionConstraint.asString)
        val dlDir = cacheDir / uniqName
        Fetcher
          .fetch(dep, dlDir)
          .detailedArtifacts0
          .map { case (dep, _, artifact, file) =>
            // TODO: add sha256sum URL here
            (
              dep,
              Seq(artifact.url, artifact.extra("metadata").url),
              os.Path(file)
            )
          }
      })
      .flatten
      .distinctBy { case (_, url, file) => url }
  }

  // TODO: upstream sha256 first, then TOFU
  def hash(
      files: Seq[(Dependency, Seq[String], os.Path)]
  ): Map[Dependency, (Seq[String], String)] = {
    files
      .distinctBy((_, _, p) => p)
      .map((dep, url, jarPath) => {
        val modulePath = jarPath / os.up
        os.walk(modulePath)
          .filter(p => p.last.startsWith("."))
          .foreach(os.remove(_))

        Logger.info(s"Hashing ${modulePath}")
        val sha256 = os
          .proc(
            "nix",
            "--extra-experimental-features",
            "nix-command",
            "hash",
            "path",
            "--sri",
            "--algo",
            "sha256",
            "--mode",
            "nar",
            modulePath.toString
          )
          .call()
          .out
          .trim()
        (dep, (url, sha256))
      })
      .toMap
  }

  def codegen(hashResult: Map[Dependency, (Seq[String], String)]) = {
    val expr = hashResult.map { case (dep, (url, sha256)) =>
      val name = dep.module.organization.value
        + "_"
        + dep.module.name.value
        + "-"
        + dep.versionConstraint.asString

      def extract(u: String): (String, String) = {
        val fullInstallPath = os.RelPath(u.replace("https://", "https/"))
        val filename = fullInstallPath.last
        val modulePath = fullInstallPath / os.up
        (modulePath.toString, filename)
      }

      val Seq(jarUrl, pomUrl) = url
      val (moduleInstallPath, jarFilename) = extract(jarUrl)
      val (_, pomFilename) = extract(pomUrl)

      s"""
        |  "${name}" = fetchurl {
        |    name = "${name}";
        |    hash = "${sha256}";
        |    url = "${jarUrl}";
        |    recursiveHash = true;
        |    downloadToTemp = true;
        |    postFetch = ''
        |      mkdir -p "$$out"
        |      cp -v "$$downloadedFile" "$$out/${jarFilename}"
        |
        |      downloadedFile=$$TMPDIR/pomFile
        |      tryDownload "$pomUrl"
        |      cp -v "$$downloadedFile" "$$out/${pomFilename}"
        |    '';
        |    passthru.installPath = "${moduleInstallPath}";
        |  };
        |""".stripMargin
    }

    os.write.over(
      codegenPath,
      s"""|{ fetchurl }: {
          |${expr.mkString}
          |}
          |""".stripMargin
    )
  }

  def run() = {
    val transitiveDeps = getAllDependencies() ++ getMillDependencies()

    if transitiveDeps.isEmpty then
      Logger.fatal(
        s"No transitiveCoursierProjects.json file found in ${projectOutDir}"
      )

    val deps = fetch(transitiveDeps)
    val hashes = hash(deps)
    codegen(hashes)
  }
}
