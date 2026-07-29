package in.avimit.dev.mtf

import scala.util.control.NonFatal

/** Computes the recursive NAR hashes used by artifact-level fixed-output
  * derivations. Each staging root has exactly the Maven subtree that the Nix
  * builder will produce, so `nix hash path` remains the source of truth for NAR
  * serialization. This runs after the build and relay have stopped: until then,
  * another file for the same Maven coordinate may still be requested.
  */
object ArtifactNarHash:
  def hashMissing(
      repoDir: os.Path,
      lock: MtfLock
  ): Either[String, Map[String, String]] =
    val artifactDirs = Lock.missingArtifactNarHashes(lock)
    if artifactDirs.isEmpty then Right(Map.empty)
    else stageAndHash(repoDir, lock.files, artifactDirs)

  private def stageAndHash(
      repoDir: os.Path,
      files: Vector[LockedFile],
      artifactDirs: Vector[String]
  ): Either[String, Map[String, String]] =
    createStagingDirectory(repoDir).flatMap: stagingDir =>
      try
        for
          roots <- stageArtifacts(repoDir, stagingDir, files, artifactDirs)
          hashes <- nixHashPaths(roots)
        yield artifactDirs.zip(hashes).toMap
      finally bestEffortDelete(stagingDir)

  private def createStagingDirectory(
      repoDir: os.Path
  ): Either[String, os.Path] =
    try
      val metadataDir = repoDir / MavenRepositoryStore.MetadataDirectoryName
      os.makeDir.all(metadataDir)
      Right(
        os.temp.dir(
          dir = metadataDir,
          prefix = ".nar-hash-",
          deleteOnExit = false
        )
      )
    catch
      case NonFatal(e) =>
        Left(s"failed to create NAR hash staging directory: ${message(e)}")

  private def stageArtifacts(
      repoDir: os.Path,
      stagingDir: os.Path,
      files: Vector[LockedFile],
      artifactDirs: Vector[String]
  ): Either[String, Vector[os.Path]] =
    val filesByArtifact =
      files.groupBy(file => Lock.splitMavenPath(file.mavenPath)._1)
    artifactDirs.zipWithIndex.foldLeft[Either[String, Vector[os.Path]]](
      Right(Vector.empty)
    ): (acc, entry) =>
      val (artifactDir, index) = entry
      for
        roots <- acc
        root = stagingDir / f"artifact-${index}%06d"
        _ <- stageArtifact(
          repoDir,
          root,
          filesByArtifact.getOrElse(artifactDir, Vector.empty)
        )
      yield roots :+ root

  private def stageArtifact(
      repoDir: os.Path,
      root: os.Path,
      files: Seq[LockedFile]
  ): Either[String, Unit] =
    files.foldLeft[Either[String, Unit]](Right(())) { (acc, file) =>
      acc.flatMap(_ => stageFile(repoDir, root, file))
    }

  private def stageFile(
      repoDir: os.Path,
      root: os.Path,
      file: LockedFile
  ): Either[String, Unit] =
    val relative = os.RelPath(file.mavenPath)
    val source = repoDir / relative
    val destination = root / relative
    if !os.isFile(source) then
      Left(
        s"cannot compute artifact narHash: locked file ${file.mavenPath} is missing from ${repoDir}"
      )
    else {
      try {
        os.makeDir.all(destination / os.up)
        os.copy(source, destination)
        Sha256
          .sriFile(destination)
          .left
          .map(reason =>
            s"failed to hash staged file ${file.mavenPath}: ${reason}"
          )
          .flatMap: actual =>
            if actual == file.sha256 then Right(())
            else
              Left(
                s"cannot compute artifact narHash: cached file ${file.mavenPath} has sha256 ${actual}, but the lock expects ${file.sha256}"
              )
      } catch {
        case NonFatal(e) =>
          Left(
            s"failed to stage ${file.mavenPath} for NAR hashing: ${message(e)}"
          )
      }
    }

  private def nixHashPaths(
      paths: Vector[os.Path]
  ): Either[String, Vector[String]] =
    val command =
      Seq(
        "nix",
        "hash",
        "path",
        "--mode",
        "nar",
        "--algo",
        "sha256",
        "--format",
        "sri"
      ) ++ paths.map(_.toString)

    try
      val result = os
        .proc(command)
        .call(
          cwd = os.pwd,
          stdout = os.Pipe,
          stderr = os.Pipe,
          check = false
        )
      if result.exitCode != 0 then
        val reason = result.err.trim()
        Left(
          if reason.nonEmpty then s"nix hash path failed: ${reason}"
          else s"nix hash path failed with exit code ${result.exitCode}"
        )
      else
        val hashes = result.out.trim().linesIterator.filter(_.nonEmpty).toVector
        if hashes.size != paths.size then
          Left(
            s"nix hash path returned ${hashes.size} hashes for ${paths.size} artifact paths"
          )
        else Right(hashes)
    catch
      case NonFatal(e) =>
        Left(s"failed to run nix hash path: ${message(e)}")

  private def bestEffortDelete(path: os.Path): Unit =
    try if os.exists(path) then os.remove.all(path)
    catch case NonFatal(_) => ()

  private def message(e: Throwable): String =
    Option(e.getMessage).getOrElse(e.getClass.getSimpleName)
