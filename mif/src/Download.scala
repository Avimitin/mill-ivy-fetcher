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
