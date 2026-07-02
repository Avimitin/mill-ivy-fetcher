package in.avimit.dev.mif

import scala.io.AnsiColor._
import scala.util.DynamicVariable

class FatalException(message: String) extends Exception(message)

enum LogLevel(val priority: Int):
  case Trace extends LogLevel(0)
  case Info extends LogLevel(1)
  case Warn extends LogLevel(2)
  case Error extends LogLevel(3)
  case Quiet extends LogLevel(4)

object LogLevel:
  def fromString(value: String): LogLevel =
    value.trim.toLowerCase match
      case "trace"            => Trace
      case "info"             => Info
      case "warn" | "warning" => Warn
      case "error"            => Error
      case "quiet" | "off"    => Quiet
      case _                  => Quiet

object Logger:
  private val envLevel =
    LogLevel.fromString(sys.env.getOrElse("LOG_LEVEL", "INFO"))
  // Scoped, thread-local override used by tests and other temporary callers.
  private val overrideLevel = DynamicVariable[Option[LogLevel]](None)

  def withLevel[T](level: LogLevel)(body: => T): T =
    overrideLevel.withValue(Some(level))(body)

  private def currentLevel: LogLevel =
    overrideLevel.value.getOrElse(envLevel)

  private def enabled(level: LogLevel): Boolean =
    currentLevel.priority <= level.priority

  def trace(message: String): Unit =
    if enabled(LogLevel.Trace) then
      println(s"${BOLD}${BLUE}[TRACE]${RESET} ${message}")

  def info(message: String): Unit =
    if enabled(LogLevel.Info) then
      println(s"${BOLD}${GREEN}[INFO]${RESET} ${message}")

  def warning(message: String): Unit =
    if enabled(LogLevel.Warn) then
      println(s"${BOLD}${YELLOW}[WARNING]${RESET} ${message}")

  def error(message: String): Unit =
    if enabled(LogLevel.Error) then
      println(s"${BOLD}${RED}[ERROR]${RESET} ${message}")

  def fatal(message: String): Nothing =
    if enabled(LogLevel.Error) then
      println(s"${BOLD}${RED}[FATAL]${RESET} ${message}")
    throw new FatalException(message)
