package in.avimit.dev.mif

import mainargs.{main, ParserForMethods}
import mainargs.arg

object MillIvyFetcher {
  @main
  def fetch(
      @arg(short = 'p', name = "project-dir", doc = "specify project directory")
      projectDir: Option[String],
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String],
      @arg(short = 'c', name = "cache", doc = "specify project directory")
      cacheDir: Option[String]
  ) = {
    val param = PrepareParams(
      os.Path(projectDir.getOrElse("."), os.pwd),
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
      cacheDir: String,
      @arg(
        short = 'o',
        name = "codegen-path",
        doc = "Path to generated nix file"
      )
      codegenPath: String
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
      projectDir: Option[String],
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String],
      @arg(short = 'c', name = "cache", doc = "specify project directory")
      cacheDir: Option[String],
      @arg(
        short = 'o',
        name = "codegen-path",
        doc = "Path to generated nix file"
      )
      codegenPath: String
    ) = {
    val cachePath = fetch(projectDir, targets, cacheDir)
    codegen(cachePath.toString, codegenPath)
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
