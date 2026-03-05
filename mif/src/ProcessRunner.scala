package in.avimit.dev.mif

case class ProcessResult(exitCode: Int, out: String, err: String)

object ProcessRunner {
  private def sanitize(arg: String): Unit = {
    if arg.contains('\n') || arg.contains('\u0000') then
      Logger.fatal(s"Invalid argument contains newline or null byte: ${arg}")
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
