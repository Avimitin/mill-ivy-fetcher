package in.avimit.dev.mif

import java.util.concurrent.atomic.AtomicBoolean

import scala.util.control.NonFatal

case class ArchiveParams(
    projectDir: os.Path,
    repoDir: os.Path,
    lockPath: os.Path,
    upstream: String,
    proxyUrl: Option[String],
    host: String,
    port: Int,
    sandboxMode: SandboxMode,
    keepWorkdir: Boolean,
    fresh: Boolean,
    connectTimeoutSeconds: Int,
    requestTimeoutSeconds: Int,
    command: Seq[String]
)

case class LockUpdateSummary(
    totalFiles: Int,
    newFiles: Int,
    runs: Int
)

object ArchiveRunner:
  private def errorMessage(e: Throwable): String =
    Option(e.getMessage).getOrElse(e.getClass.getSimpleName)

  def run(params: ArchiveParams): Either[String, LockUpdateSummary] =
    for
      tool <- BuildTools.detect(params.command)
      _ = tool
        .preflightWarnings(params.projectDir, params.command)
        .foreach(Logger.warning)
      strategy <- SandboxStrategy.resolve(params.sandboxMode)
      _ = strategy.warnings.foreach(Logger.warning)
      accessed <- runBuildThroughRelay(params, strategy)
      _ =
        if accessed.isEmpty then
          Logger.warning(
            "no Maven files were requested through the relay; did the build resolve anything?"
          )
      summary <- updateLock(
        lockPath = params.lockPath,
        runFiles = accessed,
        upstream = params.upstream,
        run = LockRun.fromCommand(params.command),
        fresh = params.fresh
      )
    yield summary

  private def runBuildThroughRelay(
      params: ArchiveParams,
      strategy: SandboxStrategy
  ): Either[String, Seq[MavenRepositoryFile]] =
    withSandboxHome(params.keepWorkdir) { sandboxHome =>
      for
        accessed <- withRelay(params) { handle =>
          runBuildWithRelay(params, strategy, sandboxHome, handle)
        }
        files <- lookupFiles(params.repoDir, accessed)
      yield files
    }

  private def runBuildWithRelay(
      params: ArchiveParams,
      strategy: SandboxStrategy,
      sandboxHome: os.Path,
      handle: MavenRelayHandle
  ): Either[String, Seq[String]] =
    for
      mirror <- CoursierMirror.properties(
        params.upstream,
        handle.baseUrl
      )
      _ <- writeMirrorFile(SandboxEnv.mirrorFile(sandboxHome), mirror)
      (env, envWarnings) = SandboxEnv.build(strategy, sys.env, sandboxHome)
      _ = envWarnings.foreach(Logger.warning)
      exitCode <- executeBuild(params, strategy, sandboxHome, env)
      _ <-
        if exitCode == 0 then Right(())
        else
          Left(
            s"build command exited with code ${exitCode}; lock not updated"
          )
    yield handle.accessedPaths

  private def withSandboxHome[T](keep: Boolean)(
      body: os.Path => Either[String, T]
  ): Either[String, T] =
    createSandboxHome().flatMap { sandboxHome =>
      try body(sandboxHome)
      finally cleanupSandboxHome(sandboxHome, keep)
    }

  private def withRelay[T](params: ArchiveParams)(
      body: MavenRelayHandle => Either[String, T]
  ): Either[String, T] =
    val config = MavenRelayConfig(
      repoDir = params.repoDir,
      upstreamBaseUrl = params.upstream,
      proxyUrl = params.proxyUrl,
      connectTimeoutSeconds = params.connectTimeoutSeconds,
      requestTimeoutSeconds = params.requestTimeoutSeconds
    )
    MavenRelayServer.start(params.host, params.port, config).flatMap { handle =>
      val closed = AtomicBoolean(false)
      def closeOnce(): Unit =
        if closed.compareAndSet(false, true) then handle.close()
      // The hook guards Ctrl-C during the build; close is idempotent so
      // the normal path can also close eagerly.
      RuntimeHooks
        .addShutdownHook(() => closeOnce())
        .left
        .foreach(Logger.warning)
      try body(handle)
      finally closeOnce()
    }

  private def executeBuild(
      params: ArchiveParams,
      strategy: SandboxStrategy,
      sandboxHome: os.Path,
      env: Map[String, String]
  ): Either[String, Int] =
    strategy match
      case SandboxStrategy.Bwrap =>
        val spec = BubblewrapSandbox.Spec(
          projectDir = params.projectDir,
          sandboxHome = sandboxHome,
          env = env,
          command = params.command
        )
        // bwrap itself runs with the parent environment so the binary
        // resolves through PATH; --clearenv wipes it for the child, which
        // only sees the --setenv allowlist.
        ProcessRunner.runStreaming(
          BubblewrapSandbox.argv(spec),
          cwd = params.projectDir
        )
      case SandboxStrategy.CleanEnvOnly(_) =>
        ProcessRunner.runStreaming(
          params.command,
          cwd = params.projectDir,
          env = env,
          propagateEnv = false
        )

  private[mif] def lookupFiles(
      repoDir: os.Path,
      paths: Seq[String]
  ): Either[String, Seq[MavenRepositoryFile]] =
    withRepositoryStore(repoDir) { store =>
      paths.foldLeft[Either[String, Vector[MavenRepositoryFile]]](
        Right(Vector.empty)
      ) { (acc, path) =>
        for
          files <- acc
          found <- store.find(path)
          file <- found.toRight(
            s"artifact ${path} was served by the relay but is missing from the repository database ${store.dbPath}"
          )
        yield files :+ file
      }
    }

  private def withRepositoryStore[T](repoDir: os.Path)(
      body: MavenRepositoryStore => Either[String, T]
  ): Either[String, T] =
    MavenRepositoryStore.open(repoDir).flatMap { store =>
      try body(store)
      finally store.close()
    }

  private def createSandboxHome(): Either[String, os.Path] =
    try
      val home =
        os.temp.dir(prefix = "mif-archive-home-", deleteOnExit = false)
      os.makeDir.all(SandboxEnv.mirrorFile(home) / os.up)
      os.makeDir.all(SandboxEnv.coursierCache(home))
      os.makeDir.all(home / ".local" / "share")
      os.makeDir.all(SandboxEnv.ivyHome(home))
      os.makeDir.all(SandboxEnv.mavenLocalRepository(home))
      Right(home)
    catch
      case NonFatal(e) =>
        Left(s"failed to create sandbox home: ${errorMessage(e)}")

  private def writeMirrorFile(
      file: os.Path,
      content: String
  ): Either[String, Unit] =
    try
      os.makeDir.all(file / os.up)
      os.write.over(file, content)
      Logger.trace(s"coursier mirror file at ${file}:\n${content}")
      Right(())
    catch
      case NonFatal(e) =>
        Left(
          s"failed to write coursier mirror file ${file}: ${errorMessage(e)}"
        )

  private def cleanupSandboxHome(home: os.Path, keep: Boolean): Unit =
    if keep then Logger.info(s"Keeping sandbox home ${home}")
    else
      try os.remove.all(home)
      catch
        case NonFatal(e) =>
          Logger.warning(
            s"failed to delete sandbox home ${home}: ${errorMessage(e)}"
          )

  /** Merges the files of one archive run into the lock on disk. Unit testable
    * without a relay or sandbox.
    */
  def updateLock(
      lockPath: os.Path,
      runFiles: Seq[MavenRepositoryFile],
      upstream: String,
      run: LockRun,
      fresh: Boolean
  ): Either[String, LockUpdateSummary] =
    for
      repository <- Lock.repositoryFor(upstream)
      existing <- if fresh then Right(None) else Lock.read(lockPath)
      base = existing.getOrElse(Lock.empty)
      merged <- Lock.merge(base, repository, runFiles, run)
      _ <- Lock.write(lockPath, merged)
    yield LockUpdateSummary(
      totalFiles = merged.files.size,
      newFiles = merged.files.size - base.files.size,
      runs = merged.runs.size
    )
