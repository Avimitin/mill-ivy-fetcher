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
    val param = FetcherParams(
      os.Path(cwd, os.pwd),
      if targets.isEmpty then Seq("__") else targets
    )
    val fetcher = new Fetcher(param)
    val outPath = fetcher.run()
    Logger.info(s"deps downloaded into ${outPath}")
    outPath
  }

  @main()
  def codegen() = {
    println("codegen")
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}
