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
        Fetcher.fetch(dlDir, dep)
        (dep, dlDir)
      })
  }

  def hash(
      files: Seq[(Dependency, os.Path)]
  ): Map[Dependency, String] = {
    files
      .distinctBy((_, p) => p)
      .map((dep, dir) => {
        println(s"Hashing ${dir}")
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
            dir.toString
          )
          .call()
          .out
          .trim()
        (dep, sha256)
      })
      .toMap
  }

  def codegen(hashResult: Map[Dependency, String]) = {
    val expr = hashResult.map { case (dep, sha256) =>
      val uniqueName =
        dep.module.organization.value + ":" + dep.module.name.value + ":" + dep.versionConstraint.asString
      s"""
        |"${uniqueName}" = stdenvNoCC.mkDerivation {
        |  name = "${uniqueName}";
        |  nativeBuildInputs = [ coursier ];
        |  outputHash = "${sha256}";
        |  outputHashAlgo = "sha256";
        |  outputHashMode = "nar";
        |  impureEnvVars = [ "https_proxy" "JAVA_OPTS" "JAVA_TOOL_OPTIONS" ];
        |  buildCommand = ''
        |    mkdir -p "cache"
        |    export COURSIER_CACHE="$$PWD/cache"
        |    cs fetch --cache "$$PWD/cache" -r central "${uniqueName}"
        |    mv -v cache "$$out"
        |  '';
        |};
        |""".stripMargin
    }

    os.write.over(
      codegenPath,
      s"""|{ stdenvNoCC, coursier }: {
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
