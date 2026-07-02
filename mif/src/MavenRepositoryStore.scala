package in.avimit.dev.mif

import scala.util.control.NonFatal
import scalasql.*
import scalasql.SqliteDialect.*
import scalasql.core.SqlStr.SqlStringSyntax

case class MavenRepositoryFile(
    mavenPath: String,
    sha256: String,
    size: Long,
    contentType: String,
    upstreamUrl: Option[String]
)

case class CachedArtifact[T[_]](
    mavenPath: T[String],
    sha256: T[String],
    size: T[Long],
    contentType: T[String],
    upstreamUrl: T[Option[String]],
    firstSeenAtMillis: T[Long],
    updatedAtMillis: T[Long]
)
object CachedArtifact extends Table[CachedArtifact]:
  override def tableName = "cached_artifacts"

object MavenRepositoryStore:
  val MetadataDirectoryName = ".mif"
  val DatabaseFileName = "repository.sqlite"

  def databasePath(repoDir: os.Path): os.Path =
    repoDir / MetadataDirectoryName / DatabaseFileName

  def open(repoDir: os.Path): Either[String, MavenRepositoryStore] =
    val dbPath = databasePath(repoDir)
    try
      os.makeDir.all(dbPath / os.up)
      val dataSource = new org.sqlite.SQLiteDataSource()
      dataSource.setUrl(s"jdbc:sqlite:${dbPath}")
      val store = MavenRepositoryStore(
        dbPath,
        new scalasql.DbClient.DataSource(
          dataSource,
          config = new scalasql.Config {}
        )
      )

      store.initialize().map(_ => store)
    catch
      case NonFatal(e) =>
        Left(
          s"Failed to open Maven repository database ${dbPath}: ${e.getMessage}"
        )

class MavenRepositoryStore private (
    val dbPath: os.Path,
    dbClient: scalasql.DbClient
) extends AutoCloseable:
  private val storeLock = new AnyRef

  private def initialize(): Either[String, Unit] =
    storeLock.synchronized:
      try
        dbClient.transaction: db =>
          db.updateRaw("PRAGMA busy_timeout = 5000")
          db.updateRaw(
            """
              |CREATE TABLE IF NOT EXISTS cached_artifacts (
              |  maven_path TEXT PRIMARY KEY NOT NULL,
              |  sha256 TEXT NOT NULL,
              |  size INTEGER NOT NULL CHECK(size >= 0),
              |  content_type TEXT NOT NULL,
              |  upstream_url TEXT,
              |  first_seen_at_millis INTEGER NOT NULL,
              |  updated_at_millis INTEGER NOT NULL
              |)
              |""".stripMargin
          )
          ()
        Right(())
      catch
        case NonFatal(e) =>
          Left(
            s"Failed to initialize Maven repository database ${dbPath}: ${e.getMessage}"
          )

  def record(file: MavenRepositoryFile): Either[String, Unit] =
    storeLock.synchronized:
      try
        val now = System.currentTimeMillis()
        dbClient.transaction: db =>
          db.updateRaw("PRAGMA busy_timeout = 5000")
          db.updateSql(sql"""
            INSERT INTO cached_artifacts (
              maven_path,
              sha256,
              size,
              content_type,
              upstream_url,
              first_seen_at_millis,
              updated_at_millis
            )
            VALUES (
              ${file.mavenPath},
              ${file.sha256},
              ${file.size},
              ${file.contentType},
              ${file.upstreamUrl},
              ${now},
              ${now}
            )
            ON CONFLICT(maven_path) DO UPDATE SET
              sha256 = excluded.sha256,
              size = excluded.size,
              content_type = excluded.content_type,
              upstream_url = COALESCE(
                excluded.upstream_url,
                cached_artifacts.upstream_url
              ),
              updated_at_millis = excluded.updated_at_millis
          """)
          ()
        Right(())
      catch
        case NonFatal(e) =>
          Left(
            s"Failed to update Maven repository database ${dbPath}: ${e.getMessage}"
          )

  def find(mavenPath: String): Either[String, Option[MavenRepositoryFile]] =
    storeLock.synchronized:
      try
        val files = dbClient.transaction: db =>
          db.updateRaw("PRAGMA busy_timeout = 5000")
          db.run(
            CachedArtifact.select
              .filter(_.mavenPath === mavenPath)
              .map(file =>
                (
                  file.mavenPath,
                  file.sha256,
                  file.size,
                  file.contentType,
                  file.upstreamUrl
                )
              )
          )

        Right(files.headOption.map(fromRepositoryFileTuple))
      catch
        case NonFatal(e) =>
          Left(
            s"Failed to read Maven repository database ${dbPath}: ${e.getMessage}"
          )

  def snapshot(): Either[String, Seq[MavenRepositoryFile]] =
    storeLock.synchronized:
      try
        val files = dbClient.transaction: db =>
          db.updateRaw("PRAGMA busy_timeout = 5000")
          db.run(
            CachedArtifact.select
              .sortBy(_.mavenPath)
              .asc
              .map(file =>
                (
                  file.mavenPath,
                  file.sha256,
                  file.size,
                  file.contentType,
                  file.upstreamUrl
                )
              )
          )

        Right(files.map(fromRepositoryFileTuple))
      catch
        case NonFatal(e) =>
          Left(
            s"Failed to read Maven repository database ${dbPath}: ${e.getMessage}"
          )

  private def fromRepositoryFileTuple(
      tuple: (String, String, Long, String, Option[String])
  ): MavenRepositoryFile =
    val (mavenPath, sha256, size, contentType, upstreamUrl) = tuple
    MavenRepositoryFile(
      mavenPath = mavenPath,
      sha256 = sha256,
      size = size,
      contentType = contentType,
      upstreamUrl = upstreamUrl
    )

  def close(): Unit = ()
