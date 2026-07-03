# requests-scala 0.9.2 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `150` non-private declaration signatures from `7` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::requests:0.9.2`
- Upstream docs: https://com-lihaoyi.github.io/requests-scala/
- Source artifacts included:
  - `com.lihaoyi:requests_3:0.9.2`

## Common imports

```scala
import requests.*
```

## Usage notes

Synchronous HTTP client used by the relay for upstream requests. APIs include one-shot methods, sessions, streaming, multipart, proxy, and response wrappers.

```scala
val session = requests.Session(
  headers = Map("User-Agent" -> "mif/0.3.0", "Accept" -> "*/*"),
  readTimeout = 120000,
  connectTimeout = 30000
)

val response: requests.Response =
  session.get("https://repo1.maven.org/maven2/com/example/app/maven-metadata.xml")

if response.statusCode == 200 then
  val bytes: Array[Byte] = response.bytes
  println(response.text())

val tmp = os.temp(prefix = "download")
session.get
  .stream(
    "https://example.com/file.jar",
    onHeadersReceived = headers => println(headers.statusCode)
  )
  .readBytesThrough(input => os.write.over(tmp, input))
```

## API signatures from upstream source

### `com.lihaoyi:requests_3:0.9.2`

Source: https://repo1.maven.org/maven2/com/lihaoyi/requests_3/0.9.2/requests_3-0.9.2-sources.jar

#### `requests/Exceptions.scala`

```scala
class RequestsException(
    val message: String,
    val cause: Option[Throwable] = None,
) extends Exception(message, cause.getOrElse(null))
```

```scala
class TimeoutException(
    val url: String,
    val readTimeout: Int,
    val connectTimeout: Int,
) extends RequestsException(
      s"Request to $url timed out. (readTimeout: $readTimeout, connectTimout: $connectTimeout)",
    )
```

```scala
class UnknownHostException(val url: String, val host: String)
```

```scala
class InvalidCertException(val url: String, cause: Throwable)
```

```scala
class RequestFailedException(val response: Response)
```

#### `requests/Model.scala`

> Mechanisms for compressing the upload stream; supports Gzip and Deflate by default

```scala
trait Compress
```

```scala
def headers: Seq[(String, String)]
```

```scala
def wrap(x: OutputStream): OutputStream
```

```scala
object Compress
```

```scala
object Gzip extends Compress
```

```scala
def headers = ...
```

```scala
def wrap(x: OutputStream) = ...
```

```scala
object Deflate extends Compress
```

```scala
def headers = ...
```

```scala
def wrap(x: OutputStream) = ...
```

```scala
object None extends Compress
```

```scala
def headers = ...
```

```scala
def wrap(x: OutputStream) = ...
```

> The equivalent of configuring a [[Requester.apply]] or [[Requester.stream]] call, but without
> invoking it. Useful if you want to further customize it and make the call later via the overloads
> of `apply`/`stream` that take a [[Request]].

```scala
case class Request(
    url: String,
    auth: RequestAuth = RequestAuth.Empty,
    params: Iterable[(String, String)] = Nil,
    headers: Iterable[(String, String)] = Nil,
    readTimeout: Int = 0,
    connectTimeout: Int = 0,
    proxy: (String, Int) = null,
    cert: Cert = null,
    sslContext: SSLContext = null,
    cookies: Map[String, HttpCookie] = Map(),
    cookieValues: Map[String, String] = Map(),
    maxRedirects: Int = 5,
    verifySslCerts: Boolean = true,
    autoDecompress: Boolean = true,
    compress: Compress = Compress.None,
    keepAlive: Boolean = true,
    check: Boolean = true,
)
```

> Represents the different things you can upload in the body of a HTTP request. By default, allows
> form-encoded key-value pairs, arrays of bytes, strings, files, and InputStreams. These types can
> be passed directly to the `data` parameter of [[Requester.apply]] and will be wrapped
> automatically by the implicit constructors.

```scala
trait RequestBlob
```

```scala
def headers: Seq[(String, String)] = ...
```

```scala
def write(out: java.io.OutputStream): Unit
```

```scala
object RequestBlob
```

```scala
object EmptyRequestBlob extends RequestBlob
```

```scala
def write(out: java.io.OutputStream): Unit = ...
```

```scala
override def headers = ...
```

```scala
implicit class ByteSourceRequestBlob[T](x: T)(implicit f: T => geny.Writable)
```

```scala
override def headers = ...
```

```scala
def write(out: java.io.OutputStream) = ...
```

```scala
implicit class FileRequestBlob(x: java.io.File) extends RequestBlob
```

```scala
override def headers = ...
```

```scala
def write(out: java.io.OutputStream) = ...
```

```scala
implicit class NioFileRequestBlob(x: java.nio.file.Path) extends RequestBlob
```

```scala
override def headers = ...
```

```scala
def write(out: java.io.OutputStream) = ...
```

```scala
implicit class FormEncodedRequestBlob(val x: Iterable[(String, String)]) extends RequestBlob
```

```scala
val serialized = ...
```

```scala
override def headers = ...
```

```scala
def write(out: java.io.OutputStream) = ...
```

```scala
implicit class MultipartFormRequestBlob(val parts: Iterable[MultiItem]) extends RequestBlob
```

```scala
val boundary = ...
```

```scala
val crlf = ...
```

```scala
val pref = ...
```

```scala
val ContentDisposition = ...
```

```scala
val filenameSnippet = ...
```

```scala
val partBytes = ...
```

```scala
override def headers = ...
```

```scala
def write(out: java.io.OutputStream) = ...
```

```scala
case class MultiPart(items: MultiItem*) extends RequestBlob.MultipartFormRequestBlob(items)
```

```scala
case class MultiItem(name: String, data: RequestBlob, filename: String = null)
```

> Wraps the array of bytes returned in the body of a HTTP response

```scala
class ResponseBlob(val bytes: Array[Byte])
```

```scala
override def toString = ...
```

```scala
def text = ...
```

```scala
override def hashCode() = ...
```

```scala
override def equals(obj: scala.Any) = ...
```

> Represents a HTTP response
>
> @param url
> the URL that the original request was made to
> @param statusCode
> the status code of the response
> @param statusMessage
> a string that describes the status code. This is not the reason phrase sent by the server, but
> a string describing [[statusCode]], as hardcoded in this library
> @param headers
> the raw headers the server sent back with the response
> @param data
> the response body; may contain HTML, JSON, or binary or textual data
> @param history
> the response of any redirects that were performed before arriving at the current response

```scala
case class Response(
    url: String,
    statusCode: Int,
    @deprecated("Value is inferred from `statusCode`", "0.9.0")
    statusMessage: String,
    data: geny.Bytes,
    headers: Map[String, Seq[String]],
    history: Option[Response],
) extends geny.ByteData
    with geny.Readable
```

```scala
def bytes = ...
```

```scala
  @deprecated("Use `.bytes`")
def contents = ...
```

> Returns the cookies set by this response, and by any redirects that lead up to it

```scala
val cookies: Map[String, HttpCookie] = ...
```

```scala
def contentType = ...
```

```scala
def location = ...
```

```scala
def is2xx = ...
```

```scala
def is3xx = ...
```

```scala
def is4xx = ...
```

```scala
def is5xx = ...
```

```scala
def readBytesThrough[T](f: java.io.InputStream => T): T = ...
```

```scala
override def httpContentType: Option[String] = ...
```

```scala
override def contentLength: Option[Long] = ...
```

```scala
case class StreamHeaders(
    url: String,
    statusCode: Int,
    @deprecated("Value is inferred from `statusCode`", "0.9.0")
    statusMessage: String,
    headers: Map[String, Seq[String]],
    history: Option[Response],
)
```

```scala
def is2xx = ...
```

```scala
def is3xx = ...
```

```scala
def is4xx = ...
```

```scala
def is5xx = ...
```

> Different ways you can authorize a HTTP request; by default, HTTP Basic auth and Proxy auth are
> supported

```scala
trait RequestAuth
```

```scala
def header: Option[String]
```

```scala
object RequestAuth
```

```scala
object Empty extends RequestAuth
```

```scala
def header = ...
```

```scala
implicit def implicitBasic(x: (String, String)): Basic = ...
```

```scala
class Basic(username: String, password: String) extends RequestAuth
```

```scala
def header = ...
```

```scala
case class Proxy(username: String, password: String) extends RequestAuth
```

```scala
def header = ...
```

```scala
case class Bearer(token: String) extends RequestAuth
```

```scala
def header = ...
```

```scala
sealed trait Cert
```

```scala
object Cert
```

```scala
implicit def implicitP12(path: String): P12 = ...
```

```scala
implicit def implicitP12(x: (String, String)): P12 = ...
```

```scala
case class P12(p12: String, pwd: Option[String] = None) extends Cert
```

#### `requests/Requester.scala`

```scala
trait BaseSession extends AutoCloseable
```

```scala
def headers: Map[String, String]
```

```scala
def cookies: mutable.Map[String, HttpCookie]
```

```scala
def readTimeout: Int
```

```scala
def connectTimeout: Int
```

```scala
def auth: RequestAuth
```

```scala
def proxy: (String, Int)
```

```scala
def cert: Cert
```

```scala
def sslContext: SSLContext
```

```scala
def maxRedirects: Int
```

```scala
def persistCookies: Boolean
```

```scala
def verifySslCerts: Boolean
```

```scala
def autoDecompress: Boolean
```

```scala
def compress: Compress
```

```scala
def chunkedUpload: Boolean
```

```scala
def check: Boolean
```

```scala
lazy val get = ...
```

```scala
lazy val post = ...
```

```scala
lazy val put = ...
```

```scala
lazy val delete = ...
```

```scala
lazy val head = ...
```

```scala
lazy val options = ...
```

```scala
lazy val patch = ...
```

```scala
def send(method: String) = ...
```

```scala
lazy val executor: ExecutorService = ...
```

```scala
lazy val sharedHttpClient: HttpClient = ...
```

> Closes the shared HttpClient and its executor. Call this when you're done
> with the session to release resources and prevent thread leaks.

```scala
def close(): Unit = ...
```

```scala
object BaseSession
```

```scala
val defaultHeaders = ...
```

```scala
def buildHttpClient(
    proxy: (String, Int),
    cert: Cert,
    sslContext: SSLContext,
    verifySslCerts: Boolean,
    connectTimeout: Int,
    executor: ExecutorService
  ): HttpClient = ...
```

> Closes an HttpClient, using reflection to handle both Java 21+ (which has close())
> and earlier versions (which require accessing internal selector).

```scala
def closeHttpClient(httpClient: HttpClient): Unit = ...
```

```scala
object Requester
```

```scala
val officialHttpMethods = ...
```

```scala
case class Requester(verb: String, sess: BaseSession)
```

> Makes a single HTTP request, and returns a [[Response]] object. Requires all uploaded request
> `data` to be provided up-front, and aggregates all downloaded response `data` before returning
> it in the response. If you need streaming access to the upload and download, use the
> [[Requester.stream]] function instead.
>
> @param url
> The URL to which you want to make this HTTP request
> @param auth
> HTTP authentication you want to use with this request; defaults to none
> @param params
> URL params to pass to this request, for `GET`s and `DELETE`s
> @param headers
> Custom headers to use, in addition to the defaults
> @param data
> Body data to pass to this request, for POSTs and PUTs. Can be a Map[String, String] of form
> data, bulk data as a String or Array[Byte], or MultiPart form data.
> @param readTimeout
> How many milliseconds to wait for data to be read before timing out
> @param connectTimeout
> How many milliseconds to wait for a connection before timing out
> @param proxy
> Host and port of a proxy you want to use
> @param cert
> Client certificate configuration
> @param sslContext
> Client sslContext configuration
> @param cookies
> Custom cookies to send up with this request
> @param maxRedirects
> How many redirects to automatically resolve; defaults to 5. You can also set it to 0 to
> prevent Requests from resolving redirects for you
> @param verifySslCerts
> Set this to false to ignore problems with SSL certificates
> @param check
> Throw an exception on a 4xx or 5xx response code. Defaults to `true`

```scala
def apply(
      url: String,
      auth: RequestAuth = sess.auth,
      params: Iterable[(String, String)] = Nil,
      headers: Iterable[(String, String)] = Nil,
      data: RequestBlob = RequestBlob.EmptyRequestBlob,
      readTimeout: Int = sess.readTimeout,
      connectTimeout: Int = sess.connectTimeout,
      proxy: (String, Int) = sess.proxy,
      cert: Cert = sess.cert,
      sslContext: SSLContext = sess.sslContext,
      cookies: Map[String, HttpCookie] = Map(),
      cookieValues: Map[String, String] = Map(),
      maxRedirects: Int = sess.maxRedirects,
      verifySslCerts: Boolean = sess.verifySslCerts,
      autoDecompress: Boolean = sess.autoDecompress,
      compress: Compress = sess.compress,
      keepAlive: Boolean = true,
      check: Boolean = sess.check,
      chunkedUpload: Boolean = sess.chunkedUpload,
  ): Response = ...
```

> Performs a streaming HTTP request. Most of the parameters are the same as [[apply]], except
> that the `data` parameter is missing, and no [[Response]] object is returned. Instead, the
> caller gets access via three callbacks (described below). This provides a lower-level API than
> [[Requester.apply]], allowing the caller fine-grained access to the upload/download streams so
> they can direct them where-ever necessary without first aggregating all the data into memory.
>
> @param onHeadersReceived
> the second callback to be called, this provides access to the response's status code, status
> message, headers, and any previous re-direct responses.
>
> @return
> a `Writable` that can be used to write the output data to any destination

```scala
def stream(
      url: String,
      auth: RequestAuth = sess.auth,
      params: Iterable[(String, String)] = Nil,
      blobHeaders: Iterable[(String, String)] = Nil,
      headers: Iterable[(String, String)] = Nil,
      data: RequestBlob = RequestBlob.EmptyRequestBlob,
      readTimeout: Int = sess.readTimeout,
      connectTimeout: Int = sess.connectTimeout,
      proxy: (String, Int) = sess.proxy,
      cert: Cert = sess.cert,
      sslContext: SSLContext = sess.sslContext,
      cookies: Map[String, HttpCookie] = Map(),
      cookieValues: Map[String, String] = Map(),
      maxRedirects: Int = sess.maxRedirects,
      verifySslCerts: Boolean = sess.verifySslCerts,
      autoDecompress: Boolean = sess.autoDecompress,
      compress: Compress = sess.compress,
      keepAlive: Boolean = true,
      check: Boolean = true,
      chunkedUpload: Boolean = false,
      redirectedFrom: Option[Response] = None,
      onHeadersReceived: StreamHeaders => Unit = null,
  ): geny.Readable = ...
```

> Overload of [[Requester.apply]] that takes a [[Request]] object as configuration

```scala
def apply(r: Request, data: RequestBlob, chunkedUpload: Boolean): Response = ...
```

> Overload of [[Requester.stream]] that takes a [[Request]] object as configuration

```scala
def stream(
      r: Request,
      data: RequestBlob,
      chunkedUpload: Boolean,
      onHeadersReceived: StreamHeaders => Unit,
  ): geny.Writable = ...
```

#### `requests/Session.scala`

> A long-lived session; this can be used to automatically persist cookies from one request to the
> next, or to set default configuration that will be shared between requests. These configuration
> flags can all be over-ridden by the parameters on [[Requester.apply]] or [[Requester.stream]]
>
> @param auth
> HTTP authentication you want to use with this request; defaults to none
> @param headers
> Custom headers to use, in addition to the defaults
> @param readTimeout
> How long to wait for data to be read before timing out
> @param connectTimeout
> How long to wait for a connection before timing out
> @param proxy
> Host and port of a proxy you want to use
> @param cookies
> Custom cookies to send up with this request
> @param maxRedirects
> How many redirects to automatically resolve; defaults to 5. You can also set it to 0 to prevent
> Requests from resolving redirects for you
> @param verifySslCerts
> Set this to false to ignore problems with SSL certificates

```scala
case class Session(
    headers: Map[String, String] = BaseSession.defaultHeaders,
    cookieValues: Map[String, String] = Map(),
    cookies: mutable.Map[String, HttpCookie] = mutable.LinkedHashMap.empty[String, HttpCookie],
    auth: RequestAuth = RequestAuth.Empty,
    proxy: (String, Int) = null,
    cert: Cert = null,
    sslContext: SSLContext = null,
    persistCookies: Boolean = true,
    maxRedirects: Int = 5,
    readTimeout: Int = 10 * 1000,
    connectTimeout: Int = 10 * 1000,
    verifySslCerts: Boolean = true,
    autoDecompress: Boolean = true,
    compress: Compress = Compress.None,
    chunkedUpload: Boolean = false,
    check: Boolean = true,
) extends BaseSession
```

#### `requests/StatusMessages.scala`

```scala
object StatusMessages
```

```scala
val byStatusCode: Map[Int, String] = ...
```

#### `requests/Util.scala`

```scala
object Util
```

```scala
def transferTo(
      is: InputStream,
      os: OutputStream,
      bufferSize: Int = 8 * 1024,
  ) = ...
```

```scala
def urlEncode(x: Iterable[(String, String)]) = ...
```

#### `requests/package.scala`

```scala
package object requests extends _root_.requests.BaseSession
```

```scala
def cookies = ...
```

```scala
val headers = ...
```

```scala
def auth = ...
```

```scala
def proxy = ...
```

```scala
def cert: Cert = ...
```

```scala
def sslContext: SSLContext = ...
```

```scala
def maxRedirects: Int = ...
```

```scala
def persistCookies = ...
```

```scala
def readTimeout: Int = ...
```

```scala
def connectTimeout: Int = ...
```

```scala
def verifySslCerts: Boolean = ...
```

```scala
def autoDecompress: Boolean = ...
```

```scala
def compress: Compress = ...
```

```scala
def chunkedUpload: Boolean = ...
```

```scala
def check: Boolean = ...
```

