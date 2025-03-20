package in.avimit.dev.mif

import mainargs.{main, ParserForMethods, arg, TokensReader}

object MillIvyFetcher {
  implicit object PathRead extends TokensReader.Simple[os.Path]:
    def shortName = "path"
    def read(strs: Seq[String]) = Right(os.Path(strs.head, os.pwd))

  @main
  def fetch(
      @arg(short = 'p', name = "project-dir", doc = "specify project directory")
      projectDir: os.Path,
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String],
      @arg(short = 'c', name = "cache", doc = "specify project directory")
      cacheDir: Option[os.Path]
  ) = {
    val param = PrepareParams(
      os.Path(projectDir, os.pwd),
      if targets.isEmpty then Seq("__") else targets,
      cacheDir.map(os.Path(_, os.pwd))
    )
    val fetcher = new PrepareRunner(param)
    val outPath = fetcher.run()
    Logger.info(s"deps downloaded into ${outPath}")
    outPath
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
      jsonPath: Option[os.Path]
  ): Unit = {
    val projectDirPath = projectDir.getOrElse(os.pwd)
    val projectHash = NixNarHash.run(Seq(projectDirPath))(projectDirPath)
    val prefix = "# Project Source Hash:"

    if os.exists(codegenPath) then
      val lastLineOfLockFile =
        os.read(codegenPath).lines().toList().getLast().strip()

      if lastLineOfLockFile.startsWith(prefix)
        && lastLineOfLockFile.contains(projectHash)
      then
        Logger.info(
          s"Source hash of ${projectDirPath} match lock file ${codegenPath}, skip codegen"
        )
        return ()

    val cachePath = fetch(projectDirPath, targets, cacheDir)
    codegen(cachePath, codegenPath)

    os.write.append(codegenPath, s"${prefix}${projectHash}")

    jsonPath.foreach(path => {
      os.write(
        os.Path(path, os.pwd),
        upickle.default.write(
          Map(
            "cachePath" -> cachePath.toString
          )
        )
      )
    })
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
