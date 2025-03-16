package in.avimit.dev.mif

import mainargs.{main, ParserForMethods}
import mainargs.arg

object MillIvyFetcher {
  @main
  def fetch(
      @arg(short = 'c', doc = "change to dir")
      cwd: String,
      @arg(short = 't', doc = "list of mill build target to fetch")
      targets: Seq[String]
  ) = {
    val param = PrepareParams(
      os.Path(cwd, os.pwd),
      if targets.isEmpty then Seq("__") else targets
    )
    val fetcher = new PrepareRunner(param)
    val outPath = fetcher.run()
    Logger.info(s"deps downloaded into ${outPath}")
    outPath
  }

  @main()
  def codegen(
      @arg(
        short = 'i',
        name = "project-out-dir",
        doc = "out/ dir for a scala project"
      )
      projectOutDir: String,
      @arg(name = "cache-dir", doc = "Cache dir for downloading dependencies")
      cacheDir: String,
      @arg(
        short = 'o',
        name = "codegen-path",
        doc = "Path to generated nix file"
      )
      codegenPath: String
  ) = {
    val param = CodegenParams(
      os.Path(projectOutDir, os.pwd),
      os.Path(cacheDir, os.pwd),
      os.Path(codegenPath, os.pwd)
    )
    val generator = new Codegen(param)
    generator.run()
  }

  @main()
  def download(
      @arg(name = "dep", doc = "ivy dep full path")
      dep: String,
      @arg(name = "cache-path", doc = "cache path")
      cachePath: String
  ) = {
    Fetcher.fetch(
      os.Path(cachePath, os.pwd),
      Fetcher.parse(dep)
    )
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
