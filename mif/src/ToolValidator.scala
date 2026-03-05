package in.avimit.dev.mif

object ToolValidator {
  def checkRequired(): Unit = {
    checkTool("mill", Seq("mill", "--version"))
    checkNixVersion()
  }

  private def checkTool(name: String, cmd: Seq[String]): Unit = {
    try {
      os.proc(cmd).call(stderr = os.Pipe)
    } catch {
      case _: Exception =>
        Logger.fatal(s"Required tool '${name}' not found in PATH")
    }
  }

  private def checkNixVersion(): Unit = {
    try {
      val output = os.proc(Seq("nix", "--version")).call().out.text().trim()
      val versionPattern = """nix \(Nix\) (\d+)\.(\d+)(?:\.\d+)?""".r
      output match {
        case versionPattern(major, minor) =>
          val majorInt = major.toInt
          val minorInt = minor.toInt
          if majorInt < 2 || (majorInt == 2 && minorInt < 28) then
            Logger.fatal(
              s"Nix version ${major}.${minor} is too old. Please upgrade to Nix >= 2.28"
            )
        case _ =>
          Logger.warning(s"Could not parse Nix version from: ${output}")
      }
    } catch {
      case _: Exception =>
        Logger.fatal("Required tool 'nix' not found in PATH")
    }
  }
}
