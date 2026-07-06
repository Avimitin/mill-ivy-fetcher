package in.avimit.dev.mif

import mainargs.{main, ParserForMethods, arg, TokensReader, Flag, Leftover}

object MillIvyFetcher {
  val VERSION = "0.3.0"

  implicit object PathRead extends TokensReader.Simple[os.Path]:
    def shortName = "path"
    def read(strs: Seq[String]) = Right(os.Path(strs.head, os.pwd))

  implicit object SandboxModeRead extends TokensReader.Simple[SandboxMode]:
    def shortName = "sandbox-mode"
    def read(strs: Seq[String]) = SandboxMode.parse(strs.head)

  // Exceptions thrown inside a command are caught by mainargs and rendered
  // with a stack trace; exiting directly keeps expected failures clean.
  private def archiveFail(reason: String): Nothing =
    Logger.error(reason)
    sys.exit(1)

  private[mif] def archiveCommandArgs(command: Leftover[String]): Seq[String] =
    val args = command.value match
      case Seq("--", args*) => args
      case args             => args
    args.filterNot(hasInvalidCommandChar)

  private def hasInvalidCommandChar(arg: String): Boolean =
    arg.exists(ch => ch == '\n' || ch == 0.toChar)

  @main
  def version(): Unit = {
    println(s"mill-ivy-fetcher version ${VERSION}")
  }

  @main
  def fetch(
      @arg(short = 'p', name = "project-dir", doc = "specify project directory")
      projectDir: os.Path,
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String],
      @arg(short = 'c', name = "cache", doc = "specify project directory")
      cacheDir: Option[os.Path],
      @arg(
        name = "keep-workdir",
        doc = "keep the temporary working directory, default delete on exit"
      )
      keepWorkDir: Flag = Flag(false),
      @arg(name = "dry-run", doc = "show what would be done without executing")
      dryRun: Flag = Flag(false)
  ) = {
    ToolValidator.checkRequired()

    val projPath = os.Path(projectDir, os.pwd)
    if !os.exists(projPath) || !os.isDir(projPath) then
      Logger.fatal(
        s"Project directory does not exist or is not a directory: ${projPath}"
      )

    Logger.info(s"Running mif fetch for ${projPath}")
    val param = PrepareParams(
      projPath,
      if targets.isEmpty then Seq("__") else targets,
      cacheDir.map(os.Path(_, os.pwd)),
      keepWorkDir.value,
      dryRun.value
    )
    val fetcher = new PrepareRunner(param)
    val result = fetcher.run()
    Logger.info(s"Downloaded deps into ${result.workDir}")
    result
  }

  @main()
  def codegen(
      @arg(name = "cache", doc = "Cache dir for downloading dependencies")
      cacheDir: os.Path,
      @arg(
        short = 'o',
        name = "codegen-path",
        doc = "Path to generated nix file"
      )
      codegenPath: os.Path
  ) = {
    Logger.info(s"Running codegen for cache directory ${cacheDir}")
    val param = CodegenParams(
      os.Path(cacheDir, os.pwd),
      os.Path(codegenPath, os.pwd)
    )
    val generator = new Codegen(param)
    generator.run()
  }

  @main()
  def relay(
      @arg(name = "host", doc = "Host interface for the relay server")
      host: String = "127.0.0.1",
      @arg(short = 'p', name = "port", doc = "Port for the relay server")
      port: Int = 8081,
      @arg(
        short = 'r',
        name = "repo-dir",
        doc = "Local Maven repository directory used to archive files"
      )
      repoDir: os.Path = os.pwd / ".mif" / "repository",
      @arg(
        short = 'u',
        name = "upstream",
        doc = "Maven-compatible upstream base URL"
      )
      upstream: String = MavenRelayServer.DefaultUpstream,
      @arg(
        name = "proxy",
        doc =
          "HTTP proxy URL for upstream requests, for example http://127.0.0.1:8080"
      )
      proxy: Option[String] = None,
      @arg(
        name = "connect-timeout-seconds",
        doc = "Timeout for connecting to the upstream repository"
      )
      connectTimeoutSeconds: Int = 30,
      @arg(
        name = "request-timeout-seconds",
        doc = "Timeout for each upstream repository request"
      )
      requestTimeoutSeconds: Int = 120
  ): Unit = {
    val config = MavenRelayConfig(
      repoDir = repoDir,
      upstreamBaseUrl = upstream,
      proxyUrl = proxy,
      connectTimeoutSeconds = connectTimeoutSeconds,
      requestTimeoutSeconds = requestTimeoutSeconds
    )

    MavenRelayServer.run(host, port, config)
  }

  @main()
  def archive(
      @arg(short = 'p', name = "project-dir", doc = "specify project directory")
      projectDir: Option[os.Path],
      @arg(
        name = "lock",
        doc =
          "JSON lock file to create or append, default <project-dir>/mif.lock.json"
      )
      lock: Option[os.Path],
      @arg(
        short = 'r',
        name = "repo-dir",
        doc =
          "Local Maven repository directory used to archive files, default <project-dir>/.mif/repository"
      )
      repoDir: Option[os.Path],
      @arg(name = "host", doc = "Host interface for the archive relay")
      host: String = "127.0.0.1",
      @arg(
        name = "port",
        doc = "Port for the archive relay, 0 picks a free port"
      )
      port: Int = 0,
      @arg(
        short = 'u',
        name = "upstream",
        doc = "Maven-compatible upstream base URL"
      )
      upstream: String = MavenRelayServer.DefaultUpstream,
      @arg(
        name = "proxy",
        doc =
          "HTTP proxy URL for upstream requests, for example http://127.0.0.1:8080"
      )
      proxy: Option[String] = None,
      @arg(
        name = "sandbox",
        doc = "Sandbox mode for the build command: bwrap or none"
      )
      sandbox: SandboxMode = SandboxMode.Bwrap,
      @arg(
        name = "fresh",
        doc = "rebuild the lock from this run only instead of appending"
      )
      fresh: Flag = Flag(false),
      @arg(
        name = "keep-workdir",
        doc = "keep the temporary sandbox home, default delete on exit"
      )
      keepWorkdir: Flag = Flag(false),
      @arg(
        name = "connect-timeout-seconds",
        doc = "Timeout for connecting to the upstream repository"
      )
      connectTimeoutSeconds: Int = 30,
      @arg(
        name = "request-timeout-seconds",
        doc = "Timeout for each upstream repository request"
      )
      requestTimeoutSeconds: Int = 120,
      command: Leftover[String]
  ): Unit = {
    val projectDirPath = projectDir.getOrElse(os.pwd)
    if !os.exists(projectDirPath) || !os.isDir(projectDirPath) then
      archiveFail(
        s"Project directory does not exist or is not a directory: ${projectDirPath}"
      )

    val commandArgs = archiveCommandArgs(command)

    val lockPath = lock.getOrElse(projectDirPath / Lock.DefaultFileName)
    val params = ArchiveParams(
      projectDir = projectDirPath,
      repoDir = repoDir.getOrElse(projectDirPath / ".mif" / "repository"),
      lockPath = lockPath,
      upstream = upstream,
      proxyUrl = proxy,
      host = host,
      port = port,
      sandboxMode = sandbox,
      keepWorkdir = keepWorkdir.value,
      fresh = fresh.value,
      connectTimeoutSeconds = connectTimeoutSeconds,
      requestTimeoutSeconds = requestTimeoutSeconds,
      command = commandArgs
    )

    ArchiveRunner.run(params) match
      case Left(reason) => archiveFail(reason)
      case Right(summary) =>
        Logger.info(
          s"Lock ${lockPath} now tracks ${summary.totalFiles} files " +
            s"(${summary.newFiles} new) from ${summary.runs} command(s)"
        )
  }

  @main()
  def run(
      @arg(short = 'p', name = "project-dir", doc = "specify project directory")
      projectDir: Option[os.Path],
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String],
      @arg(short = 'c', name = "cache", doc = "specify project directory")
      cacheDir: Option[os.Path],
      @arg(
        short = 'o',
        name = "codegen-path",
        doc = "Path to generated nix file"
      )
      codegenPath: os.Path,
      @arg(
        short = 'j',
        name = "json-path",
        doc = "Output information in JSON format, useful for scripting"
      )
      jsonPath: Option[os.Path],
      @arg(
        name = "keep-workdir",
        doc = "keep the temporary working directory, default delete on exit"
      )
      keepWorkDir: Flag = Flag(false),
      @arg(doc = "force regenerate lock file")
      force: Flag = Flag(false),
      @arg(name = "dry-run", doc = "show what would be done without executing")
      dryRun: Flag = Flag(false)
  ): Unit = {
    ToolValidator.checkRequired()

    val projectDirPath = projectDir.getOrElse(os.pwd)
    if !os.exists(projectDirPath) || !os.isDir(projectDirPath) then
      Logger.fatal(
        s"Project directory does not exist or is not a directory: ${projectDirPath}"
      )

    val projectHash = NixNarHash.run(Seq(projectDirPath))(projectDirPath)
    val prefix = "# Cache Identifier:"

    val shouldSkip =
      !force.value && os.exists(codegenPath) &&
        parseLastLine(codegenPath, prefix).filter {
          case (storedHash, storedMillVer) =>
            val currentMillVer = getMillVersion(projectDirPath)
            storedHash == projectHash && storedMillVer == currentMillVer
        }.isDefined

    if shouldSkip then
      Logger.info(
        s"Cache identifier match lock file ${codegenPath}, skip codegen"
      )
    else
      val prepareResult =
        fetch(projectDirPath, targets, cacheDir, keepWorkDir, dryRun)
      val cacheKey = s"${projectHash}@${prepareResult.millVersion}"

      if dryRun.value then
        Logger.info(s"Dry-run mode: would generate lock file at ${codegenPath}")
        Logger.info(s"Dry-run mode: cache key would be ${cacheKey}")
      else
        codegen(prepareResult.workDir.ivyCachePath, codegenPath)
        os.write.append(codegenPath, s"${prefix}${cacheKey}\n")

        jsonPath.foreach(path =>
          os.write(
            os.Path(path, os.pwd),
            upickle.default.write(prepareResult.toMap())
          )
        )
  }

  private def parseLastLine(
      codegenPath: os.Path,
      prefix: String
  ): Option[(String, String)] =
    os.read(codegenPath)
      .lines()
      .toList()
      .getLast()
      .strip()
      .stripPrefix(prefix)
      .split("@", 2) match
      case Array(hash, millVer) => Some((hash, millVer))
      case _                    => None

  private def getMillVersion(projectDir: os.Path): String = {
    val tempDir = os.temp.dir(prefix = s"${projectDir.last}_version_check_")
    try {
      ProcessRunner
        .run(Seq("mill", "--version"), cwd = tempDir)
        .out
        .linesIterator
        .next()
    } finally {
      os.remove.all(tempDir)
    }
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
