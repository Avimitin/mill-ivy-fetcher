package in.avimit.dev.mif

import scala.io.AnsiColor._

object Logger {

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
