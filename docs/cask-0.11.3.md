# Cask 0.11.3 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `509` non-private declaration signatures from `26` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::cask:0.11.3`
- Upstream docs: https://com-lihaoyi.github.io/cask/
- Source artifacts included:
  - `com.lihaoyi:cask_3:0.11.3`

## Common imports

```scala
import cask.*
```

## Usage notes

Lightweight HTTP routing framework used by the Maven relay server. APIs include route annotations, `Routes`, `Main`, `Request`, `Response`, static files, forms, JSON, and websockets.

```scala
object App extends cask.Main:
  override def host: String = "127.0.0.1"
  override def port: Int = 8081

  @cask.get("/")
  def hello() = cask.Response("ok\n", statusCode = 200)

  @cask.route("/api", methods = Seq("get", "head"))
  def api(request: cask.Request) =
    cask.Response(s"method=${request.exchange.getRequestMethod}\n")

  initialize()
```

## API signatures from upstream source

### `com.lihaoyi:cask_3:0.11.3`

Source: https://repo1.maven.org/maven2/com/lihaoyi/cask_3/0.11.3/cask_3-0.11.3-sources.jar

#### `cask/decorators/compress.scala`

```scala
class compress extends cask.RawDecorator
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate) = ...
```

#### `cask/endpoints/FormEndpoint.scala`

```scala
sealed trait FormReader[T] extends ArgReader[Seq[FormEntry], T, Request]
```

```scala
object FormReader
```

```scala
implicit def paramFormReader[T: QueryParamReader]: FormReader[T] = ...
```

```scala
implicit def formEntryReader: FormReader[FormEntry] = ...
```

```scala
implicit def formEntriesReader: FormReader[Seq[FormEntry]] = ...
```

```scala
implicit def formValueReader: FormReader[FormValue] = ...
```

```scala
implicit def formValuesReader: FormReader[Seq[FormValue]] = ...
```

```scala
implicit def formFileReader: FormReader[FormFile] = ...
```

```scala
implicit def formFilesReader: FormReader[Seq[FormFile]] = ...
```

```scala
class postForm(val path: String, override val subpath: Boolean = false)
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
def wrapFunction(ctx: Request,
                       delegate: Delegate): Result[Response.Raw] = ...
```

```scala
def wrapPathSegment(s: String): Seq[FormEntry] = ...
```

#### `cask/endpoints/JsonEndpoint.scala`

```scala
sealed trait JsReader[T] extends ArgReader[ujson.Value, T, cask.model.Request]
```

```scala
object JsReader
```

```scala
implicit def defaultJsReader[T: upickle.default.Reader]: JsReader[T] = ...
```

```scala
implicit def paramReader[T: ParamReader]: JsReader[T] = ...
```

```scala
trait JsonData extends Response.Data
```

```scala
object JsonData extends DataCompanion[JsonData]
```

```scala
implicit class JsonDataImpl[T: upickle.default.Writer](t: T) extends JsonData
```

```scala
def headers = ...
```

```scala
def write(out: OutputStream) = ...
```

```scala
class postJsonCached(path: String, subpath: Boolean = false) extends postJsonBase(path, subpath, true)
```

```scala
class postJson(path: String, subpath: Boolean = false) extends postJsonBase(path, subpath, false)
```

```scala
abstract class postJsonBase(val path: String, override val subpath: Boolean = false, cacheBody: Boolean = false)
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate): Result[Response.Raw] = ...
```

```scala
def wrapPathSegment(s: String): ujson.Value = ...
```

```scala
class getJson(val path: String, override val subpath: Boolean = false)
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate): Result[Response.Raw] = ...
```

```scala
def wrapPathSegment(s: String) = ...
```

#### `cask/endpoints/ParamReader.scala`

```scala
abstract class ParamReader[T] extends ArgReader[Unit, T, cask.model.Request]
```

```scala
def arity: Int
```

```scala
def read(ctx: cask.model.Request, label: String, v: Unit): T
```

```scala
object ParamReader
```

```scala
class NilParam[T](f: (Request, String) => T) extends ParamReader[T]
```

```scala
def arity = ...
```

```scala
def read(ctx: cask.model.Request, label: String, v: Unit): T = ...
```

```scala
implicit object HttpExchangeParam extends NilParam[HttpServerExchange]((ctx, label) => ctx.exchange)
```

```scala
implicit object FormDataParam extends NilParam[FormData]((ctx, label) =>
    FormParserFactory.builder().build().createParser(ctx.exchange).parseBlocking()
  )
```

```scala
implicit object RequestParam extends NilParam[Request]((ctx, label) => ctx)
```

```scala
implicit object CookieParam extends NilParam[Cookie]((ctx, label) =>
    Cookie.fromUndertow(ctx.exchange.getRequestCookies().get(label))
  )
```

```scala
implicit object QueryParams extends ParamReader[cask.model.QueryParams]
```

```scala
def arity: Int = ...
```

```scala
override def unknownQueryParams = ...
```

```scala
def read(ctx: cask.model.Request, label: String, v: Unit) = ...
```

```scala
implicit object RemainingPathSegments extends ParamReader[cask.model.RemainingPathSegments]
```

```scala
def arity: Int = ...
```

```scala
override def remainingPathSegments = ...
```

```scala
def read(ctx: cask.model.Request, label: String, v: Unit) = ...
```

#### `cask/endpoints/StaticEndpoints.scala`

```scala
object StaticUtil
```

```scala
def makePathAndContentType(t: String, ctx: Request) = ...
```

```scala
class staticFiles(val path: String, headers: Seq[(String, String)] = Nil) extends HttpEndpoint[String, Seq[String]]
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
override def subpath = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate) = ...
```

```scala
def wrapPathSegment(s: String): Seq[String] = ...
```

```scala
class staticResources(val path: String,
                      resourceRoot: ClassLoader = classOf[staticResources].getClassLoader,
                      headers: Seq[(String, String)] = Nil)
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
override def subpath = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate) = ...
```

```scala
def wrapPathSegment(s: String): Seq[String] = ...
```

#### `cask/endpoints/WebEndpoints.scala`

```scala
trait WebEndpoint extends HttpEndpoint[Response.Raw, Seq[String]]
```

```scala
type InputParser[T] = ...
```

```scala
def wrapFunction(ctx: Request,
                       delegate: Delegate): Result[Response.Raw] = ...
```

```scala
def wrapPathSegment(s: String) = ...
```

```scala
object WebEndpoint
```

```scala
def buildMapFromQueryParams(ctx: Request) = ...
```

```scala
class get(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
class post(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
class put(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
class patch(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
class delete(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
class route(val path: String, val methods: Seq[String], override val subpath: Boolean = false) extends WebEndpoint
```

```scala
class options(val path: String, override val subpath: Boolean = false) extends WebEndpoint
```

```scala
val methods = ...
```

```scala
abstract class QueryParamReader[T]
  extends ArgReader[Seq[String], T, cask.model.Request]
```

```scala
def arity: Int
```

```scala
def read(ctx: cask.model.Request, label: String, v: Seq[String]): T
```

```scala
object QueryParamReader
```

```scala
class SimpleParam[T](f: String => T) extends QueryParamReader[T]
```

```scala
def arity = ...
```

```scala
def read(ctx: cask.model.Request, label: String, v: Seq[String]): T = ...
```

```scala
implicit object StringParam extends SimpleParam[String](x => x)
```

```scala
implicit object BooleanParam extends SimpleParam[Boolean](_.toBoolean)
```

```scala
implicit object ByteParam extends SimpleParam[Byte](_.toByte)
```

```scala
implicit object ShortParam extends SimpleParam[Short](_.toShort)
```

```scala
implicit object IntParam extends SimpleParam[Int](_.toInt)
```

```scala
implicit object LongParam extends SimpleParam[Long](_.toLong)
```

```scala
implicit object DoubleParam extends SimpleParam[Double](_.toDouble)
```

```scala
implicit object FloatParam extends SimpleParam[Float](_.toFloat)
```

```scala
implicit def SeqParam[T: QueryParamReader]: QueryParamReader[Seq[T]] = ...
```

```scala
implicit def OptionParam[T: QueryParamReader]: QueryParamReader[Option[T]] = ...
```

```scala
implicit def paramReader[T: ParamReader]: QueryParamReader[T] = ...
```

#### `cask/endpoints/WebSocketEndpoint.scala`

```scala
sealed trait WebsocketResult
```

```scala
object WebsocketResult
```

```scala
implicit class Response[T](value0: cask.model.Response[T])
```

```scala
def value = ...
```

```scala
implicit class Listener(val value: WebSocketConnectionCallback) extends WebsocketResult
```

```scala
class websocket(val path: String, override val subpath: Boolean = false)
```

```scala
val methods = ...
```

```scala
type InputParser[T] = ...
```

```scala
type OuterReturned = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate) = ...
```

```scala
def wrapPathSegment(s: String): Seq[String] = ...
```

```scala
case class WsHandler(f: WsChannelActor => castor.Actor[Ws.Event])
```

```scala
class WsChannelActor(channel: WebSocketChannel)
```

```scala
case class WsActor(handle: PartialFunction[Ws.Event, Unit])
```

#### `cask/internal/Conversion.scala`

```scala
@implicitNotFound("Cannot return ${T} as a ${V}")
class Conversion[T, V](val f: T => V)
```

```scala
object Conversion
```

```scala
implicit def create[T, V](implicit f: T => V): Conversion[T, V] = ...
```

#### `cask/internal/DispatchTrie.scala`

```scala
object DispatchTrie
```

```scala
def construct[T, V](index: Int,
                      inputs: collection.Seq[(collection.IndexedSeq[String], T, Boolean)])
```

```scala
def validateGroup[T, V](terminals: collection.Seq[(collection.Seq[String], T, Boolean, V)],
                          continuations: mutable.Map[String, mutable.Buffer[(collection.IndexedSeq[String], T, Boolean, V)]]) = ...
```

```scala
def renderPath(p: collection.Seq[String]) = ...
```

> A simple Trie that can be compiled from a list of endpoints, to allow
> endpoint lookup in O(length-of-request-path) time. Lookup returns the
> [[T]] this trie contains, as well as a map of bound wildcards (path
> segments starting with `:`) and any remaining un-used path segments
> (only when `current._2 == true`, indicating this route allows trailing
> segments)
> current = (value, captures subpaths, argument names)

```scala
case class DispatchTrie[T](
  current: Option[(T, Boolean, Vector[String])],
  staticChildren: Map[String, DispatchTrie[T]],
  dynamicChildren: Option[DispatchTrie[T]]
)
```

```scala
final def lookup(remainingInput: List[String],
                   bindings: Vector[String])
```

```scala
def map[V](f: T => V): DispatchTrie[V] = ...
```

#### `cask/internal/ThreadBlockingHandler.scala`

> A handler that dispatches the request to the given handler using the given executor.

```scala
final class ThreadBlockingHandler(executor: Executor, handler: HttpHandler) extends HttpHandler
```

```scala
def handleRequest(exchange: HttpServerExchange): Unit = ...
```

#### `cask/internal/Util.scala`

```scala
object Util
```

> Create a virtual thread executor with the given executor as the scheduler.

```scala
def createVirtualThreadExecutor(executor: Executor): Option[ExecutorService] = ...
```

> Create a default cask virtual thread executor if possible.

```scala
def createDefaultCaskVirtualThreadExecutor: Option[ExecutorService] = ...
```

> Try to get the default virtual thread scheduler, or null if not supported.

```scala
def getDefaultVirtualThreadScheduler: Option[ForkJoinPool] = ...
```

```scala
def createNewThreadPerTaskExecutor(threadFactory: ThreadFactory): ExecutorService = ...
```

> Create a dedicated forkjoin based scheduler for the virtual thread.
> NOTE: you can use other threads pool as scheduler too, this method just integrated the `CarrierThreadFactory`
> when creating the ForkJoinPool.

```scala
def createForkJoinPoolBasedScheduler(parallelism: Int,
                                       corePoolSize: Int,
                                       maximumPoolSize: Int,
                                       keepAliveTime: Int,
                                       timeUnit: TimeUnit): Executor = ...
```

> Create a virtual thread factory with a executor, the executor will be used as the scheduler of
> virtual thread.
>
> The executor should run task on platform threads.
>
> returns null if not supported.

```scala
def createVirtualThreadFactory(prefix: String,
                                 executor: Executor): ThreadFactory = ...
```

```scala
def firstFutureOf[T](futures: Seq[Future[T]])(implicit ec: ExecutionContext) = ...
```

> Convert a string to a C&P-able literal. Basically
> copied verbatim from the uPickle source code.

```scala
def literalize(s: IndexedSeq[Char], unicode: Boolean = true) = ...
```

```scala
def transferTo(in: InputStream, out: OutputStream) = ...
```

```scala
def pluralize(s: String, n: Int) = ...
```

> Splits a string into path segments; automatically removes all
> leading/trailing slashes, and ignores empty path segments.
>
> Written imperatively for performance since it's used all over the place.

```scala
def splitPath(p: String): collection.IndexedSeq[String] = ...
```

```scala
def stackTraceString(e: Throwable) = ...
```

```scala
def softWrap(s: String, leftOffset: Int, maxWidth: Int) = ...
```

```scala
def sequenceEither[A, B, M[X] <: TraversableOnce[X]](in: M[Either[A, B]])(
    implicit cbf: CanBuildFrom[M[Either[A, B]], B, M[B]]): Either[A, M[B]] = ...
```

#### `cask/main/ErrorMsgs.scala`

```scala
object ErrorMsgs
```

```scala
def getLeftColWidth(items: Seq[ArgSig[_, _, _,_]]) = ...
```

```scala
def renderArg[T](base: T,
                   arg: ArgSig[_, T, _, _],
                   leftOffset: Int,
                   wrappedWidth: Int): (String, String) = ...
```

```scala
def formatMainMethodSignature[T](base: T,
                                   main: EntryPoint[T, _],
                                   leftIndent: Int,
                                   leftColWidth: Int) = ...
```

```scala
def formatInvokeError[T](base: T, route: EntryPoint[T, _], x: Result.Error): String = ...
```

#### `cask/main/Main.scala`

> A combination of [[cask.Main]] and [[cask.Routes]], ideal for small
> one-file web applications.

```scala
class MainRoutes extends Main with Routes
```

```scala
def allRoutes = ...
```

> Defines the main entrypoint and configuration of the Cask web application.
>
> You can pass in an arbitrary number of [[cask.Routes]] objects for it to
> serve, and override various properties on [[Main]] in order to configure
> application-wide properties.

```scala
abstract class Main
```

```scala
def mainDecorators: Seq[Decorator[_, _, _, _]] = ...
```

```scala
def allRoutes: Seq[Routes]
```

```scala
def port: Int = ...
```

```scala
def host: String = ...
```

```scala
def verbose = ...
```

```scala
def debugMode: Boolean = ...
```

```scala
def createExecutionContext = ...
```

```scala
def createActorContext = ...
```

```scala
val executionContext = ...
```

```scala
implicit val actorContext: castor.Context = ...
```

```scala
implicit def log: cask.util.Logger = ...
```

```scala
def dispatchTrie = ...
```

```scala
def defaultHandler: HttpHandler = ...
```

```scala
def handleNotFound(req: Request): Response.Raw = ...
```

```scala
def handleMethodNotAllowed(req: Request): Response.Raw = ...
```

```scala
def handleEndpointError(routes: Routes,
                          metadata: EndpointMetadata[_],
                          e: cask.router.Result.Error,
                          req: Request): Response.Raw = ...
```

```scala
def main(args: Array[String]): Unit = ...
```

```scala
object Main
```

> property key to enable virtual thread support.

```scala
val VIRTUAL_THREAD_ENABLED = ...
```

```scala
class DefaultHandler(dispatchTrie: DispatchTrie[Map[String, (Routes, EndpointMetadata[_])]],
                       mainDecorators: Seq[Decorator[_, _, _, _]],
                       debugMode: Boolean,
                       handleNotFound: Request => Response.Raw,
                       handleMethodNotAllowed: Request => Response.Raw,
                       handleError: (Routes, EndpointMetadata[_], Result.Error, Request) => Response.Raw)
```

```scala
def handleRequest(exchange: HttpServerExchange): Unit = ...
```

```scala
def defaultHandleNotFound(req: Request): Response.Raw = ...
```

```scala
def defaultHandleMethodNotAllowed(req: Request): Response.Raw = ...
```

```scala
def prepareDispatchTrie(allRoutes: Seq[Routes]): DispatchTrie[Map[String, (Routes, EndpointMetadata[_])]] = ...
```

```scala
def writeResponse(exchange: HttpServerExchange, response: Response.Raw) = ...
```

```scala
def defaultHandleError(routes: Routes,
                         metadata: EndpointMetadata[_],
                         e: Result.Error,
                         debugMode: Boolean,
                         req: Request)
```

```scala
def silenceJboss(): Unit = ...
```

#### `cask/main/Routes.scala`

```scala
trait Routes
```

```scala
def decorators = ...
```

```scala
def caskMetadata = ...
```

#### `cask/model/Params.scala`

```scala
case class QueryParams(value: Map[String, collection.Seq[String]])
```

```scala
case class RemainingPathSegments(value: Seq[String])
```

```scala
case class Request(exchange: HttpServerExchange, remainingPathSegments: Seq[String], boundPathSegments: Map[String, String])
```

```scala
object Cookie
```

```scala
def fromUndertow(from: io.undertow.server.handlers.Cookie): Cookie = ...
```

```scala
def toUndertow(from: Cookie): io.undertow.server.handlers.Cookie = ...
```

```scala
case class Cookie(name: String,
                  value: String,
                  comment: String = null,
                  domain: String = null,
                  expires: java.time.Instant = null,
                  maxAge: Integer = null,
                  path: String = null,
                  version: Int = 1,
                  discard: Boolean = false,
                  httpOnly: Boolean = false,
                  secure: Boolean = false,
                  sameSite: String = "Lax")
```

```scala
sealed trait FormEntry
```

```scala
def valueOrFileName: String
```

```scala
def headers: io.undertow.util.HeaderMap
```

```scala
def asFile: Option[FormFile] = ...
```

```scala
object FormEntry
```

```scala
def fromUndertow(from: io.undertow.server.handlers.form.FormData.FormValue): FormEntry = ...
```

```scala
case class FormValue(value: String,
                     headers: io.undertow.util.HeaderMap) extends FormEntry
```

```scala
def valueOrFileName = ...
```

```scala
case class FormFile(fileName: String,
                    filePath: Option[java.nio.file.Path],
                    headers: io.undertow.util.HeaderMap) extends FormEntry
```

```scala
def valueOrFileName = ...
```

```scala
case class EmptyFormEntry()
```

#### `cask/model/Response.scala`

> The basic response returned by a HTTP endpoint.
>
> Note that [[data]] by default can take in a wide range of types: strings,
> bytes, uPickle JSON-convertable types or arbitrary input streams. You can
> also construct your own implementations of `Response.Data`.

```scala
case class Response[+T](
  data: T,
  statusCode: Int,
  headers: Seq[(String, String)],
  cookies: Seq[Cookie]
)
```

```scala
def map[V](f: T => V) = ...
```

```scala
object Response
```

```scala
type Raw = ...
```

```scala
def apply[T](data: T,
               statusCode: Int = 200,
               headers: Seq[(String, String)] = Nil,
               cookies: Seq[Cookie] = Nil) = ...
```

```scala
trait Data
```

```scala
def write(out: OutputStream): Unit
```

```scala
def headers: Seq[(String, String)]
```

```scala
trait DataCompanion[V]
```

```scala
implicit def dataResponse[T](t: T)(implicit c: T => V): Response[V] = ...
```

```scala
implicit def dataResponse2[T](t: Response[T])(implicit c: T => V): Response[V] = ...
```

```scala
object Data extends DataCompanion[Data]
```

```scala
implicit class UnitData(s: Unit) extends Data
```

```scala
def write(out: OutputStream) = ...
```

```scala
def headers = ...
```

```scala
implicit class WritableData[T](s: T)(implicit f: T => geny.Writable) extends Data
```

```scala
val writable = ...
```

```scala
def write(out: OutputStream) = ...
```

```scala
def headers = ...
```

```scala
implicit class NumericData[T: Numeric](s: T) extends Data
```

```scala
def write(out: OutputStream) = ...
```

```scala
def headers = ...
```

```scala
implicit class BooleanData(s: Boolean) extends Data
```

```scala
def write(out: OutputStream) = ...
```

```scala
def headers = ...
```

```scala
object Redirect
```

```scala
def apply(url: String) = ...
```

```scala
object Abort
```

```scala
def apply(code: Int) = ...
```

```scala
object StaticFile
```

```scala
def apply(path: String, headers: Seq[(String, String)]) = ...
```

```scala
object StaticResource
```

```scala
def apply(path: String, resourceRoot: ClassLoader, headers: Seq[(String, String)]) = ...
```

#### `cask/model/Status.scala`

```scala
sealed trait Status
```

```scala
val code: Int
```

```scala
val reason: String
```

```scala
object Status
```

```scala
val codesToStatus: Map[Int, Status] = ...
```

```scala
val statusToCodes: Map[String, Int] = ...
```

```scala
case class Unknown(code: Int, reason: String) extends Status
```

```scala
case object Continue extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object SwitchingProtocols extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object OK extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Created extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Accepted extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NonAuthoritativeInformation extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NoContent extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object ResetContent extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object PartialContent extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object MultipleChoices extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object MovedPermanently extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Found extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object SeeOther extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NotModified extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object UseProxy extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object TemporaryRedirect extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object PermanentRedirect extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object BadRequest extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Unauthorized extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object PaymentRequired extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Forbidden extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NotFound extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object MethodNotAllowed extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NotAcceptable extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object ProxyAuthenticationRequired extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object RequestTimeout extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Conflict extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Gone extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object LengthRequired extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object PreconditionFailed extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object RequestEntityTooLarge extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object RequestURITooLong extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object UnsupportedMediaType extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object RequestedRangeNotSatisfiable extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object ExpectationFailed extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object Teapot extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object EnhanceYourCalm extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object TooManyRequests extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object UnavailableForLegalReasons extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object InternalServerError extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object NotImplemented extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object BadGateway extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object ServiceUnavailable extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object GatewayTimeout extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

```scala
case object HTTPVersionNotSupported extends Status
```

```scala
val code = ...
```

```scala
val reason: String = ...
```

#### `cask/package.scala`

```scala
package object cask
```

```scala
type Response[T] = ...
```

```scala
val Response = ...
```

```scala
val Abort = ...
```

```scala
val Redirect = ...
```

```scala
val StaticFile = ...
```

```scala
val StaticResource = ...
```

```scala
type FormEntry = ...
```

```scala
val FormEntry = ...
```

```scala
type FormValue = ...
```

```scala
val FormValue = ...
```

```scala
type FormFile = ...
```

```scala
val FormFile = ...
```

```scala
type Cookie = ...
```

```scala
val Cookie = ...
```

```scala
type Request = ...
```

```scala
val Request = ...
```

```scala
type QueryParams = ...
```

```scala
val QueryParams = ...
```

```scala
type RemainingPathSegments = ...
```

```scala
val RemainingPathSegments = ...
```

```scala
type websocket = ...
```

```scala
val WebsocketResult = ...
```

```scala
type WebsocketResult = ...
```

```scala
type get = ...
```

```scala
type post = ...
```

```scala
type put = ...
```

```scala
type delete = ...
```

```scala
type patch = ...
```

```scala
type route = ...
```

```scala
type staticFiles = ...
```

```scala
type staticResources = ...
```

```scala
type postJson = ...
```

```scala
type postJsonCached = ...
```

```scala
type getJson = ...
```

```scala
type postForm = ...
```

```scala
type options = ...
```

```scala
type MainRoutes = ...
```

```scala
type Routes = ...
```

```scala
type Main = ...
```

```scala
type RawDecorator = ...
```

```scala
type HttpEndpoint[InnerReturned, Input] = ...
```

```scala
type WsHandler = ...
```

```scala
val WsHandler = ...
```

```scala
type WsActor = ...
```

```scala
val WsActor = ...
```

```scala
type WsChannelActor = ...
```

```scala
type WsClient = ...
```

```scala
val WsClient = ...
```

```scala
val Ws = ...
```

```scala
type Logger = ...
```

```scala
val Logger = ...
```

#### `cask/router/Decorators.scala`

> A [[Decorator]] allows you to annotate a function to wrap it, via
> `wrapFunction`. You can use this to perform additional validation before or
> after the function runs, provide an additional parameter list of params,
> open/commit/rollback database transactions before/after the function runs,
> or even retrying the wrapped function if it fails.
>
> Calls to the wrapped function are done on the `delegate` parameter passed
> to `wrapFunction`, which takes a `Map` representing any additional argument
> lists (if any).

```scala
trait Decorator[OuterReturned, InnerReturned, Input, InputContext] extends scala.annotation.Annotation
```

```scala
final type InputTypeAlias = ...
```

```scala
type InputParser[T] <: ArgReader[Input, T, InputContext]
```

```scala
final type Delegate = ...
```

```scala
def wrapFunction(ctx: Request, delegate: Delegate): Result[OuterReturned]
```

```scala
def getParamParser[T](implicit p: InputParser[T]) = ...
```

```scala
object Decorator
```

> A stack of [[Decorator]]s is invoked recursively: each decorator's `wrapFunction`
> is invoked around the invocation of all inner decorators, with the inner-most
> decorator finally invoking the route's [[EntryPoint.invoke]] function.
>
> Each decorator (and the final `Endpoint`) contributes a dictionary of name-value
> bindings, which are eventually all passed to [[EntryPoint.invoke]]. Each decorator's
> dictionary corresponds to a different argument list on [[EntryPoint.invoke]]. The
> bindings passed from the router are aggregated with those from the `EndPoint` and
> used as the first argument list.

```scala
def invoke[T](ctx: Request,
                endpoint: Endpoint[_, _, _, _],
                entryPoint: EntryPoint[T, _],
                routes: T,
                remainingDecorators: List[Decorator[_, _, _, _]],
                inputContexts: List[Any],
                bindings: List[Map[String, Any]]): Result[Any] = ...
```

> A [[RawDecorator]] is a decorator that operates on the raw request and
> response stream, before and after the primary [[Endpoint]] does it's job.

```scala
trait RawDecorator extends Decorator[Response.Raw, Response.Raw, Any, Request]
```

```scala
type InputParser[T] = ...
```

> An [[HttpEndpoint]] that may return something else than a HTTP response, e.g.
> a websocket endpoint which may instead return a websocket event handler

```scala
trait Endpoint[OuterReturned, InnerReturned, Input, InputContext]
  extends Decorator[OuterReturned, InnerReturned, Input, InputContext]
```

> What is the path that this particular endpoint matches?

```scala
val path: String
```

> Which HTTP methods does this endpoint support? POST? GET? PUT? Or some
> combination of those?

```scala
val methods: Seq[String]
```

> Whether or not this endpoint allows matching on sub-paths: does
> `@endpoint("/foo")` capture the path "/foo/bar/baz"? Useful to e.g. have
> an endpoint match URLs with paths in a filesystem (real or virtual) to
> serve files

```scala
def subpath: Boolean = ...
```

```scala
def convertToResultType[T](t: T)
```

> [[HttpEndpoint]]s are unique among decorators in that they alone can bind
> path segments to parameters, e.g. binding `/hello/:world` to `(world: Int)`.
> In order to do so, we need to box up the path segment strings into an
> [[Input]] so they can later be parsed by [[getParamParser]] into an
> instance of the appropriate type.

```scala
def wrapPathSegment(s: String): Input
```

> Annotates a Cask endpoint that returns a HTTP [[Response]]; similar to a
> [[RawDecorator]] but with additional metadata and capabilities.

```scala
trait HttpEndpoint[InnerReturned, Input] extends Endpoint[Response.Raw, InnerReturned, Input, Request]
```

```scala
class NoOpParser[Input, T, InputContext] extends ArgReader[Input, T, InputContext]
```

```scala
def arity = ...
```

```scala
def read(ctx: InputContext, label: String, input: Input) = ...
```

```scala
object NoOpParser
```

```scala
implicit def instance[Input, T, InputContext]: NoOpParser[Input, T, InputContext] = ...
```

```scala
implicit def instanceAny[T, InputContext]: NoOpParser[Any, T, InputContext] = ...
```

```scala
implicit def instanceAnyRequest[T]: NoOpParser[Any, T, Request] = ...
```

#### `cask/router/EndpointMetadata.scala`

```scala
case class EndpointMetadata[T](decorators: Seq[Decorator[_, _, _, _]],
                               endpoint: Endpoint[_, _, _, _],
                               entryPoint: EntryPoint[T, _])
```

```scala
object EndpointMetadata
```

```scala
def seqify1(d: Decorator[_, _, _, _]) = ...
```

```scala
def seqify2[T1]
             (d1: Decorator[T1, _, _, _])
```

```scala
def seqify3[T1, T2]
             (d1: Decorator[T1, _, _, _])
```

```scala
def seqify4[T1, T2, T3]
             (d1: Decorator[T1, _, _, _])
```

```scala
def seqify5[T1, T2, T3, T4]
             (d1: Decorator[T1, _, _, _])
```

```scala
def seqify6[T1, T2, T3, T4, T5]
             (d1: Decorator[T1, _, _, _])
```

#### `cask/router/EntryPoint.scala`

> What is known about a single endpoint for our routes. It has a [[name]],
> [[argSignatures]] for each argument, and a macro-generated [[invoke0]]
> that performs all the necessary argument parsing and de-serialization.
>
> Realistically, you will probably spend most of your time calling [[invoke]]
> instead, which provides a nicer API to call it that mimmicks the API of
> calling a Scala method.

```scala
case class EntryPoint[T, C](name: String,
                            argSignatures: Seq[Seq[ArgSig[_, T, _, C]]],
                            doc: Option[String],
                            invoke0: (T, Seq[C], Seq[Map[String, Any]], Seq[Seq[ArgSig[Any, _, _, C]]]) => Result[Any])
```

```scala
val firstArgs = ...
```

```scala
def invoke(target: T,
             ctxs: Seq[C],
             paramLists: Seq[Map[String, Any]]): Result[Any] = ...
```

#### `cask/router/Macros.scala`

```scala
object Macros
```

> Check that decorator inner and outer return types match.
>
> This replicates EndpointMetadata.seqify, but in a macro where error
> positions can be controlled.

```scala
def checkDecorators(using Quotes)(decorators: List[Expr[Decorator[_, _, _, _]]]): Boolean = ...
```

> Lookup default values for a method's parameters.

```scala
def getDefaultParams(using Quotes)(method: quotes.reflect.Symbol): Map[quotes.reflect.Symbol, Expr[Any]] = ...
```

> Summon the reader for a parameter.

```scala
def summonReader(using Quotes)(
    decorator: Expr[Decorator[_,_,_,_]],
    param: quotes.reflect.Symbol
  ): Expr[ArgReader[_, _, _]] = ...
```

> Call a method given by its symbol.
>
> E.g.
>
> assuming:
>
> def foo(x: Int, y: String)(z: Int)
>
> val argss: List[List[Any]] = ???
>
> then:
>
> call(<symbol of foo>, '{argss})
>
> will expand to:
>
> foo(argss(0)(0), argss(0)(1))(argss(1)(0))

```scala
def call(using Quotes)(
    method: quotes.reflect.Symbol,
    argss: Expr[Seq[Seq[Any]]]
  ): Expr[_] = ...
```

> Convert a result to an HTTP response
>
> Note: essentially, all this method does is summon a `cask.internal.Conversion`
> and provide a helpful error message if it cannot be found. In this case,
> one could wonder why we do the implicit summoning in this macro, rather than
> emit "regular" code which does the summoning. The reason is to provide
> helpful error messages with correct positions. We can control the position
> in the macro, but if the error were to come from the expanded code the position
> would be completely off.

```scala
def convertToResponse(using Quotes)(
    method: quotes.reflect.Symbol,
    endpoint: Expr[Endpoint[_, _, _, _]],
    result: Expr[Any]
  ): Expr[Any] = ...
```

> The type of paramters displayed in error messages

```scala
def friendlyName(using Quotes)(param: quotes.reflect.ValDef): String = ...
```

```scala
def extractMethod[Cls: Type](using q: Quotes)(
    method: quotes.reflect.Symbol,
    decorators: List[Expr[Decorator[_, _, _, _]]], // these must also include the endpoint
    endpoint: Expr[Endpoint[_, _, _, _]]
  ): Expr[EntryPoint[Cls, Any]] = ...
```

#### `cask/router/Misc.scala`

```scala
class doc(s: String) extends StaticAnnotation
```

> Models what is known by the router about a single argument: that it has
> a [[name]], a human-readable [[typeString]] describing what the type is
> (just for logging and reading, not a replacement for a `TypeTag`) and
> possible a function that can compute its default value

```scala
case class ArgSig[I, -T, +V, -C](name: String,
                                 typeString: String,
                                 doc: Option[String],
                                 default: Option[T => V])
```

```scala
trait ArgReader[I, +T, -C]
```

```scala
def arity: Int
```

```scala
def unknownQueryParams: Boolean = ...
```

```scala
def remainingPathSegments: Boolean = ...
```

```scala
def read(ctx: C, label: String, input: I): T
```

#### `cask/router/Result.scala`

> Represents what comes out of an attempt to invoke an [[EntryPoint]].
> Could succeed with a value, but could fail in many different ways.

```scala
sealed trait Result[+T]
```

```scala
def map[V](f: T => V): Result[V]
```

```scala
def transform[V](f: PartialFunction[Any, V]): Result[V]
```

```scala
object Result
```

> Invoking the [[EntryPoint]] was totally successful, and returned a
> result

```scala
case class Success[T](value: T) extends Result[T]
```

```scala
def map[V](f: T => V) = ...
```

```scala
def transform[V](f: PartialFunction[Any, V]) = ...
```

> Invoking the [[EntryPoint]] was not successful

```scala
sealed trait Error extends Result[Nothing]
```

```scala
def map[V](f: Nothing => V) = ...
```

```scala
def transform[V](f: PartialFunction[Any, V]) = ...
```

```scala
object Error
```

> Invoking the [[EntryPoint]] failed with an exception while executing
> code within it.

```scala
case class Exception(t: Throwable) extends Error
```

> Invoking the [[EntryPoint]] failed because the arguments provided
> did not line up with the arguments expected

```scala
case class MismatchedArguments(missing: Seq[ArgSig[_, _, _, _]],
                                   unknown: Seq[String]) extends Error
```

> Invoking the [[EntryPoint]] failed because there were problems
> deserializing/parsing individual arguments

```scala
case class InvalidArguments(values: Seq[ParamError]) extends Error
```

```scala
sealed trait ParamError
```

```scala
object ParamError
```

> Something went wrong trying to de-serialize the input parameter;
> the thrown exception is stored in [[ex]]

```scala
case class Invalid(arg: ArgSig[_, _, _, _], value: String, ex: Throwable) extends ParamError
```

> Something went wrong trying to evaluate the default value
> for this input parameter

```scala
case class DefaultFailed(arg: ArgSig[_, _, _, _], ex: Throwable) extends ParamError
```

#### `cask/router/RoutesEndpointMetadata.scala`

```scala
case class RoutesEndpointsMetadata[T](value: Seq[EndpointMetadata[T]])
```

```scala
object RoutesEndpointsMetadata
```

```scala
inline given initialize[T]: RoutesEndpointsMetadata[T] = ...
```

```scala
def setRoutesImpl[T: Type](setter: Expr[RoutesEndpointsMetadata[T] => Unit])(using Quotes): Expr[Unit] = ...
```

```scala
def initializeImpl[T: Type](using q: Quotes): Expr[RoutesEndpointsMetadata[T]] = ...
```

#### `cask/router/Runtime.scala`

```scala
object Runtime
```

```scala
def tryEither[T](t: => T, error: Throwable => Result.ParamError) = ...
```

```scala
def validate(args: Seq[Either[Seq[Result.ParamError], Any]]): Result[Seq[Any]] = ...
```

```scala
def validateLists(argss: Seq[Seq[Either[Seq[Result.ParamError], Any]]]): Result[Seq[Seq[Any]]] = ...
```

```scala
def makeReadCall[I, C](dict: Map[String, I],
                         ctx: C,
                         default: => Option[Any],
                         arg: ArgSig[I, _, _, C]) = ...
```

