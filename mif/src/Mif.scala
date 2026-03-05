package in.avimit.dev.mif

import mainargs.{main, ParserForMethods, arg, TokensReader, Flag}

object MillIvyFetcher {
  val VERSION = "0.3.0"

  implicit object PathRead extends TokensReader.Simple[os.Path]:
    def shortName = "path"
    def read(strs: Seq[String]) = Right(os.Path(strs.head, os.pwd))

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
      Logger.fatal(s"Project directory does not exist or is not a directory: ${projPath}")

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
      Logger.fatal(s"Project directory does not exist or is not a directory: ${projectDirPath}")

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
      val prepareResult = fetch(projectDirPath, targets, cacheDir, keepWorkDir, dryRun)
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

  private def getMillVersion(projectDir: os.Path): String =
    ProcessRunner
      .run(Seq("mill", "--version"), cwd = projectDir)
      .out
      .linesIterator
      .next()

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
