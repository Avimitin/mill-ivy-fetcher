package in.avimit.dev.mif

import java.nio.file.{Path => _, _}
import scala.util.chaining.*

case class PrepareParams(
    projectRoot: os.Path,
    fetchTargets: Seq[String],
    uCacheDir: Option[os.Path],
    keepWorkdir: Boolean,
    dryRun: Boolean = false
)

class WorkdirInfo(projectPath: os.Path, deleteOnExit: Boolean) {
  def copyFix(from: os.Path, to: os.Path): Unit = {
    os.makeDir.all(to / os.up)
    require(
      !to.startsWith(from),
      s"Can't copy a directory into itself: $to is inside $from"
    )

    def copyOne(p: os.Path): Unit = {
      val target = to / p.relativeTo(from)
      Files.copy(p.wrapped, target.wrapped, LinkOption.NOFOLLOW_LINKS)
      if os.isDir(target, followLinks = false) then
        os.perms.set(target, "rwx------")
    }

    copyOne(from)
    if (os.stat(from, followLinks = false).isDir) then
      for (p <- os.walk(from)) copyOne(p)
  }

  lazy val workDir = os.temp.dir(
    deleteOnExit = deleteOnExit,
    prefix = s"${projectPath.last}_src_"
  )

  lazy val sourcePath = {
    val p = workDir / "source"
    copyFix(projectPath, p)
    // Source might be read-only, and we need a writable out directory cuz mill doesn't allow us customize zinc output directory.
    os.perms.set(p, "rwx------")
    p
  }

  lazy val ivyCachePath = {
    val p = workDir / "cache"
    os.makeDir.all(p)
    p
  }

  override def toString(): String = workDir.toString

  def toMap(): Map[String, String] = Map(
    "workDir" -> workDir.toString,
    "sourcePath" -> sourcePath.toString,
    "ivyCachePath" -> ivyCachePath.toString
  )
}

case class PrepareResult(
    workDir: WorkdirInfo,
    millVersion: String
) {
  def toMap(): Map[String, String] =
    workDir.toMap() + ("millVersion" -> millVersion)
}

class PrepareRunner(parameter: PrepareParams) {
  import parameter.*

  private def javaOpts(env: String, cacheDir: os.Path): (String, String) =
    val ivyLocalRepo = cacheDir / "ivy2"
    val ivyDLCache = cacheDir / "cache"
    os.makeDir.all(cacheDir)
    os.makeDir.all(ivyLocalRepo)
    os.makeDir.all(ivyDLCache)

    val baseOpts = Map(
      "-Dcoursier.ivy.home" -> ivyLocalRepo.toString,
      "-Divy.home" -> ivyLocalRepo.toString,
      "-Dcoursier.cache" -> ivyDLCache.toString
    )

    val userOpts = sys.env
      .get(env)
      .filter(_.nonEmpty)
      .map(_.strip().split("\\s+"))
      .toSeq
      .flatMap(_.map(optDef =>
        val defs = optDef.split("=")
        if baseOpts.contains(defs(0)) then
          Logger.warning(
            s"Env ${env} contains ${defs(0)} which will override mif's environment"
          )
        optDef
      ))

    env -> (baseOpts.map { case (k, v) => s"${k}=${v}" }.toSeq ++ userOpts)
      .mkString(" ")

  def run(): PrepareResult =
    val workDir = WorkdirInfo(projectRoot, !keepWorkdir)
    val cacheDir = uCacheDir.getOrElse(workDir.ivyCachePath)

    val prepareTargets = fetchTargets.flatMap(t =>
      Seq(
        s"${t}.prepareOffline",
        s"${t}.scalaCompilerClasspath",
        s"${t}.scalaDocClasspath"
      )
    )

    val baseEnv = Map(
      "COURSIER_REPOSITORIES" -> "ivy2local|central",
      "XDG_CACHE_HOME" -> cacheDir.toString
    ).tap { envMap =>
      envMap.foreach(e =>
        if sys.env.get(e._1).isDefined then
          Logger.warning(s"env ${e._1} is set but ignored")
      )
    }

    val env: Map[String, String] = baseEnv
      + javaOpts("JAVA_OPTS", cacheDir)
      + javaOpts("JAVA_TOOL_OPTIONS", cacheDir)

    val millVersion = ProcessRunner
      .run(Seq("mill", "--version"), cwd = workDir.sourcePath, env = env)
      .out
      .linesIterator
      .next()

    Logger.info(s"Using ${millVersion}")

    if dryRun then
      Logger.info("Dry-run mode: skipping mill target execution")
      prepareTargets.foreach(t => Logger.info(s"Would run: mill ${t}"))
    else
      val total = prepareTargets.size
      prepareTargets.zipWithIndex.foreach { case (t, idx) =>
        Logger.info(s"[${idx + 1}/${total}] Running mill ${t}")
        ProcessRunner.run(Seq("mill", t), cwd = workDir.sourcePath, env = env)
      }

    PrepareResult(workDir, millVersion)
}
