package in.avimit.dev.mif

import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.util.Locale
import scala.collection.immutable.VectorMap
import scala.util.control.NonFatal

import upickle.default.ReadWriter

case class LockRepository(
    id: String,
    repoType: String,
    url: String
)

case class LockRun(
    id: String,
    repository: String,
    command: Vector[String]
)

object LockRun:
  /** Stable identifier for a build command and repository: the same argv
    * against the same repository always maps to the same id, while custom
    * repositories remain visible as distinct run ids in artifact groups.
    * Archive commands are normalized before a run is constructed so
    * newline-containing arguments do not reach this newline-joined encoding.
    */
  def idFor(command: Seq[String], repository: String): String =
    val digest = MessageDigest
      .getInstance("SHA-256")
      .digest(
        (repository +: command).mkString("\n").getBytes(StandardCharsets.UTF_8)
      )
    digest.take(6).map(byte => f"${byte & 0xff}%02x").mkString

  def fromCommand(command: Seq[String], repository: String): LockRun =
    LockRun(
      id = idFor(command, repository),
      repository = repository,
      command = command.toVector
    )

case class LockedFile(
    repository: String,
    mavenPath: String,
    sha256: String,
    runs: Vector[String]
)

case class MifLock(
    version: Int,
    kind: String,
    repositories: Vector[LockRepository],
    runs: Vector[LockRun],
    files: Vector[LockedFile]
)

object Lock:
  val Version = 2
  val Kind = "mif-maven-lock"
  val DefaultFileName = "mif.lock.json"

  private val sriPattern = "^sha256-[A-Za-z0-9+/]{43}=$".r
  private val runIdPattern = "^[0-9a-f]{12}$".r

  private case class LockJson(
      version: Int,
      kind: String,
      repositories: Map[String, String],
      runs: Map[String, LockJsonRun],
      artifacts: Map[String, LockJsonArtifact]
  ) derives ReadWriter

  private case class LockJsonRun(
      repository: String,
      command: Vector[String]
  ) derives ReadWriter

  private case class LockJsonArtifact(
      runs: Vector[String],
      files: Map[String, String]
  ) derives ReadWriter

  def empty: MifLock =
    MifLock(
      version = Version,
      kind = Kind,
      repositories = Vector.empty,
      runs = Vector.empty,
      files = Vector.empty
    )

  private def errorMessage(e: Throwable): String =
    Option(e.getMessage).getOrElse(e.getClass.getSimpleName)

  /** Repository entry describing the upstream an archive run recorded from.
    * Maven Central aliases share the well-known "central" id so locks stay
    * comparable across mirrors of the same repository.
    */
  def repositoryFor(upstream: String): Either[String, LockRepository] =
    MavenUpstream
      .validate(upstream)
      .map: uri =>
        val normalized = uri.toString.stripSuffix("/")
        val id =
          if CoursierMirror.CentralAliases.contains(normalized) then "central"
          else slugFor(uri)
        LockRepository(id = id, repoType = "maven", url = normalized)

  private def slugFor(uri: java.net.URI): String =
    val host = Option(uri.getHost).getOrElse("repository")
    val slug = host
      .toLowerCase(Locale.ROOT)
      .map(ch => if ch.isLetterOrDigit then ch else '-')
      .dropWhile(_ == '-')
      .reverse
      .dropWhile(_ == '-')
      .reverse
    if slug.isEmpty then "repository" else slug

  def parse(text: String): Either[String, MifLock] =
    decode(text).flatMap(validate)

  private def decode(text: String): Either[String, MifLock] =
    try Right(fromJson(upickle.default.read[LockJson](text)))
    catch case NonFatal(e) => Left(s"invalid lock JSON: ${errorMessage(e)}")

  private def fromJson(document: LockJson): MifLock =
    MifLock(
      version = document.version,
      kind = document.kind,
      repositories = document.repositories.toVector.map { case (id, url) =>
        LockRepository(id = id, repoType = "maven", url = url)
      },
      runs = document.runs.toVector.map { case (id, run) =>
        LockRun(id, run.repository, run.command)
      },
      files = document.artifacts.toVector.flatMap { case (dir, artifact) =>
        val repository = repositoryForRuns(document.runs, artifact.runs)
        artifact.files.toVector.map { case (name, sha256) =>
          LockedFile(
            repository = repository,
            mavenPath = s"${dir}/${name}",
            sha256 = sha256,
            runs = artifact.runs
          )
        }
      }
    )

  private def repositoryForRuns(
      runs: Map[String, LockJsonRun],
      artifactRuns: Vector[String]
  ): String =
    artifactRuns
      .flatMap(runId => runs.get(runId).map(_.repository))
      .headOption
      .getOrElse("")

  private def validate(lock: MifLock): Either[String, MifLock] =
    for
      _ <- validateHeader(lock)
      _ <- validateRepositories(lock.repositories)
      _ <- validateRuns(lock.runs)
      _ <- validateFiles(lock)
    yield lock

  private def validateHeader(lock: MifLock): Either[String, Unit] =
    if lock.version != Version then
      Left(
        s"unsupported lock version ${lock.version}; this mif understands version ${Version}, upgrade mif or regenerate the lock"
      )
    else if lock.kind != Kind then
      Left(s"unsupported lock kind '${lock.kind}'; expected '${Kind}'")
    else Right(())

  private def validateRepositories(
      repositories: Vector[LockRepository]
  ): Either[String, Unit] =
    val duplicate =
      repositories.groupBy(_.id).collectFirst {
        case (id, entries) if entries.size > 1 => id
      }
    val invalid = repositories.collectFirst {
      case repo if repo.id.isEmpty =>
        "repository entry with an empty id"
      case repo if repo.repoType != "maven" =>
        s"repository ${repo.id} has unsupported type '${repo.repoType}'"
      case repo if MavenUpstream.validate(repo.url).isLeft =>
        s"repository ${repo.id} has invalid url '${repo.url}'"
    }
    duplicate match
      case Some(id) => Left(s"duplicate repository id '${id}'")
      case None     => invalid.toLeft(())

  private def validateRuns(runs: Vector[LockRun]): Either[String, Unit] =
    val duplicate =
      runs.groupBy(_.id).collectFirst {
        case (id, entries) if entries.size > 1 => id
      }
    val invalid = runs.collectFirst {
      case run if runIdPattern.findFirstIn(run.id).isEmpty =>
        s"run id '${run.id}' is not a 12 character hex identifier"
      case run if run.repository.isEmpty =>
        s"run ${run.id} has an empty repository"
      case run if run.command.isEmpty =>
        s"run ${run.id} has an empty command"
    }
    duplicate match
      case Some(id) => Left(s"duplicate run id '${id}'")
      case None     => invalid.toLeft(())

  private def validateFiles(lock: MifLock): Either[String, Unit] =
    val repositoryIds = lock.repositories.map(_.id).toSet
    val runIds = lock.runs.map(_.id).toSet
    val duplicate =
      lock.files.groupBy(_.mavenPath).collectFirst {
        case (path, entries) if entries.size > 1 => path
      }
    val invalid = lock.files.collectFirst {
      case file
          if MavenPath.fromSegments(file.mavenPath.split('/').toSeq).isLeft =>
        s"file entry has invalid maven path '${file.mavenPath}'"
      case file if sriPattern.findFirstIn(file.sha256).isEmpty =>
        s"file ${file.mavenPath} has invalid sha256 '${file.sha256}'; expected SRI sha256-<base64>"
      case file if file.runs.isEmpty =>
        s"file ${file.mavenPath} is not referenced by any run"
      case file if !file.runs.forall(runIds.contains) =>
        s"file ${file.mavenPath} references unknown run ids ${file.runs.filterNot(runIds.contains).mkString(", ")}"
      case file if !repositoryIds.contains(file.repository) =>
        s"file ${file.mavenPath} references unknown repository '${file.repository}'"
    }
    val invalidRunRepository = lock.runs.collectFirst {
      case run if !repositoryIds.contains(run.repository) =>
        s"run ${run.id} references unknown repository '${run.repository}'"
    }
    duplicate match
      case Some(path) => Left(s"duplicate lock entry for maven path '${path}'")
      case None       => invalid.orElse(invalidRunRepository).toLeft(())

  /** Deterministic form: entry order never depends on sqlite collation or
    * insertion order, so appends produce minimal diffs.
    */
  private def canonicalize(lock: MifLock): MifLock =
    lock.copy(
      repositories = lock.repositories.sortBy(_.id),
      runs = lock.runs.sortBy(_.command.mkString("\n")),
      files = lock.files
        .map(file => file.copy(runs = file.runs.distinct.sorted))
        .sortBy(_.mavenPath)
    )

  def render(lock: MifLock): String =
    upickle.default.write(toJson(canonicalize(lock)), indent = 2) + "\n"

  private def toJson(lock: MifLock): LockJson =
    LockJson(
      version = lock.version,
      kind = lock.kind,
      repositories = VectorMap.from(
        lock.repositories
          .sortBy(_.id)
          .map(repo => repo.id -> repo.url)
      ),
      runs = VectorMap.from(
        lock.runs
          .sortBy(_.command.mkString("\n"))
          .map(run =>
            run.id -> LockJsonRun(
              repository = run.repository,
              command = run.command
            )
          )
      ),
      artifacts = artifacts(lock.files)
    )

  private def splitMavenPath(path: String): (String, String) =
    val index = path.lastIndexOf('/')
    if index < 0 then ("", path)
    else (path.take(index), path.drop(index + 1))

  private def artifacts(
      files: Vector[LockedFile]
  ): Map[String, LockJsonArtifact] =
    VectorMap.from(
      files
        .sortBy(_.mavenPath)
        .groupBy(file => splitMavenPath(file.mavenPath)._1)
        .toVector
        .sortBy(_._1)
        .map { case (dir, dirFiles) =>
          val artifactRuns = runsForArtifact(dirFiles)
          val entries = VectorMap.from(
            dirFiles
              .sortBy(file => splitMavenPath(file.mavenPath)._2)
              .map { file =>
                val (_, name) = splitMavenPath(file.mavenPath)
                name -> file.sha256
              }
          )
          dir -> LockJsonArtifact(runs = artifactRuns, files = entries)
        }
    )

  private def runsForArtifact(files: Vector[LockedFile]): Vector[String] =
    files.flatMap(_.runs).distinct.sorted

  def read(file: os.Path): Either[String, Option[MifLock]] =
    if !os.exists(file) then Right(None)
    else
      val text =
        try Right(os.read(file))
        catch
          case NonFatal(e) =>
            Left(s"failed to read lock file ${file}: ${errorMessage(e)}")
      text
        .flatMap(parse)
        .map(Some(_))
        .left
        .map(reason => s"${file}: ${reason}")

  def write(file: os.Path, lock: MifLock): Either[String, Unit] =
    val rendered = render(lock)
    createTempFile(file).flatMap { tmp =>
      try writeAndMove(tmp, file, rendered)
      finally bestEffortDelete(tmp)
    }

  private def createTempFile(file: os.Path): Either[String, os.Path] =
    try
      os.makeDir.all(file / os.up)
      Right(
        os.temp(
          dir = file / os.up,
          prefix = s".${file.last}.",
          suffix = ".tmp",
          deleteOnExit = false
        )
      )
    catch
      case NonFatal(e) =>
        Left(s"failed to write lock file ${file}: ${errorMessage(e)}")

  private def writeAndMove(
      tmp: os.Path,
      file: os.Path,
      rendered: String
  ): Either[String, Unit] =
    try
      os.write.over(tmp, rendered)
      AtomicFiles
        .moveIntoPlace(tmp, file)
        .left
        .map(cause => s"failed to write lock file ${file}: ${cause}")
    catch
      case NonFatal(e) =>
        Left(s"failed to write lock file ${file}: ${errorMessage(e)}")

  private def bestEffortDelete(path: os.Path): Unit =
    try if os.exists(path) then os.remove(path)
    catch case NonFatal(_) => ()

  /** Unions one archive run into an existing lock.
    *
    * `runFiles` is the set of files the relay actually served for this run, not
    * a whole repository snapshot: a shared repo-dir can therefore never leak
    * unrelated artifacts into the lock. A path already present must match by
    * content; every mismatch is reported and the lock is left untouched.
    */
  def merge(
      existing: MifLock,
      upstream: LockRepository,
      runFiles: Seq[MavenRepositoryFile],
      command: Seq[String]
  ): Either[String, MifLock] =
    val (repositories, repositoryId) =
      assignRepository(existing.repositories, upstream)
    val run = LockRun.fromCommand(command, repositoryId)
    val byPath = existing.files.map(file => file.mavenPath -> file).toMap

    val conflicts = runFiles.filter: observed =>
      byPath
        .get(observed.mavenPath)
        .exists(locked => locked.sha256 != observed.sha256)

    if conflicts.nonEmpty then Left(conflictMessage(conflicts, byPath))
    else
      val mergedFiles = runFiles.foldLeft(byPath): (acc, observed) =>
        acc.get(observed.mavenPath) match
          case Some(locked) =>
            acc.updated(
              observed.mavenPath,
              locked.copy(runs = (locked.runs :+ run.id).distinct.sorted)
            )
          case None =>
            acc.updated(
              observed.mavenPath,
              LockedFile(
                repository = repositoryId,
                mavenPath = observed.mavenPath,
                sha256 = observed.sha256,
                runs = Vector(run.id)
              )
            )

      val runs =
        if existing.runs.exists(_.id == run.id) then existing.runs
        else existing.runs :+ run

      Right(
        canonicalize(
          MifLock(
            version = Version,
            kind = Kind,
            repositories = repositories,
            runs = runs,
            files = mergedFiles.values.toVector
          )
        )
      )

  private def assignRepository(
      existing: Vector[LockRepository],
      upstream: LockRepository
  ): (Vector[LockRepository], String) =
    existing.find(_.url == upstream.url) match
      case Some(repository) => (existing, repository.id)
      case None =>
        val takenIds = existing.map(_.id).toSet
        val id =
          if !takenIds.contains(upstream.id) then upstream.id
          else
            // The candidate stream is infinite, so a free id always exists.
            LazyList
              .from(2)
              .map(n => s"${upstream.id}-${n}")
              .find(!takenIds.contains(_))
              .get
        (existing :+ upstream.copy(id = id), id)

  private def conflictMessage(
      conflicts: Seq[MavenRepositoryFile],
      byPath: Map[String, LockedFile]
  ): String =
    val details = conflicts
      .sortBy(_.mavenPath)
      .map { observed =>
        val locked = byPath(observed.mavenPath)
        s"  ${observed.mavenPath}\n" +
          s"    locked:   ${locked.sha256}\n" +
          s"    observed: ${observed.sha256}"
      }
      .mkString("\n")
    s"artifact content changed upstream for ${conflicts.size} path(s):\n" +
      s"${details}\n" +
      "Refusing to update the lock. Investigate the upstream mutation, or " +
      "re-archive with --fresh into a clean --repo-dir if the change is expected."
