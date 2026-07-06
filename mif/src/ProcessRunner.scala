package in.avimit.dev.mif

import scala.util.control.NonFatal

case class ProcessResult(exitCode: Int, out: String, err: String)

object ProcessRunner {
  private def sanitize(arg: String): Unit = {
    if arg.contains('\n') || arg.contains('\u0000') then
      Logger.fatal(s"Invalid argument contains newline or null byte: ${arg}")
  }

  private def invalidArg(cmd: Seq[String]): Option[String] =
    cmd.find(arg => arg.exists(ch => ch == '\n' || ch == 0.toChar))

  /** Runs a command with stdio inherited from the current terminal so its
    * output streams live. Expected failures are values: a finished command
    * returns its exit code, a command that cannot start returns Left.
    * `propagateEnv = false` gives the child only the entries in `env`.
    */
  def runStreaming(
      cmd: Seq[String],
      cwd: os.Path,
      env: Map[String, String] = Map.empty,
      propagateEnv: Boolean = true
  ): Either[String, Int] =
    invalidArg(cmd) match {
      case Some(bad) =>
        Left(s"Invalid argument contains newline or null byte: ${bad}")
      case None =>
        try {
          val result = os
            .proc(cmd)
            .call(
              cwd = cwd,
              env = env,
              stdin = os.Inherit,
              stdout = os.Inherit,
              stderr = os.Inherit,
              check = false,
              propagateEnv = propagateEnv
            )
          Right(result.exitCode)
        } catch {
          case NonFatal(e) =>
            val command = cmd.headOption.getOrElse("<empty command>")
            val reason =
              Option(e.getMessage).getOrElse(e.getClass.getSimpleName)
            Left(s"Failed to start ${command}: ${reason}")
        }
    }

  def run(
      cmd: Seq[String],
      cwd: os.Path = os.pwd,
      env: Map[String, String] = Map.empty
  ): ProcessResult = {
    cmd.foreach(sanitize)
    try {
      val result = os.proc(cmd).call(cwd = cwd, env = env)
      ProcessResult(result.exitCode, result.out.trim(), result.err.trim())
    } catch {
      case e: os.SubprocessException =>
        Logger.error(s"Command failed: ${cmd.mkString(" ")}")
        Logger.error(s"Exit code: ${e.result.exitCode}")
        Logger.error(s"Working directory: ${cwd}")
        Logger.fatal(s"Process execution failed: ${e.getMessage}")
    }
  }
}
