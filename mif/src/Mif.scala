package in.avimit.dev.mif

import mainargs.{main, ParserForMethods}
import mainargs.arg

object Logger {
  import scala.io.AnsiColor._

  val level = sys.env.getOrElse("LOG_LEVEL", "INFO") match
    case "TRACE" | "trace" => 0
    case "ERROR" | "error" => 1
    case "INFO" | "info"   => 2
    case _                 => 4

  def info(message: String) =
    if level <= 2 then println(s"${BOLD}${GREEN}[INFO]${RESET} ${message}")

  def trace(message: String) =
    if level <= 0 then println(s"${BOLD}${GREEN}[TRACE]${RESET} ${message}")

  def error(message: String) =
    if level <= 2 then println(s"${BOLD}${RED}[ERROR]${RESET} ${message}")

  def fatal(message: String) =
    println(s"${BOLD}${RED}[FATAL]${RESET} ${message}")
    sys.exit(1)
}

object MillIvyFetcher {
  @main
  def fetch(
      @arg(short = 'c', doc = "change to dir")
      cwd: String
  ) = {
    val param = FetcherParams(os.Path(cwd, os.pwd), Seq("__"))
    val fetcher = new Fetcher(param)
    val outPath = fetcher.run()
    Logger.info(s"deps downloaded into ${outPath}")
  }

  @main()
  def dump() = {
    println("dump")
  }

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args.toSeq)
}

case class FetcherParams(
    projectRoot: os.Path,
    fetchTargets: Seq[String]
)

class Fetcher(parameter: FetcherParams) {
  import parameter.*

  def jvm_opt_to_set(env_key: String): Map[String, String] = {
    sys.env.get(env_key) match
      case Some(raw) if raw.nonEmpty => {
        Logger.info(s"Using env ${env_key}: '${raw}'")
        raw
          .strip()
          .split(" ")
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
    if os.exists(projectRoot / "out") then {
      os.remove.all(projectRoot / "out")
    }

    val cacheDir = projectRoot / "out" / ".ivyCache"

    val targets = fetchTargets.map(t => s"${t}.prepareOffline")
      ++ fetchTargets.map(t => s"${t}.scalaCompilerClasspath")
      ++ fetchTargets.map(t => s"${t}.scalaDocClasspath")

    val (jvmOptsEnv, millOptFile) = handleEnv(cacheDir)

    os.proc(Seq("mill", "--no-server") ++ targets)
      .call(
        cwd = projectRoot,
        env = Map(
          // base override
          "JAVA_OPTS" -> jvmOptsEnv,
          // OpenJDK use this env
          "JAVA_TOOL_OPTIONS" -> jvmOptsEnv,
          // Maven mirror sometime contains invalid dependency and make us hard to debug the problem, use maven central only.
          "COURSIER_REPOSITORIES" -> "ivy2local|central",
          // Mill will fork process without inherit the JAVA_OPTS env
          "MILL_JVM_OPTS_PATH" -> millOptFile
        )
      )

    cacheDir
  }
}
