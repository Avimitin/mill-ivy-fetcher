package in.avimit.dev.mif

import coursier._

case class CodegenParams(projectOutDir: os.Path)

case class dependency(org: String, name: String, version: String)

class Codegen(param: CodegenParams) {
  import param.*

  def getAllDependencies(): Seq[String] = os
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
              s"${org}:${name}:${version}"
            })
        )
        .flatten
        .distinct
    })
    .flatten
    .distinct
    .filter(x => !x.contains("mill-internal"))

  def run() = {
    val transitiveDeps = getAllDependencies()

    if transitiveDeps.isEmpty then
      Logger.fatal(
        s"No transitiveCoursierProjects.json file found in ${projectOutDir}"
      )
  }
}
