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
            (dep, artifact.url, os.Path(file))
          }
      })
      .flatten
      .distinctBy { case (_, url, file) => url }
  }

  // TODO: upstream sha256 first, then TOFU
  def hash(
      files: Seq[(Dependency, String, os.Path)]
  ): Map[Dependency, (String, String)] = {
    files
      .distinctBy((_, _, p) => p)
      .map((dep, url, jarPath) => {
        println(s"Hashing ${jarPath}")
        val sha256 = os
          .proc(
            "nix",
            "--extra-experimental-features",
            "nix-command",
            "hash",
            "file",
            "--sri",
            "--type",
            "sha256",
            jarPath.toString
          )
          .call()
          .out
          .trim()
        (dep, (url, sha256))
      })
      .toMap
  }

  def codegen(hashResult: Map[Dependency, (String, String)]) = {
    val expr = hashResult.map { case (dep, (url, sha256)) =>
      val name = dep.module.organization.value
        + "_"
        + dep.module.name.value
        + "-"
        + dep.versionConstraint.asString
      val installPath = {
        val p = url.stripPrefix(Repositories.central.root)
        // Canonicalize path to avoid any possible issue
        os.RelPath(p.stripPrefix("/"))
      }

      s"""
        |  "${name}" = fetchurl {
        |    name = "${name}";
        |    hash = "${sha256}";
        |    url = "${url}";
        |    passthru.installPath = "${installPath}";
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
    val transitiveDeps = getAllDependencies()

    if transitiveDeps.isEmpty then
      Logger.fatal(
        s"No transitiveCoursierProjects.json file found in ${projectOutDir}"
      )

    val deps = fetch(transitiveDeps)
    val hashes = hash(deps)
    codegen(hashes)
  }
}
