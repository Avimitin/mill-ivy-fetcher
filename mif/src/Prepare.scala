package in.avimit.dev.mif

import java.nio.file.{Path => _, _}

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
        Files.copy(p.wrapped, target.wrapped, opts1 ++ opts2 ++ opts3: _*)
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

  def jvm_opt_to_set(env_key: String): Map[String, String] = {
    sys.env.get(env_key) match
      case Some(raw) if raw.nonEmpty => {
        Logger.info(s"Using env ${env_key}: '${raw}'")
        raw
          .strip()
          .split("\\s+")
          .map(optDef => {
            val defs = optDef.split("=")
            (defs(0), defs(1))
          })
          .toMap
      }
      case _ => Map()
  }

  def handleEnv(cacheDir: os.Path): (String, String) = {
    val ivyLocalRepo = cacheDir / "ivy2"
    val ivyDLCache = cacheDir / "cache"
    os.makeDir.all(cacheDir)
    os.makeDir.all(ivyLocalRepo)
    os.makeDir.all(ivyDLCache)

    val baseJvmOpts = Map(
      // Override ~/.ivy2
      "-Dcoursier.ivy.home" -> ivyLocalRepo.toString,
      // Mill vendor an old logic
      "-Divy.home" -> ivyLocalRepo.toString,
      // Override ~/.cache/coursier/v1
      "-Dcoursier.cache" -> ivyDLCache.toString
    )
    // Allow user to override or add new options
      ++ jvm_opt_to_set("JAVA_OPTS")
      ++ jvm_opt_to_set("JAVA_TOOL_OPTIONS")

    val jvmOpts: Seq[String] = baseJvmOpts.map { case (k, v) =>
      s"${k}=${v}"
    }.toSeq

    val millOptFile = os.temp()
    os.write.over(millOptFile, jvmOpts.mkString("\n"))

    val jvmOptsEnv = jvmOpts.mkString(" ")

    (millOptFile.toString, jvmOptsEnv)
  }

  def run() = {
    val workDir = WorkdirInfo(projectRoot, !keepWorkdir)

    val cacheDir = uCacheDir.getOrElse(workDir.ivyCachePath)

    val targets = fetchTargets.map(t => s"${t}.prepareOffline")
      ++ fetchTargets.map(t => s"${t}.scalaCompilerClasspath")
      ++ fetchTargets.map(t => s"${t}.scalaDocClasspath")

    val (millOptFile, jvmOptsEnv) = handleEnv(cacheDir)

    val env: Map[String, String] = Map(
      // base override
      "JAVA_OPTS" -> jvmOptsEnv,
      // OpenJDK use this env
      "JAVA_TOOL_OPTIONS" -> jvmOptsEnv,
      // Maven mirror sometime contains invalid dependency and make us hard to debug the problem, use maven central only.
      "COURSIER_REPOSITORIES" -> "ivy2local|central",
      // Mill will fork process without inherit the JAVA_OPTS env
      "MILL_JVM_OPTS_PATH" -> millOptFile
    )
    targets.foreach(t =>
      os.proc(Seq("mill", "--no-server", t))
        .call(
          cwd = workDir.sourcePath,
          env = env
        )
    )

    workDir
  }
}
