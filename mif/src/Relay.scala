package in.avimit.dev.mif

import java.net.URI
import java.net.URLEncoder
import java.nio.charset.StandardCharsets
import java.nio.file.AtomicMoveNotSupportedException
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

object MavenPath:
  private val invalidSegments = Set("", ".", "..")

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

  private def isInvalidSegment(segment: String): Boolean =
    invalidSegments.contains(segment) || segment.exists(ch =>
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

  private def parseUri(value: String, label: String): Either[String, URI] =
    val trimmed = value.trim
    if trimmed.isEmpty then Left(s"${label} is empty")
    else
      try Right(URI.create(trimmed))
      catch
        case e: IllegalArgumentException =>
          Left(s"invalid ${label} ${value}: ${e.getMessage}")

object MavenProxy:
  def validate(proxyUrl: String): Either[String, URI] =
    parseUri(proxyUrl, "proxy URL").flatMap(validateUri(proxyUrl, _))

  private def validateUri(proxyUrl: String, uri: URI): Either[String, URI] =
    val scheme = Option(uri.getScheme).map(_.toLowerCase(Locale.ROOT))
    val path = Option(uri.getRawPath).getOrElse("")

    if !scheme.contains("http") then
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

  private def parseUri(value: String, label: String): Either[String, URI] =
    val trimmed = value.trim
    if trimmed.isEmpty then Left(s"${label} is empty")
    else
      try Right(URI.create(trimmed))
      catch
        case e: IllegalArgumentException =>
          Left(s"invalid ${label} ${value}: ${e.getMessage}")

  def tuple(uri: URI): (String, Int) = uri.getHost -> uri.getPort

object Sha256:
  def sri(bytes: Array[Byte]): String =
    val digest = MessageDigest.getInstance("SHA-256").digest(bytes)
    s"sha256-${Base64.getEncoder.encodeToString(digest)}"

  def sriFile(file: os.Path): Either[Throwable, String] =
    try
      val digest = MessageDigest.getInstance("SHA-256")
      Using.resource(os.read.inputStream(file)): input =>
        val buffer = Array.ofDim[Byte](8192)
        var count = input.read(buffer)
        while count != -1 do
          digest.update(buffer, 0, count)
          count = input.read(buffer)

      Right(s"sha256-${Base64.getEncoder.encodeToString(digest.digest())}")
    catch case NonFatal(e) => Left(e)

object AtomicFiles:

  def moveIntoPlace(
      tmp: os.Path,
      target: os.Path
  ): Either[Throwable, Unit] =
    try
      moveIntoPlaceUnsafe(tmp, target)
      Right(())
    catch case NonFatal(e) => Left(e)

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

case class RelayResponse(
    statusCode: Int,
    body: RelayBody,
    headers: Seq[(String, String)]
)

private case class UpstreamResponse(
    statusCode: Int,
    headers: Map[String, Seq[String]]
)

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
  // Each value is a plain JVM object used only as a monitor for one Maven path.
  // AnyRef is the common supertype of reference values that support synchronized.
  private val pathLocks = ConcurrentHashMap[String, AnyRef]()
  private val upstreamSession = requests.Session(
    headers = Map(
      "User-Agent" -> s"mif/${MillIvyFetcher.VERSION}",
      "Accept" -> "*/*"
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
    val failures = Seq(
      "upstream HTTP session" -> catchNonFatal(upstreamSession.close()),
      "repository database" -> catchNonFatal(repositoryStore.close())
    ).collect:
      case (resourceLabel, Left(reason)) => s"${resourceLabel}: ${reason}"

    if failures.isEmpty then Right(())
    else
      Left(s"Failed to close Maven relay service: ${failures.mkString("; ")}")

  def close(): Unit =
    closeEither().left.foreach(Logger.warning)

  def handle(method: String, segments: Seq[String]): RelayResponse =
    MavenPath.fromSegments(segments) match
      case Left(reason) => textResponse(400, reason)
      case Right(mavenPath) =>
        method.toUpperCase(Locale.ROOT) match
          case "GET"  => handleGetReq(mavenPath)
          case "HEAD" => handleHeadReq(mavenPath)
          case method =>
            throw new AssertionError(
              s"unreachable: Cask routed unsupported method ${method} to relay handler"
            )

  private def handleGetReq(mavenPath: String): RelayResponse =
    pathLock(mavenPath).synchronized:
      val file = localFile(mavenPath)
      if os.exists(file) && os.isFile(file) then cachedGet(mavenPath, file)
      else fetchAndCacheGet(mavenPath, file)

  // A local file alone is not a trusted cache hit. The repository database is
  // the source of truth, so cached responses must have a DB record and the file
  // on disk must still match the recorded size and SHA-256. Untrusted files are
  // deleted and treated as cache misses.
  private def cachedGet(mavenPath: String, file: os.Path): RelayResponse =
    repositoryStore.find(mavenPath) match
      case Left(reason) =>
        repositoryDatabaseFailure(
          phase = "read repository database",
          mavenPath = mavenPath,
          reason = reason
        )
      case Right(None) =>
        deleteLocalArtifact(
          mavenPath,
          file,
          reason = "Local artifact not recorded"
        ) match
          case Left(response) => response
          case Right(_)       => fetchAndCacheGet(mavenPath, file)
      case Right(Some(recordedFile)) =>
        cachedArtifactMatches(mavenPath, file, recordedFile) match
          case Left(response) => response
          case Right(false) =>
            deleteLocalArtifact(
              mavenPath,
              file,
              reason = "Cached artifact does not match repository database"
            ) match
              case Left(response) => response
              case Right(_)       => fetchAndCacheGet(mavenPath, file)
          case Right(true) =>
            RelayResponse(
              statusCode = 200,
              body = RelayBody.File(file),
              headers = headersFor(
                mavenPath,
                size = Some(recordedFile.size),
                upstreamHeaders =
                  Seq("Content-Type" -> recordedFile.contentType)
              )
            )

  private def cachedArtifactMatches(
      mavenPath: String,
      file: os.Path,
      recordedFile: MavenRepositoryFile
  ): Either[RelayResponse, Boolean] =
    val artifactInfo =
      for
        size <- safeGetFileSize(file).left.map: reason =>
          raiseInternalServerErr(
            phase = "read cached artifact size",
            mavenPath = mavenPath,
            reason = reason
          )
        sha256 <- Sha256
          .sriFile(file)
          .left
          .map: cause =>
            raiseInternalServerErr(
              phase = "hash cached artifact",
              mavenPath = mavenPath,
              reason = failureMessage(cause)
            )
      yield (size, sha256)

    artifactInfo.map: (size, sha256) =>
      size == recordedFile.size && sha256 == recordedFile.sha256

  private def fetchAndCacheGet(
      mavenPath: String,
      file: os.Path
  ): RelayResponse =
    val parent = file / os.up
    catchNonFatal(os.makeDir.all(parent)) match
      case Left(reason) =>
        raiseInternalServerErr(
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

    if upstreamResponse.statusCode == 200 then
      cacheSuccessfulGet(mavenPath, file, tmp, upstreamHeaders)
    else
      forwardUncachedUpstreamGet(
        mavenPath,
        tmp,
        upstreamResponse.statusCode,
        upstreamHeaders
      )

  private def cacheSuccessfulGet(
      mavenPath: String,
      file: os.Path,
      tmp: os.Path,
      upstreamHeaders: Seq[(String, String)]
  ): RelayResponse =
    val artifactInfo =
      for
        size <- safeGetFileSize(tmp).left.map: reason =>
          raiseInternalServerErr(
            phase = "read downloaded artifact size",
            mavenPath = mavenPath,
            reason = reason
          )
        sha256 <- Sha256
          .sriFile(tmp)
          .left
          .map: cause =>
            raiseInternalServerErr(
              phase = "hash downloaded artifact",
              mavenPath = mavenPath,
              reason = failureMessage(cause)
            )
        _ <- AtomicFiles
          .moveIntoPlace(tmp, file)
          .left
          .map: cause =>
            raiseInternalServerErr(
              phase = "persist artifact",
              mavenPath = mavenPath,
              reason = failureMessage(cause)
            )
      yield (size, sha256)

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
            repositoryDatabaseFailure(
              phase = "update repository database",
              mavenPath = mavenPath,
              reason = reason
            )
          case Right(_) =>
            Logger.info(s"Archived ${mavenPath}")
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
        raiseInternalServerErr(
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

  private def handleHeadReq(mavenPath: String): RelayResponse =
    pathLock(mavenPath).synchronized:
      val file = localFile(mavenPath)
      if os.exists(file) && os.isFile(file) then cachedHead(mavenPath, file)
      else fetchUpstreamHeadResponse(mavenPath)

  private def cachedHead(mavenPath: String, file: os.Path): RelayResponse =
    repositoryStore.find(mavenPath) match
      case Left(reason) =>
        repositoryDatabaseFailure(
          phase = "read repository database",
          mavenPath = mavenPath,
          reason = reason
        )
      case Right(None) =>
        deleteLocalArtifact(
          mavenPath,
          file,
          reason = "Local artifact not recorded"
        ) match
          case Left(response) => response
          case Right(_)       => fetchUpstreamHeadResponse(mavenPath)
      case Right(Some(recordedFile)) =>
        cachedArtifactMatches(mavenPath, file, recordedFile) match
          case Left(response) => response
          case Right(false) =>
            deleteLocalArtifact(
              mavenPath,
              file,
              reason = "Cached artifact does not match repository database"
            ) match
              case Left(response) => response
              case Right(_)       => fetchUpstreamHeadResponse(mavenPath)
          case Right(true) =>
            RelayResponse(
              statusCode = 200,
              body = RelayBody.Empty,
              headers = headersFor(
                mavenPath,
                size = Some(recordedFile.size),
                upstreamHeaders =
                  Seq("Content-Type" -> recordedFile.contentType)
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

  private def repositoryDatabaseFailure(
      phase: String,
      mavenPath: String,
      reason: String
  ): RelayResponse =
    raiseInternalServerErr(
      phase = phase,
      mavenPath = mavenPath,
      reason = reason
    )

  private def deleteLocalArtifact(
      mavenPath: String,
      file: os.Path,
      reason: String
  ): Either[RelayResponse, Unit] =
    Logger.warning(s"${reason}, deleting: ${mavenPath}")
    for _ <- catchNonFatal(os.remove(file)).left.map: reason =>
        raiseInternalServerErr(
          phase = "delete local artifact",
          mavenPath = mavenPath,
          reason = reason
        )
    yield ()

  private def raiseInternalServerErr(
      phase: String,
      mavenPath: String,
      reason: String
  ): RelayResponse =
    Logger.error(
      s"Local relay failure while ${phase} for ${mavenPath}: ${reason}"
    )
    textResponse(500, "internal server error\n")

  private def upstreamFailure(mavenPath: String, e: Throwable): RelayResponse =
    upstreamFailure(
      mavenPath,
      Option(e.getMessage).getOrElse(e.getClass.getSimpleName)
    )

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

  private def pathLock(mavenPath: String): AnyRef =
    val newLock = new AnyRef
    val existing = pathLocks.putIfAbsent(mavenPath, newLock)
    if existing == null then newLock else existing

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
    val withoutContentLength = upstreamHeaders.filterNot:
      case (name, _) => name.equalsIgnoreCase("Content-Length")
    val hasContentType = withoutContentLength.exists:
      case (name, _) => name.equalsIgnoreCase("Content-Type")
    val withContentType =
      if hasContentType then withoutContentLength
      else ("Content-Type" -> contentTypeFor(mavenPath)) +: withoutContentLength

    withContentType ++ size.map(value => "Content-Length" -> value.toString)

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
    val method = request.exchange.getRequestMethod.toString
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
      case RelayBody.File(path)   => FileData(path)

  private final case class FileData(path: os.Path) extends cask.Response.Data:
    def write(out: java.io.OutputStream): Unit =
      val input = os.read.inputStream(path)
      try
        input.transferTo(out)
        ()
      finally input.close()

    def headers: Seq[(String, String)] = Nil

  private def rootResponse(method: String): RelayResponse =
    val messageBytes =
      "mif Maven relay is running\n".getBytes(StandardCharsets.UTF_8)
    val headers = Seq(
      "Content-Type" -> "text/plain; charset=utf-8",
      "Content-Length" -> messageBytes.length.toString
    )

    method.toUpperCase(Locale.ROOT) match
      case "GET" =>
        RelayResponse(
          statusCode = 200,
          body = RelayBody.Bytes(messageBytes),
          headers = headers
        )
      case "HEAD" =>
        RelayResponse(
          statusCode = 200,
          body = RelayBody.Empty,
          headers = headers
        )
      case method =>
        throw new AssertionError(
          s"unreachable: Cask routed unsupported method ${method} to root"
        )

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
    val failures = Seq(
      "HTTP server" -> RelayHttpServer.stop(server),
      "relay service" -> service.closeEither(),
      "Cask execution context" -> catchNonFatal(shutdownApp())
    ).collect:
      case (resourceLabel, Left(reason)) => s"${resourceLabel}: ${reason}"

    if failures.isEmpty then Right(())
    else Left(s"Failed to close Maven relay handle: ${failures.mkString("; ")}")

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
