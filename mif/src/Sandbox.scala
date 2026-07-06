package in.avimit.dev.mif

import java.util.Locale

import scala.util.control.NonFatal

enum SandboxMode:
  case Bwrap, Disabled

object SandboxMode:
  def parse(value: String): Either[String, SandboxMode] =
    value.trim.toLowerCase match
      case "bwrap" => Right(Bwrap)
      case "none"  => Right(Disabled)
      case other =>
        Left(
          s"invalid sandbox mode '${other}'; valid values: bwrap, none"
        )

/** How the build command will be isolated. Warnings are surfaced to the user
  * before the build runs.
  */
enum SandboxStrategy(val warnings: Seq[String]):
  case Bwrap extends SandboxStrategy(Seq.empty)
  case CleanEnvOnly(reasons: Seq[String]) extends SandboxStrategy(reasons)

object SandboxStrategy:
  private val cleanEnvWarning =
    "running without filesystem isolation; host caches or configuration may leak into the archived lock"

  def resolve(mode: SandboxMode): Either[String, SandboxStrategy] =
    resolve(
      mode,
      isLinux = sys.props
        .getOrElse("os.name", "")
        .toLowerCase(Locale.ROOT)
        .contains("linux"),
      probe = () => BubblewrapSandbox.probe(sys.env)
    )

  /** Pure decision matrix; the bubblewrap probe is injected for testability.
    * Linux is strict: an unusable bwrap is an error rather than a silent
    * downgrade, because a degraded run can record an incomplete lock.
    */
  private[mif] def resolve(
      mode: SandboxMode,
      isLinux: Boolean,
      probe: () => Either[String, Unit]
  ): Either[String, SandboxStrategy] =
    mode match
      case SandboxMode.Disabled =>
        Right(CleanEnvOnly(Seq(cleanEnvWarning)))
      case SandboxMode.Bwrap if !isLinux =>
        Left(
          "--sandbox bwrap requires Linux; bubblewrap has no support for this platform. Use --sandbox none to run without filesystem isolation."
        )
      case SandboxMode.Bwrap =>
        probe() match
          case Right(()) => Right(Bwrap)
          case Left(reason) =>
            Left(
              s"bubblewrap sandbox is unavailable: ${reason}. " +
                "Install bubblewrap (provided by the dev shell) or pass " +
                "--sandbox none to run without filesystem isolation."
            )

object SandboxEnv:
  private val bwrapPassthroughKeys = Seq(
    "JAVA_HOME",
    "SSL_CERT_FILE",
    "NIX_SSL_CERT_FILE"
  )

  private val cleanEnvPassthroughKeys = Seq(
    "TERM",
    "LANG",
    "LC_ALL",
    "LC_CTYPE",
    "JAVA_HOME",
    "SSL_CERT_FILE",
    "NIX_SSL_CERT_FILE"
  )

  private val ignoredKeys = Seq(
    "JAVA_TOOL_OPTIONS",
    "JAVA_OPTS",
    "COURSIER_CACHE",
    "COURSIER_CONFIG_DIR",
    "COURSIER_MIRRORS",
    "COURSIER_REPOSITORIES",
    "XDG_CACHE_HOME",
    "XDG_CONFIG_HOME",
    "XDG_DATA_HOME"
  )

  def mirrorFile(sandboxHome: os.Path): os.Path =
    sandboxHome / ".config" / "coursier" / "mirror.properties"

  def coursierCache(sandboxHome: os.Path): os.Path =
    sandboxHome / ".cache" / "coursier"

  def ivyHome(sandboxHome: os.Path): os.Path =
    sandboxHome / ".ivy2"

  def mavenLocalRepository(sandboxHome: os.Path): os.Path =
    sandboxHome / ".m2" / "repository"

  def build(
      strategy: SandboxStrategy,
      parentEnv: Map[String, String],
      sandboxHome: os.Path
  ): (Map[String, String], Seq[String]) =
    strategy match
      case SandboxStrategy.Bwrap => buildBwrap(parentEnv, sandboxHome)
      case SandboxStrategy.CleanEnvOnly(_) =>
        buildCleanEnv(parentEnv, sandboxHome)

  /** Minimal environment for the bwrap child. Coursier uses its default config
    * and cache locations under `user.home`, which JAVA_TOOL_OPTIONS points at
    * the clean sandbox home.
    */
  private[mif] def buildBwrap(
      parentEnv: Map[String, String],
      sandboxHome: os.Path
  ): (Map[String, String], Seq[String]) =
    val ignored = ignoredKeys.filter(parentEnv.contains)
    val warnings = ignored.map(key =>
      s"environment variable ${key} is set but ignored inside the archive sandbox"
    )

    val pathEntry = parentEnv.get("PATH").map("PATH" -> _).toMap
    val passthrough = bwrapPassthroughKeys
      .flatMap(key => parentEnv.get(key).map(key -> _))
      .toMap

    val env = passthrough ++ pathEntry ++ Map(
      "HOME" -> bwrapHome.toString,
      "JAVA_TOOL_OPTIONS" -> javaToolOptions(bwrapHome)
    )

    (env, warnings)

  /** Explicit unsafe fallback mode. This still has to redirect Coursier through
    * environment variables because no filesystem sandbox is present.
    */
  private[mif] def buildCleanEnv(
      parentEnv: Map[String, String],
      sandboxHome: os.Path
  ): (Map[String, String], Seq[String]) =
    val ignored = ignoredKeys.filter(parentEnv.contains)
    val warnings = ignored.map(key =>
      s"environment variable ${key} is set but ignored inside the archive sandbox"
    )

    val pathEntry = parentEnv.get("PATH").map("PATH" -> _).toMap
    val passthrough = cleanEnvPassthroughKeys
      .flatMap(key => parentEnv.get(key).map(key -> _))
      .toMap

    val env = passthrough ++ pathEntry ++ Map(
      "HOME" -> sandboxHome.toString,
      "XDG_CACHE_HOME" -> (sandboxHome / ".cache").toString,
      "XDG_CONFIG_HOME" -> (sandboxHome / ".config").toString,
      "XDG_DATA_HOME" -> (sandboxHome / ".local" / "share").toString,
      "COURSIER_CACHE" -> coursierCache(sandboxHome).toString,
      "COURSIER_MIRRORS" -> mirrorFile(sandboxHome).toString,
      "JAVA_TOOL_OPTIONS" -> javaToolOptions(sandboxHome)
    )

    (env, warnings)

  /** JVM options every spawned JVM picks up. `-Duser.home` matters because the
    * JVM derives user.home from /etc/passwd, not $HOME.
    */
  def javaToolOptions(sandboxHome: os.Path): String =
    Seq(s"-Duser.home=${sandboxHome}").map(quoteIfNeeded).mkString(" ")

  private def quoteIfNeeded(option: String): String =
    if option.exists(_.isWhitespace) then s"\"${option}\"" else option

  val bwrapHome: os.Path = os.Path("/mif")

  val bwrapWorkDir: os.Path = os.Path("/workdir")

object BubblewrapSandbox:
  case class Spec(
      projectDir: os.Path,
      sandboxHome: os.Path,
      env: Map[String, String],
      command: Seq[String]
  )

  /** The bwrap invocation starts from an empty tmpfs root. The project is
    * mounted at /workdir and mif's generated home/cache/config tree is mounted
    * at /mif. Host toolchain roots are exposed read-only so commands from the
    * inherited PATH still work for normal system and Nix dev-shell binaries,
    * without exposing the whole host filesystem.
    *
    * The network namespace stays shared so the child reaches the relay on
    * 127.0.0.1. `--unshare-pid` makes bwrap PID 1 of the sandbox: any daemon
    * the build forks dies when the build command exits.
    */
  def argv(spec: Spec): Seq[String] =
    val mounts = Seq(
      "--die-with-parent",
      "--unshare-pid",
      "--tmpfs",
      "/"
    ) ++ readOnlyToolchainMounts ++ Seq(
      "--dev",
      "/dev",
      "--proc",
      "/proc",
      "--dir",
      "/tmp",
      "--bind",
      spec.projectDir.toString,
      SandboxEnv.bwrapWorkDir.toString,
      "--bind",
      spec.sandboxHome.toString,
      SandboxEnv.bwrapHome.toString,
      "--chdir",
      SandboxEnv.bwrapWorkDir.toString,
      "--clearenv"
    )

    val envArgs = spec.env.toSeq.sortBy(_._1).flatMap { (key, value) =>
      Seq("--setenv", key, value)
    }

    Seq("bwrap") ++ mounts ++ envArgs ++ Seq("--") ++ spec.command

  private val readOnlyToolchainMounts: Seq[String] =
    Seq(
      dir("/bin"),
      bindTry("/bin"),
      dir("/lib"),
      bindTry("/lib"),
      dir("/lib64"),
      bindTry("/lib64"),
      dir("/usr"),
      bindTry("/usr"),
      dir("/nix"),
      bindTry("/nix/store"),
      dir("/run"),
      dir("/run/current-system"),
      bindTry("/run/current-system/sw"),
      dir("/etc"),
      bindTry("/etc/ssl"),
      bindTry("/etc/pki")
    ).flatten

  private def dir(path: String): Seq[String] =
    Seq("--dir", path)

  private def bindTry(path: String): Seq[String] =
    Seq("--ro-bind-try", path, path)

  /** Runs a trivial command through the same argv shape the real build uses.
    * Catches a missing bwrap binary as well as blocked user or PID namespaces
    * (for example under restrictive container seccomp profiles).
    */
  def probe(parentEnv: Map[String, String]): Either[String, Unit] =
    createProbeDir().flatMap { probeDir =>
      try runProbe(probeDir, parentEnv)
      finally bestEffortDelete(probeDir)
    }

  private def createProbeDir(): Either[String, os.Path] =
    try Right(os.temp.dir(prefix = "mif-bwrap-probe-"))
    catch case NonFatal(e) => Left(errorMessage(e))

  private def runProbe(
      probeDir: os.Path,
      parentEnv: Map[String, String]
  ): Either[String, Unit] =
    try
      val spec = Spec(
        projectDir = probeDir,
        sandboxHome = probeDir,
        env = Map("PATH" -> parentEnv.getOrElse("PATH", "/usr/bin:/bin")),
        command = Seq("/bin/sh", "-c", "true")
      )
      val result = os
        .proc(argv(spec))
        .call(
          cwd = os.pwd,
          check = false,
          stdout = os.Pipe,
          stderr = os.Pipe
        )
      if result.exitCode == 0 then Right(())
      else
        val stderr = result.err.trim()
        Left(
          if stderr.nonEmpty then stderr
          else s"bwrap probe exited with code ${result.exitCode}"
        )
    catch case NonFatal(e) => Left(errorMessage(e))

  private def bestEffortDelete(path: os.Path): Unit =
    try os.remove.all(path)
    catch case NonFatal(_) => ()

  private def errorMessage(e: Throwable): String =
    Option(e.getMessage).getOrElse(e.getClass.getSimpleName)
