package in.avimit.dev.mif

import java.io.OutputStream
import java.net.URI
import java.net.URLEncoder
import java.nio.charset.StandardCharsets
import java.nio.file.AtomicMoveNotSupportedException
import java.security.DigestInputStream
import java.security.MessageDigest

import java.util.Base64
import java.util.Locale
import java.util.concurrent.ConcurrentHashMap
import io.undertow.Undertow
import io.undertow.server.HttpHandler
import scala.util.Using
import scala.util.control.NonFatal

private def catchNonFatal[T](action: => T): Either[String, T] =
  try Right(action)
  catch case NonFatal(e) => Left(failureMessage(e))

private def failureMessage(e: Throwable): String =
  Option(e.getMessage).getOrElse(e.getClass.getSimpleName)

private def safeGetFileSize(file: os.Path): Either[String, Long] =
  catchNonFatal(os.size(file))

private def parseUri(value: String, label: String): Either[String, URI] =
  val trimmed = value.trim
  if trimmed.isEmpty then Left(s"${label} is empty")
  else
    try Right(URI.create(trimmed))
    catch
      case e: IllegalArgumentException =>
        Left(s"invalid ${label} ${value}: ${e.getMessage}")

private def closeResources(
    subject: String
)(resources: (String, Either[String, Unit])*): Either[String, Unit] =
  val failures = resources.collect:
    case (label, Left(reason)) => s"${label}: ${reason}"
  if failures.isEmpty then Right(())
  else Left(s"Failed to close ${subject}: ${failures.mkString("; ")}")

object MavenPath:
  def fromSegments(segments: Seq[String]): Either[String, String] =
    if segments.isEmpty then Left("missing Maven repository path")
    else
      segments.find(isInvalidSegment) match
        case Some(segment) => Left(s"invalid Maven path segment: ${segment}")
        case None          => Right(segments.mkString("/"))

  def encodeForUri(mavenPath: String): String =
    mavenPath
      .split('/')
      .map(segment =>
        URLEncoder
          .encode(segment, StandardCharsets.UTF_8)
          .replace("+", "%20")
      )
      .mkString("/")

  // Reserve the empty segment and any dot-leading segment. Dot-leading names are
  // where the relay keeps its own state -- the .mif metadata directory holding the
  // SQLite database, and the .<name>.*.tmp download files -- so serving them as
  // artifacts would let a request read or delete relay internals. Legitimate Maven
  // coordinates never begin a path segment with a dot.
  private def isInvalidSegment(segment: String): Boolean =
    segment.isEmpty || segment.startsWith(".") || segment.exists(ch =>
      ch == '/' || ch == '\\' || Character.isISOControl(ch)
    )

object MavenUpstream:
  def validate(upstream: String): Either[String, URI] =
    parseUri(upstream, "upstream URL").flatMap(validateUri(upstream, _))

  private def validateUri(upstream: String, uri: URI): Either[String, URI] =
    val scheme = Option(uri.getScheme).map(_.toLowerCase(Locale.ROOT))
    if !scheme.exists(s => s == "http" || s == "https") then
      Left(s"upstream URL must use http or https: ${upstream}")
    else if uri.getRawAuthority == null then
      Left(s"upstream URL must include a host: ${upstream}")
    else if uri.getRawUserInfo != null then
      Left("upstream URL must not contain user info or credentials")
    else if uri.getRawQuery != null || uri.getRawFragment != null then
      Left(s"upstream URL must not contain query or fragment: ${upstream}")
    else
      val normalized = uri.toASCIIString
      Right(
        URI.create(
          if normalized.endsWith("/") then normalized else s"${normalized}/"
        )
      )

object MavenProxy:
  def validate(proxyUrl: String): Either[String, URI] =
    parseUri(proxyUrl, "proxy URL").flatMap(validateUri(proxyUrl, _))

  private def validateUri(proxyUrl: String, uri: URI): Either[String, URI] =
    val scheme = Option(uri.getScheme).map(_.toLowerCase(Locale.ROOT))
    val path = Option(uri.getRawPath).getOrElse("")

    // Only plain-HTTP proxies are supported: MavenProxy.tuple feeds requests'
    // (host, port) proxy parameter, which has no way to express an https:// proxy,
    // so https is rejected here even though the upstream validator accepts it.
    // tuple also dereferences getHost, so -- unlike the upstream validator, which
    // only uses the URI textually -- this one additionally requires a parseable host.
    if !scheme.exists(_ == "http") then
      Left(s"proxy URL must use http: ${proxyUrl}")
    else if uri.getRawAuthority == null || uri.getHost == null then
      Left(s"proxy URL must include a host: ${proxyUrl}")
    else if uri.getRawUserInfo != null then
      Left("proxy URL must not contain user info or credentials")
    else if uri.getPort <= 0 then
      Left(s"proxy URL must include an explicit port: ${proxyUrl}")
    else if path.nonEmpty && path != "/" then
      Left(s"proxy URL must not contain a path: ${proxyUrl}")
    else if uri.getRawQuery != null || uri.getRawFragment != null then
      Left(s"proxy URL must not contain query or fragment: ${proxyUrl}")
    else Right(uri)

  def tuple(uri: URI): (String, Int) = uri.getHost -> uri.getPort

object Sha256:
  def sriFile(file: os.Path): Either[String, String] =
    catchNonFatal:
      val digest = MessageDigest.getInstance("SHA-256")
      Using.resource(DigestInputStream(os.read.inputStream(file), digest)):
        input => input.transferTo(OutputStream.nullOutputStream())
      s"sha256-${Base64.getEncoder.encodeToString(digest.digest())}"

object AtomicFiles:

  def moveIntoPlace(
      tmp: os.Path,
      target: os.Path
  ): Either[String, Unit] =
    catchNonFatal(moveIntoPlaceUnsafe(tmp, target))

  private def moveIntoPlaceUnsafe(
      tmp: os.Path,
      target: os.Path
  ): Unit =
    try
      os.move(
        from = tmp,
        to = target,
        replaceExisting = true,
        atomicMove = true
      )
    catch
      case _: AtomicMoveNotSupportedException =>
        os.move(from = tmp, to = target, replaceExisting = true)

case class MavenRelayConfig(
    repoDir: os.Path,
    upstreamBaseUrl: String,
    proxyUrl: Option[String] = None,
    connectTimeoutSeconds: Int,
    requestTimeoutSeconds: Int
)

sealed trait RelayBody

object RelayBody:
  case object Empty extends RelayBody
  final case class Bytes(bytes: Array[Byte]) extends RelayBody
  final case class File(path: os.Path) extends RelayBody

enum RelayMethod:
  case Get, Head

object RelayMethod:
  // Cask only routes GET and HEAD to the relay (see MavenRelayRoutes and
  // MavenRelayApp.handleMethodNotAllowed rejecting the rest with 405), so any
  // method that reaches the handler and is not HEAD is a GET.
  def fromHttp(method: String): RelayMethod =
    if method.equalsIgnoreCase("HEAD") then RelayMethod.Head
    else RelayMethod.Get

case class RelayResponse(
    statusCode: Int,
    body: RelayBody,
    headers: Seq[(String, String)]
)

private case class UpstreamResponse(
    statusCode: Int,
    headers: Map[String, Seq[String]]
)

// Cheap fingerprint of a cached file, used to skip re-hashing an artifact whose
// on-disk (mtime, size) has not changed since it was last verified.
private case class VerifiedStamp(mtimeMillis: Long, size: Long)

object MavenRelayService:
  def fromConfig(config: MavenRelayConfig): Either[String, MavenRelayService] =
    for
      connectTimeout <- timeoutMillis("connect", config.connectTimeoutSeconds)
      requestTimeout <- timeoutMillis("request", config.requestTimeoutSeconds)
      upstreamBase <- MavenUpstream.validate(config.upstreamBaseUrl)
      proxy <- validateProxy(config.proxyUrl)
      repositoryStore <- MavenRepositoryStore.open(config.repoDir)
    yield new MavenRelayService(
      config,
      upstreamBase,
      proxy,
      connectTimeout,
      requestTimeout,
      repositoryStore
    )

  private def validateProxy(
      proxyUrl: Option[String]
  ): Either[String, Option[URI]] =
    proxyUrl match
      case Some(value) => MavenProxy.validate(value).map(Some(_))
      case None        => Right(None)

  private def timeoutMillis(label: String, seconds: Int): Either[String, Int] =
    val millis = seconds.toLong * 1000L
    if seconds <= 0 then Left(s"${label} timeout must be greater than zero")
    else if millis > Int.MaxValue then Left(s"${label} timeout is too large")
    else Right(millis.toInt)

class MavenRelayService private (
    config: MavenRelayConfig,
    upstreamBase: URI,
    proxy: Option[URI],
    connectTimeoutMillis: Int,
    requestTimeoutMillis: Int,
    repositoryStore: MavenRepositoryStore
) extends AutoCloseable:
  // One monitor object per in-flight Maven path, reference-counted so the map does
  // not grow without bound: withPathLock installs an entry on first use and drops
  // it once no request holds it. The GET critical section intentionally spans the
  // whole download so that concurrent requests for the same path fetch it once.
  private final class PathLock:
    var holders: Int = 0

  private val pathLocks = ConcurrentHashMap[String, PathLock]()
  // Per-path record of the last (mtime, size) that verified against the database,
  // so a repeated hit on an unchanged file serves in O(1) instead of re-reading
  // and re-hashing the whole artifact under the lock. An external change moves the
  // file's mtime or size and forces a fresh SHA-256 verification.
  private val verifiedStamps = ConcurrentHashMap[String, VerifiedStamp]()
  private val upstreamSession = requests.Session(
    headers = Map(
      "User-Agent" -> s"mif/${MillIvyFetcher.VERSION}",
      "Accept" -> "*/*",
      // Cache raw artifact bytes only: ask upstream not to content-encode the
      // body, and reject any encoded 200 at cache time (see isCacheableArtifact)
      // so a cache hit never replays encoded bytes without a Content-Encoding.
      "Accept-Encoding" -> "identity"
    ),
    proxy = proxy.map(MavenProxy.tuple).orNull,
    readTimeout = requestTimeoutMillis,
    connectTimeout = connectTimeoutMillis,
    autoDecompress = false,
    check = false
  )

  def upstreamBaseUrl: String = upstreamBase.toString
  def proxyUrl: Option[String] = proxy.map(_.toString)
  def repositoryDatabasePath: os.Path = repositoryStore.dbPath

  def closeEither(): Either[String, Unit] =
    closeResources("Maven relay service")(
      "upstream HTTP session" -> catchNonFatal(upstreamSession.close()),
      "repository database" -> catchNonFatal(repositoryStore.close())
    )

  def close(): Unit =
    closeEither().left.foreach(Logger.warning)

  def handle(method: RelayMethod, segments: Seq[String]): RelayResponse =
    MavenPath.fromSegments(segments) match
      case Left(reason) => textResponse(400, reason)
      case Right(mavenPath) =>
        method match
          case RelayMethod.Get  => handleGetReq(mavenPath)
          case RelayMethod.Head => handleHeadReq(mavenPath)

  private def handleGetReq(mavenPath: String): RelayResponse =
    val file = localFile(mavenPath)
    withPathLock(mavenPath):
      trustedCacheRecord(mavenPath, file) match
        case Left(response) => response
        case Right(Some(record)) =>
          cachedArtifactResponse(RelayBody.File(file), mavenPath, record)
        case Right(None) => fetchAndCacheGet(mavenPath, file)

  private def handleHeadReq(mavenPath: String): RelayResponse =
    val file = localFile(mavenPath)
    // Validate/evict the cache entry under the lock, but issue the upstream HEAD
    // outside it: a HEAD mutates nothing locally, so holding the per-path monitor
    // across a network round trip would needlessly block a concurrent download.
    withPathLock(mavenPath)(trustedCacheRecord(mavenPath, file)) match
      case Left(response) => response
      case Right(Some(record)) =>
        cachedArtifactResponse(RelayBody.Empty, mavenPath, record)
      case Right(None) => fetchUpstreamHeadResponse(mavenPath)

  // A local file alone is not a trusted cache hit. The repository database is the
  // source of truth, so a cached response must have a DB record whose recorded size
  // and SHA-256 still match the bytes on disk; anything else is deleted and treated
  // as a miss. Cached files are write-once -- once recorded they are never mutated
  // in place, only deleted-and-refetched when untrusted -- which is why RelayBody.File
  // may be streamed to the client after the lock is released. Any future in-place
  // mutation must instead open the file under the lock before returning it.
  //   Right(Some(record)) = trusted hit
  //   Right(None)         = treat as a miss (a stale file, if any, has been deleted)
  //   Left(response)      = an error response to return as-is
  private def trustedCacheRecord(
      mavenPath: String,
      file: os.Path
  ): Either[RelayResponse, Option[MavenRepositoryFile]] =
    if !os.isFile(file) then Right(None)
    else
      repositoryStore.find(mavenPath) match
        case Left(reason) =>
          Left(
            internalServerError(
              phase = "read repository database",
              mavenPath = mavenPath,
              reason = reason
            )
          )
        case Right(None) =>
          deleteLocalArtifact(mavenPath, file, "Local artifact not recorded")
            .map(_ => None)
        case Right(Some(record)) =>
          cachedArtifactMatches(mavenPath, file, record).flatMap:
            case true => Right(Some(record))
            case false =>
              deleteLocalArtifact(
                mavenPath,
                file,
                "Cached artifact does not match repository database"
              ).map(_ => None)

  private def cachedArtifactResponse(
      body: RelayBody,
      mavenPath: String,
      record: MavenRepositoryFile
  ): RelayResponse =
    RelayResponse(
      statusCode = 200,
      body = body,
      headers = headersFor(
        mavenPath,
        size = Some(record.size),
        upstreamHeaders = Seq("Content-Type" -> record.contentType)
      )
    )

  private def cachedArtifactMatches(
      mavenPath: String,
      file: os.Path,
      recordedFile: MavenRepositoryFile
  ): Either[RelayResponse, Boolean] =
    val stamp = currentStamp(file)
    val alreadyVerified = stamp.exists: current =>
      current.size == recordedFile.size &&
        verifiedStamps.get(mavenPath) == current

    if alreadyVerified then Right(true)
    else
      artifactSizeAndSha(mavenPath, file, "cached").map: (size, sha256) =>
        val matches = size == recordedFile.size && sha256 == recordedFile.sha256
        stamp.foreach: current =>
          if matches then verifiedStamps.put(mavenPath, current)
          else verifiedStamps.remove(mavenPath)
        matches

  // Best-effort (mtime, size) read; None if the file is gone or unreadable, in
  // which case verification falls through to the full size+hash path.
  private def currentStamp(file: os.Path): Option[VerifiedStamp] =
    catchNonFatal(VerifiedStamp(os.mtime(file), os.size(file))).toOption

  // Measure an artifact's size and SHA-256, mapping any filesystem/hash failure to
  // a 500. Shared by the cache-hit verification and the post-download record step.
  private def artifactSizeAndSha(
      mavenPath: String,
      file: os.Path,
      label: String
  ): Either[RelayResponse, (Long, String)] =
    for
      size <- safeGetFileSize(file).left.map: reason =>
        internalServerError(
          phase = s"read ${label} artifact size",
          mavenPath = mavenPath,
          reason = reason
        )
      sha256 <- Sha256
        .sriFile(file)
        .left
        .map: reason =>
          internalServerError(
            phase = s"hash ${label} artifact",
            mavenPath = mavenPath,
            reason = reason
          )
    yield (size, sha256)

  private def fetchAndCacheGet(
      mavenPath: String,
      file: os.Path
  ): RelayResponse =
    val parent = file / os.up
    catchNonFatal(os.makeDir.all(parent)) match
      case Left(reason) =>
        internalServerError(
          phase = "create artifact directory",
          mavenPath = mavenPath,
          reason = reason
        )
      case Right(_) =>
        withTempArtifactFile(parent, file): tmp =>
          fetchUpstreamToFile(mavenPath, tmp) match
            case Left(response) => response
            case Right(upstreamResponse) =>
              upstreamGetResponse(mavenPath, file, tmp, upstreamResponse)

  private def withTempArtifactFile(
      parent: os.Path,
      file: os.Path
  )(buildResponse: os.Path => RelayResponse): RelayResponse =
    val tmp = os.temp(
      dir = parent,
      prefix = s".${file.last}.",
      suffix = ".tmp",
      deleteOnExit = false
    )
    try buildResponse(tmp)
    finally if os.exists(tmp) then os.remove(tmp)

  private def upstreamGetResponse(
      mavenPath: String,
      file: os.Path,
      tmp: os.Path,
      upstreamResponse: UpstreamResponse
  ): RelayResponse =
    val upstreamHeaders = safeUpstreamHeaders(upstreamResponse)

    if upstreamResponse.statusCode == 200 && isCacheableArtifact(
        mavenPath,
        upstreamHeaders
      )
    then cacheSuccessfulGet(mavenPath, file, tmp, upstreamHeaders)
    else
      forwardUncachedUpstreamGet(
        mavenPath,
        tmp,
        upstreamResponse.statusCode,
        upstreamHeaders
      )

  // Only archive a 200 whose body is a real artifact. A text/html body is almost
  // always a directory listing (e.g. Maven Central redirects a bare directory path
  // to an HTML index); caching it as a regular file would shadow the whole subtree,
  // and every later fetch below that prefix would fail on the non-directory ancestor.
  // A content-encoded body would be cached as opaque bytes and later replayed without
  // its Content-Encoding header. Both are forwarded to the client uncached instead.
  private def isCacheableArtifact(
      mavenPath: String,
      upstreamHeaders: Seq[(String, String)]
  ): Boolean =
    val contentType =
      contentTypeFromHeaders(upstreamHeaders, mavenPath).toLowerCase(
        Locale.ROOT
      )
    val contentEncoded = upstreamHeaders.exists:
      case (name, value) =>
        name.equalsIgnoreCase("Content-Encoding") &&
        !value.equalsIgnoreCase("identity")
    !contentType.startsWith("text/html") && !contentEncoded

  private def cacheSuccessfulGet(
      mavenPath: String,
      file: os.Path,
      tmp: os.Path,
      upstreamHeaders: Seq[(String, String)]
  ): RelayResponse =
    val artifactInfo =
      for
        sizeAndSha <- artifactSizeAndSha(mavenPath, tmp, "downloaded")
        _ <- AtomicFiles
          .moveIntoPlace(tmp, file)
          .left
          .map: reason =>
            internalServerError(
              phase = "persist artifact",
              mavenPath = mavenPath,
              reason = reason
            )
      yield sizeAndSha

    artifactInfo match
      case Left(response) => response
      case Right((size, sha256)) =>
        val contentType = contentTypeFromHeaders(upstreamHeaders, mavenPath)
        record(
          mavenPath,
          sha256,
          size,
          contentType,
          upstreamUrl = Some(upstreamUrl(mavenPath))
        ) match
          case Left(reason) =>
            internalServerError(
              phase = "update repository database",
              mavenPath = mavenPath,
              reason = reason
            )
          case Right(_) =>
            Logger.info(s"Archived ${mavenPath}")
            // Record the just-written file's stamp so its first cache hit does
            // not re-hash bytes we just verified.
            currentStamp(file).foreach(verifiedStamps.put(mavenPath, _))
            RelayResponse(
              statusCode = 200,
              body = RelayBody.File(file),
              headers = headersFor(
                mavenPath,
                size = Some(size),
                upstreamHeaders = upstreamHeaders
              )
            )

  private def forwardUncachedUpstreamGet(
      mavenPath: String,
      tmp: os.Path,
      status: Int,
      upstreamHeaders: Seq[(String, String)]
  ): RelayResponse =
    if status >= 400 then
      Logger.warning(s"Upstream returned ${status} for ${mavenPath}")

    val bytesResult =
      catchNonFatal(os.read.bytes(tmp)).left.map: reason =>
        internalServerError(
          phase = "read uncached upstream response",
          mavenPath = mavenPath,
          reason = reason
        )

    bytesResult match
      case Left(response) => response
      case Right(bytes) =>
        RelayResponse(
          statusCode = status,
          body = RelayBody.Bytes(bytes),
          headers = headersFor(
            mavenPath,
            size = Some(bytes.length.toLong),
            upstreamHeaders = upstreamHeaders
          )
        )

  private def fetchUpstreamHeadResponse(mavenPath: String): RelayResponse =
    fetchUpstreamHead(mavenPath) match
      case Left(response) => response
      case Right(upstreamResponse) =>
        RelayResponse(
          statusCode = upstreamResponse.statusCode,
          body = RelayBody.Empty,
          headers = headersFor(
            mavenPath,
            size = upstreamContentLength(upstreamResponse),
            upstreamHeaders = safeUpstreamHeaders(upstreamResponse)
          )
        )

  private def handleUpstreamFailure[T](
      mavenPath: String
  ): PartialFunction[Throwable, Either[RelayResponse, T]] =
    case e: InterruptedException =>
      Thread.currentThread().interrupt()
      Left(upstreamFailure(mavenPath, e))
    case NonFatal(e) =>
      Left(upstreamFailure(mavenPath, e))

  private def deleteLocalArtifact(
      mavenPath: String,
      file: os.Path,
      reason: String
  ): Either[RelayResponse, Unit] =
    Logger.warning(s"${reason}, deleting: ${mavenPath}")
    verifiedStamps.remove(mavenPath)
    catchNonFatal(os.remove(file))
      .map(_ => ())
      .left
      .map: failure =>
        internalServerError(
          phase = "delete local artifact",
          mavenPath = mavenPath,
          reason = failure
        )

  private def internalServerError(
      phase: String,
      mavenPath: String,
      reason: String
  ): RelayResponse =
    Logger.error(
      s"Local relay failure while ${phase} for ${mavenPath}: ${reason}"
    )
    textResponse(500, "internal server error\n")

  private def upstreamFailure(mavenPath: String, e: Throwable): RelayResponse =
    upstreamFailure(mavenPath, failureMessage(e))

  private def upstreamFailure(
      mavenPath: String,
      reason: String
  ): RelayResponse =
    Logger.error(s"Upstream request failed for ${mavenPath}: ${reason}")
    textResponse(502, s"upstream request failed for ${mavenPath}\n")

  private def fetchUpstreamToFile(
      mavenPath: String,
      tmp: os.Path
  ): Either[RelayResponse, UpstreamResponse] =
    try
      var upstreamResponse: Option[UpstreamResponse] = None
      val readable = upstreamSession.get.stream(
        url = upstreamUrl(mavenPath),
        check = false,
        onHeadersReceived =
          headers => upstreamResponse = Some(toUpstreamResponse(headers))
      )
      Using.resource(os.write.outputStream(tmp)): output =>
        readable.writeBytesTo(output)
        ()

      upstreamResponse.toRight:
        upstreamFailure(
          mavenPath,
          "upstream response did not include headers"
        )
    catch handleUpstreamFailure(mavenPath)

  private def fetchUpstreamHead(
      mavenPath: String
  ): Either[RelayResponse, UpstreamResponse] =
    try
      Right(
        toUpstreamResponse(
          upstreamSession.head(
            url = upstreamUrl(mavenPath),
            check = false
          )
        )
      )
    catch handleUpstreamFailure(mavenPath)

  private def toUpstreamResponse(
      response: requests.StreamHeaders
  ): UpstreamResponse =
    UpstreamResponse(
      statusCode = response.statusCode,
      headers = response.headers
    )

  private def toUpstreamResponse(
      response: requests.Response
  ): UpstreamResponse =
    UpstreamResponse(
      statusCode = response.statusCode,
      headers = response.headers
    )

  private def upstreamUrl(mavenPath: String): String =
    upstreamBase.resolve(MavenPath.encodeForUri(mavenPath)).toString

  private def localFile(mavenPath: String): os.Path =
    config.repoDir / os.RelPath(mavenPath)

  private def withPathLock[T](mavenPath: String)(body: => T): T =
    val lock = pathLocks.compute(
      mavenPath,
      (_, existing) =>
        val pathLock = if existing == null then PathLock() else existing
        pathLock.holders += 1
        pathLock
    )
    try lock.synchronized(body)
    finally
      pathLocks.compute(
        mavenPath,
        (_, current) =>
          current.holders -= 1
          if current.holders == 0 then null else current
      )

  private def record(
      mavenPath: String,
      sha256: String,
      size: Long,
      contentType: String,
      upstreamUrl: Option[String]
  ): Either[String, Unit] =
    repositoryStore.record(
      MavenRepositoryFile(
        mavenPath = mavenPath,
        sha256 = sha256,
        size = size,
        contentType = contentType,
        upstreamUrl = upstreamUrl
      )
    )

  private val forwardedResponseHeaders = Set(
    "accept-ranges",
    "cache-control",
    "content-disposition",
    "content-encoding",
    "content-language",
    "content-type",
    "etag",
    "expires",
    "last-modified",
    "retry-after",
    "www-authenticate"
  )

  private def safeUpstreamHeaders(
      response: UpstreamResponse
  ): Seq[(String, String)] =
    response.headers.toSeq.flatMap:
      case (name, values) =>
        val lowerName = name.toLowerCase(Locale.ROOT)
        if forwardedResponseHeaders.contains(lowerName) then
          values.map(value => name -> value)
        else Nil

  private def headersFor(
      mavenPath: String,
      size: Option[Long],
      upstreamHeaders: Seq[(String, String)] = Nil
  ): Seq[(String, String)] =
    val passthrough = upstreamHeaders.filterNot:
      case (name, _) =>
        name.equalsIgnoreCase("Content-Length") ||
        name.equalsIgnoreCase("Content-Type")
    val contentType =
      "Content-Type" -> contentTypeFromHeaders(upstreamHeaders, mavenPath)

    (contentType +: passthrough) ++
      size.map(value => "Content-Length" -> value.toString)

  private def contentTypeFromHeaders(
      headers: Seq[(String, String)],
      mavenPath: String
  ): String =
    headers
      .collectFirst:
        case (name, value) if name.equalsIgnoreCase("Content-Type") => value
      .getOrElse(contentTypeFor(mavenPath))

  private def contentTypeFor(mavenPath: String): String =
    if mavenPath.endsWith(".pom") || mavenPath.endsWith(".xml") then
      "application/xml"
    else if mavenPath.endsWith(".jar") then "application/java-archive"
    else if Seq(".sha1", ".md5", ".sha256", ".sha512", ".asc")
        .exists(mavenPath.endsWith)
    then "text/plain"
    else "application/octet-stream"

  private def upstreamContentLength(
      response: UpstreamResponse
  ): Option[Long] =
    response.headers
      .get("content-length")
      .flatMap(_.headOption)
      .flatMap(_.toLongOption)

  private def textResponse(statusCode: Int, message: String): RelayResponse =
    RelayResponse(
      statusCode = statusCode,
      body = RelayBody.Bytes(message.getBytes(StandardCharsets.UTF_8)),
      headers = Seq("Content-Type" -> "text/plain; charset=utf-8")
    )

case class MavenRelayRoutes(service: MavenRelayService)(implicit
    cc: castor.Context,
    log: cask.Logger
) extends cask.Routes:
  @cask.route("/", methods = Seq("get", "head"))
  def relay(
      segments: cask.RemainingPathSegments,
      request: cask.Request
  ) =
    val method =
      RelayMethod.fromHttp(request.exchange.getRequestMethod.toString)
    val response =
      if segments.value.isEmpty then rootResponse(method)
      else service.handle(method, segments.value)

    cask.Response(
      toCaskData(response.body),
      statusCode = response.statusCode,
      headers = response.headers
    )

  private def toCaskData(body: RelayBody): cask.Response.Data =
    body match
      case RelayBody.Empty        => ()
      case RelayBody.Bytes(bytes) => bytes
      case RelayBody.File(path)   => os.read.stream(path)

  private def rootResponse(method: RelayMethod): RelayResponse =
    val messageBytes =
      "mif Maven relay is running\n".getBytes(StandardCharsets.UTF_8)
    val headers = Seq(
      "Content-Type" -> "text/plain; charset=utf-8",
      "Content-Length" -> messageBytes.length.toString
    )
    val body = method match
      case RelayMethod.Get  => RelayBody.Bytes(messageBytes)
      case RelayMethod.Head => RelayBody.Empty

    RelayResponse(statusCode = 200, body = body, headers = headers)

  initialize()

object RelayHttpServer:
  def start(
      host: String,
      port: Int,
      handler: HttpHandler
  ): Either[String, Undertow] =
    build(host, port, handler).flatMap(startServer(host, port, _))

  private def build(
      host: String,
      port: Int,
      handler: HttpHandler
  ): Either[String, Undertow] =
    try
      // This mirrors the useful setup from Cask's `main` without giving up
      // lifecycle control. Cask silences noisy JBoss/Undertow startup logging
      // before building the server, then starts Undertow and registers its own
      // shutdown hook. The relay does those steps itself so startup can return
      // `Either` and tests can close the returned handle deterministically.
      cask.main.Main.silenceJboss()
      Right(
        Undertow.builder
          .addHttpListener(port, host)
          .setHandler(handler)
          .build
      )
    catch
      case NonFatal(e) =>
        Left(
          s"Failed to build Maven relay HTTP server at http://${host}:${port}/: ${failureMessage(e)}"
        )

  private def startServer(
      host: String,
      port: Int,
      server: Undertow
  ): Either[String, Undertow] =
    try
      server.start()
      Right(server)
    catch
      case NonFatal(e) =>
        stop(server).left.foreach(Logger.warning)
        Left(
          s"Failed to start Maven relay HTTP server at http://${host}:${port}/: ${failureMessage(e)}"
        )

  def stop(server: Undertow): Either[String, Unit] =
    try
      server.stop()
      Right(())
    catch
      case NonFatal(e) =>
        Left(s"Failed to stop Maven relay HTTP server: ${failureMessage(e)}")

object RuntimeHooks:
  def addShutdownHook(close: () => Unit): Either[String, Unit] =
    try
      Runtime.getRuntime.addShutdownHook(new Thread(() => close()))
      Right(())
    catch
      case NonFatal(e) =>
        Left(s"Failed to install relay shutdown hook: ${failureMessage(e)}")

class MavenRelayApp(
    hostName: String,
    portNumber: Int,
    service: MavenRelayService
) extends cask.Main:
  override def host: String = hostName
  override def port: Int = portNumber
  override def debugMode: Boolean = false

  override def handleMethodNotAllowed(req: cask.Request): cask.Response.Raw =
    cask.Response(
      "Error 405: Method Not Allowed",
      statusCode = 405,
      headers = Seq("Allow" -> "GET, HEAD")
    )

  override val allRoutes = Seq(MavenRelayRoutes(service)(actorContext, log))

  def start(): Either[String, MavenRelayHandle] =
    RelayHttpServer
      .start(host, port, defaultHandler)
      .map: server =>
        MavenRelayHandle(
          baseUrl = s"http://${host}:${port}/",
          server = server,
          service = service,
          shutdownApp = () => executionContext.shutdown()
        )

class MavenRelayHandle(
    val baseUrl: String,
    server: Undertow,
    service: MavenRelayService,
    shutdownApp: () => Unit
) extends AutoCloseable:
  def closeEither(): Either[String, Unit] =
    closeResources("Maven relay handle")(
      "HTTP server" -> RelayHttpServer.stop(server),
      "relay service" -> service.closeEither(),
      "Cask execution context" -> catchNonFatal(shutdownApp())
    )

  def close(): Unit =
    closeEither().left.foreach(Logger.warning)

object MavenRelayServer:
  val DefaultUpstream = "https://repo1.maven.org/maven2"

  def start(
      host: String,
      port: Int,
      config: MavenRelayConfig
  ): Either[String, MavenRelayHandle] =
    MavenRelayService
      .fromConfig(config)
      .flatMap: service =>
        MavenRelayApp(host, port, service).start() match
          case Right(handle) =>
            Logger.info(s"Starting Maven relay at ${handle.baseUrl}")
            Logger.info(s"Upstream: ${service.upstreamBaseUrl}")
            service.proxyUrl
              .foreach(proxyUrl => Logger.info(s"Upstream proxy: ${proxyUrl}"))
            Logger.info(s"Archive repository: ${config.repoDir}")
            Logger.info(
              s"Repository database: ${service.repositoryDatabasePath}"
            )
            Right(handle)
          case Left(reason) =>
            service.close()
            Left(reason)

  def run(
      host: String,
      port: Int,
      config: MavenRelayConfig
  ): Unit =
    val handle = start(host, port, config) match
      case Left(reason)  => Logger.fatal(reason)
      case Right(handle) => handle

    RuntimeHooks
      .addShutdownHook(() => handle.close())
      .left
      .foreach(Logger.warning)
