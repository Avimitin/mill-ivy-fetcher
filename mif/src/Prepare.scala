package in.avimit.dev.mif

import java.nio.file.{Path => _, _}
import scala.util.chaining.*

case class PrepareParams(
    projectRoot: os.Path,
    fetchTargets: Seq[String],
    uCacheDir: Option[os.Path],
    keepWorkdir: Boolean
)

class WorkdirInfo(projectPath: os.Path, deleteOnExit: Boolean) {
  def copyFix(
      from: os.Path,
      to: os.Path,
      followLinks: Boolean = true,
      replaceExisting: Boolean = false,
      copyAttributes: Boolean = false,
      createFolders: Boolean = false,
      mergeFolders: Boolean = false
  ): Unit = {
    if (createFolders && to.segmentCount != 0) then os.makeDir.all(to / os.up)
    val opts1 =
      if (followLinks) then Array[CopyOption]()
      else Array[CopyOption](LinkOption.NOFOLLOW_LINKS)
    val opts2 =
      if (replaceExisting) then
        Array[CopyOption](StandardCopyOption.REPLACE_EXISTING)
      else Array[CopyOption]()
    val opts3 =
      if (copyAttributes) then
        Array[CopyOption](StandardCopyOption.COPY_ATTRIBUTES)
      else Array[CopyOption]()
    require(
      !to.startsWith(from),
      s"Can't copy a directory into itself: $to is inside $from"
    )

    def copyOne(p: os.Path): Unit = {
      val target = to / p.relativeTo(from)
      if (
        mergeFolders
        && os.isDir(p, followLinks)
        && os.isDir(target, followLinks)
      )
      then {
        // nothing to do
      } else {
        Files.copy(p.wrapped, target.wrapped, (opts1 ++ opts2 ++ opts3)*)
        os.perms.set(target, "rwxr-xr-x")
      }
    }

    copyOne(from)
    if (os.stat(from, followLinks = followLinks).isDir) then
      for (p <- os.walk(from)) copyOne(p)
  }

  lazy val workDir = os.temp.dir(
    deleteOnExit = deleteOnExit,
    prefix = s"${projectPath.last}_src_"
  )

  lazy val sourcePath = {
    val p = workDir / "source"
    copyFix(projectPath, p)
    // Source might be read-only, and we need a writable out directory cuz mill doesn't allow us custom zinc output directory.
    os.perms.set(p, "rwxr-xr-x")
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

class PrepareRunner(parameter: PrepareParams) {
  import parameter.*

  def processJavaOpts(env: String, cacheDir: os.Path): (String, String) =
    val ivyLocalRepo = cacheDir / "ivy2"
    val ivyDLCache = cacheDir / "cache"
    os.makeDir.all(cacheDir)
    os.makeDir.all(ivyLocalRepo)
    os.makeDir.all(ivyDLCache)

    val baseOpts = Map(
      // Override ~/.ivy2
      "-Dcoursier.ivy.home" -> ivyLocalRepo.toString,
      // Mill vendor an old logic
      "-Divy.home" -> ivyLocalRepo.toString,
      // Override ~/.cache/coursier/v1
      "-Dcoursier.cache" -> ivyDLCache.toString
    )
    val userOpts = sys.env.get(env) match
      case Some(raw) if raw.nonEmpty =>
        raw
          .strip()
          .split("\\s+")
          .map(optDef =>
            val defs = optDef.split("=")
            if baseOpts.contains(defs(0)) then
              Logger.warning(
                s"Env ${env} contains ${defs(0)} which will override mif's environment"
              )
            optDef
          )
          .toSeq
      case _ => Seq.empty

    val opts = (baseOpts.map { case (k, v) =>
      s"${k}=${v}"
    }.toSeq ++ userOpts).mkString(" ")

    (env -> opts)

  def run() = {
    val workDir = WorkdirInfo(projectRoot, !keepWorkdir)

    val cacheDir = uCacheDir.getOrElse(workDir.ivyCachePath)

    val targets = fetchTargets.map(t => s"${t}.prepareOffline")
      ++ fetchTargets.map(t => s"${t}.scalaCompilerClasspath")
      ++ fetchTargets.map(t => s"${t}.scalaDocClasspath")

    val env: Map[String, String] = Map(
      // Maven mirror sometime contains invalid dependency and make us hard to debug the problem, use maven central only.
      "COURSIER_REPOSITORIES" -> "ivy2local|central",
      "COURSIER_CACHE" -> ""
    ).tap(
      _.foreach(e =>
        if sys.env.get(e._1).isDefined then
          Logger.warning(s"env ${e._1} is set but ignored")
      )
    ) + processJavaOpts("JAVA_OPTS", cacheDir)
      + processJavaOpts("JAVA_TOOL_OPTIONS", cacheDir)

    targets.foreach(t =>
      os.proc(Seq("mill", "--no-server", "--silent", "--disable-prompt", t))
        .call(
          cwd = workDir.sourcePath,
          env = env
        )
    )

    workDir
  }
}
