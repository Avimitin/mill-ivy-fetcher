package in.avimit.dev.mif

import scala.io.AnsiColor._

object Logger {

  val level = sys.env.getOrElse("LOG_LEVEL", "INFO") match
    case "TRACE" | "trace" => 0
    case "INFO" | "info"   => 1
    case "WARN" | "warn"   => 2
    case "ERROR" | "error" => 3
    case _                 => 4

  def trace(message: String) =
    if level <= 0 then println(s"${BOLD}${BLUE}[TRACE]${RESET} ${message}")

  def info(message: String) =
    if level <= 1 then println(s"${BOLD}${GREEN}[INFO]${RESET} ${message}")

  def warning(message: String) =
    if level <= 2 then println(s"${BOLD}${YELLOW}[WARNING]${RESET} ${message}")

  def error(message: String) =
    if level <= 3 then println(s"${BOLD}${RED}[ERROR]${RESET} ${message}")

  def fatal(message: String) =
    println(s"${BOLD}${RED}[FATAL]${RESET} ${message}")
    sys.exit(1)
}
