package in.avimit.dev.mif

/** Build-tool specific behavior for `mif archive`. Implementations only advise;
  * they never block a run.
  */
trait BuildToolSupport:
  def name: String
  def preflightWarnings(projectDir: os.Path, command: Seq[String]): Seq[String]

object MillSupport extends BuildToolSupport:
  def name = "mill"

  private val daemonlessFlags =
    Set("--no-daemon", "--no-server", "-i", "--interactive")

  def preflightWarnings(
      projectDir: os.Path,
      command: Seq[String]
  ): Seq[String] =
    val flagWarning =
      if command.exists(daemonlessFlags.contains) then None
      else
        Some(
          "mill reuses a background daemon by default; pass `-i` or " +
            "`--no-daemon` after `--` so the archived run cannot reuse " +
            "daemon state from outside the sandbox"
        )

    val daemonDirs = Seq(
      projectDir / "out" / "mill-daemon",
      projectDir / "out" / "mill-server"
    )
    val daemonWarning =
      if daemonDirs.exists(os.exists) then
        Some(
          s"a mill daemon from a previous run may be reachable through ${projectDir / "out"}; " +
            "run `mill shutdown` in the project first so dependency downloads " +
            "cannot bypass the archive relay"
        )
      else None

    Seq(flagWarning, daemonWarning).flatten

object BuildTools:
  val supported: Map[String, BuildToolSupport] = Map("mill" -> MillSupport)

  /** Detects the build tool from the executable name, tolerating relative and
    * absolute invocations like `./mill` or `/nix/store/.../bin/mill`.
    */
  def detect(command: Seq[String]): Either[String, BuildToolSupport] =
    command.headOption match
      case None =>
        Left(
          "missing build command; usage: mif archive [flags] -- mill -i __.prepareOffline"
        )
      case Some(executable) =>
        val name = executable.split('/').last
        supported
          .get(name)
          .toRight(
            s"unsupported build tool '${name}'; supported tools: ${supported.keys.toSeq.sorted.mkString(", ")}"
          )

object CoursierMirror:
  /** Well-known base URLs that all serve Maven Central. Both are mirrored so
    * resolution cannot escape the relay through the alternate alias.
    */
  val CentralAliases: Seq[String] = Seq(
    "https://repo1.maven.org/maven2",
    "https://repo.maven.apache.org/maven2"
  )

  /** Renders a coursier mirror.properties that redirects the upstream (and its
    * aliases, for Maven Central) to the local relay.
    */
  def properties(
      upstream: String,
      relayBaseUrl: String
  ): Either[String, String] =
    MavenUpstream
      .validate(upstream)
      .map: uri =>
        val normalized = uri.toString.stripSuffix("/")
        val froms =
          if CentralAliases.contains(normalized) then CentralAliases
          else Seq(normalized)
        val to = relayBaseUrl.stripSuffix("/")
        froms.zipWithIndex
          .map((from, index) =>
            s"mif${index}.from=${from}\nmif${index}.to=${to}\n"
          )
          .mkString
