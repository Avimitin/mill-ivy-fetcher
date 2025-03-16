package in.avimit.dev.mif

import coursier._
import coursier.cache.FileCache

case class CodegenParams(projectOutDir: os.Path, cacheDir: os.Path)

class Codegen(param: CodegenParams) {
  import param.*

  def getAllDependencies() = os
    .walk(projectOutDir)
    .filter(p => p.last == "transitiveCoursierProjects.json")
    .map(p => ujson.read(os.read(p)))
    .map(json => {
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
    val cache = FileCache().withLocation(cacheDir.toString)
    Fetch()
      .withDependencies(depsList)
      .withRepositories(
        Seq(
          Repositories.central
        )
      )
      .withCache(cache)
      .run()
  }

  def run() = {
    val transitiveDeps = getAllDependencies()

    if transitiveDeps.isEmpty then
      Logger.fatal(
        s"No transitiveCoursierProjects.json file found in ${projectOutDir}"
      )

    Logger.info("Dependencies resolved:")
    Logger.info(
      transitiveDeps
        .map(dep => {
          s"* org: ${dep.module.orgName}, name: ${dep.module.name.value}, version: ${dep.versionConstraint.asString}"
        })
        .mkString("\n")
    )
    Logger.info("Fetching")

    fetch(transitiveDeps)
  }
}
