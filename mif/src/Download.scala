package in.avimit.dev.mif

import coursier._
import coursier.cache.FileCache

object Fetcher {
  def parse(dep: String): Dependency = {
    val Seq(org, name, version) = dep.trim.split(":").filter(_.nonEmpty).toSeq
    val module =
      Module(Organization(org), ModuleName(name), Map.empty)
    val versionConstraint = VersionConstraint(version)
    Dependency(module, versionConstraint)
  }

  def fetch(dep: Dependency, cacheDir: os.Path) = {
    Logger.info(
      s"* Fetching org: ${dep.module.organization.value}, name: ${dep.module.name.value}, version: ${dep.versionConstraint.asString}"
    )
    val cache = FileCache()
      .withLocation(cacheDir.toIO)

    Fetch()
      .addDependencies(dep)
      .withRepositories(
        Seq(
          Repositories.central
        )
      )
      .withCache(cache)
      .runResult()
  }
}

/* object Outdated {
  // NOT USED
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

  // NOT USED
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

  // NOT USED
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
} */
