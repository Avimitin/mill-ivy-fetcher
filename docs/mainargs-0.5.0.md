# mainargs 0.5.0 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `170` non-private declaration signatures from `15` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::mainargs:0.5.0`
- Upstream docs: https://com-lihaoyi.github.io/mainargs/
- Source artifacts included:
  - `com.lihaoyi:mainargs_3:0.5.0`

## Common imports

```scala
import mainargs.{main, arg, ParserForMethods, TokensReader, Flag}
```

## Usage notes

Small annotation-based command-line parser used by `MillIvyFetcher` for `@main`, `@arg`, flags, and custom argument readers.

```scala
import mainargs.{main, arg, ParserForMethods, TokensReader, Flag}

object Cli:
  implicit object PathRead extends TokensReader.Simple[os.Path]:
    def shortName = "path"
    def read(strs: Seq[String]) = Right(os.Path(strs.head, os.pwd))

  @main
  def run(
      @arg(short = 'p', name = "project-dir") projectDir: os.Path,
      verbose: Flag = Flag(false)
  ): Unit = println(s"project=$projectDir verbose=${verbose.value}")

  def main(args: Array[String]): Unit =
    ParserForMethods(this).runOrExit(args)
```

## API signatures from upstream source

### `com.lihaoyi:mainargs_3:0.5.0`

Source: https://repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.5.0/mainargs_3-0.5.0-sources.jar

#### `Annotations.scala`

```scala
class arg(
    val name: String = null,
    val short: Char = 0,
    val doc: String = null,
    val noDefaultName: Boolean = false,
    val positional: Boolean = false,
    val hidden: Boolean = false
) extends ClassfileAnnotation
```

```scala
class main(val name: String = null, val doc: String = null) extends ClassfileAnnotation
```

#### `Compat.scala`

```scala
object Compat
```

```scala
def exit(n: Int) = ...
```

#### `Flag.scala`

```scala
case class Flag(value: Boolean = false)
```

#### `Invoker.scala`

```scala
object Invoker
```

```scala
def construct[T](
      cep: TokensReader.Class[T],
      args: Seq[String],
      allowPositional: Boolean,
      allowRepeats: Boolean
  ): Result[T] = ...
```

```scala
def invoke0[T, B](
      base: B,
      mainData: MainData[T, B],
      kvs: Map[ArgSig, Seq[String]],
      extras: Seq[String]
  ): Result[T] = ...
```

```scala
def invoke[T, B](target: B, main: MainData[T, B], grouping: TokenGrouping[B]): Result[T] = ...
```

```scala
def runMains[B](
      mains: MethodMains[B],
      args: Seq[String],
      allowPositional: Boolean,
      allowRepeats: Boolean
  ): Either[Result.Failure.Early, (MainData[Any, B], Result[Any])] = ...
```

```scala
def tryEither[T](t: => T, error: Throwable => Result.ParamError): Either[Result.ParamError, T] = ...
```

```scala
def makeReadCall[T](
      dict: Map[ArgSig, Seq[String]],
      base: Any,
      arg: ArgSig,
      reader: TokensReader.Simple[_]
  ): ParamResult[T] = ...
```

```scala
def makeReadVarargsCall[T](
      arg: ArgSig,
      values: Seq[String],
      reader: TokensReader.Leftover[_, _]
  ): ParamResult[T] = ...
```

#### `Leftover.scala`

```scala
case class Leftover[T](value: T*)
```

#### `Macros.scala`

```scala
object Macros
```

```scala
def parserForMethods[B](base: Expr[B])(using Quotes, Type[B]): Expr[ParserForMethods[B]] = ...
```

```scala
def parserForClass[B](using Quotes, Type[B]): Expr[ParserForClass[B]] = ...
```

```scala
def createMainData[T: Type, B: Type](using Quotes)(method: quotes.reflect.Symbol, annotation: quotes.reflect.Term): Expr[MainData[T, B]] = ...
```

#### `Parser.scala`

```scala
object ParserForMethods extends ParserForMethodsCompanionVersionSpecific
```

```scala
class ParserForMethods[B](val mains: MethodMains[B])
```

```scala
def helpText(
      totalWidth: Int = 100,
      docsOnNewLine: Boolean = false,
      customNames: Map[String, String] = Map(),
      customDocs: Map[String, String] = Map(),
      sorted: Boolean = true
  ): String = ...
```

```scala
def runOrExit(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      stderr: PrintStream = System.err,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customNames: Map[String, String] = Map(),
      customDocs: Map[String, String] = Map()
  ): Any = ...
```

```scala
def runOrThrow(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customNames: Map[String, String] = Map(),
      customDocs: Map[String, String] = Map()
  ): Any = ...
```

```scala
def runEither(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customNames: Map[String, String] = Map(),
      customDocs: Map[String, String] = Map(),
      sorted: Boolean = false
  ): Either[String, Any] = ...
```

```scala
def runRaw(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false
  ): Result[Any] = ...
```

```scala
def runRaw0(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false
  ): Either[Result.Failure.Early, (MainData[_, B], Result[Any])] = ...
```

```scala
object ParserForClass extends ParserForClassCompanionVersionSpecific
```

```scala
class ParserForClass[T](val main: MainData[T, Any], val companion: () => Any)
```

```scala
def helpText(
      totalWidth: Int = 100,
      docsOnNewLine: Boolean = false,
      customName: String = null,
      customDoc: String = null,
      sorted: Boolean = true
  ): String = ...
```

```scala
def constructOrExit(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      stderr: PrintStream = System.err,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customName: String = null,
      customDoc: String = null
  ): T = ...
```

```scala
def constructOrThrow(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customName: String = null,
      customDoc: String = null
  ): T = ...
```

```scala
def constructEither(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false,
      totalWidth: Int = 100,
      printHelpOnExit: Boolean = true,
      docsOnNewLine: Boolean = false,
      autoPrintHelpAndExit: Option[(Int, PrintStream)] = Some((0, System.out)),
      customName: String = null,
      customDoc: String = null,
      sorted: Boolean = true
  ): Either[String, T] = ...
```

```scala
def constructRaw(
      args: Seq[String],
      allowPositional: Boolean = false,
      allowRepeats: Boolean = false
  ): Result[T] = ...
```

#### `Renderer.scala`

```scala
object Renderer
```

```scala
def getLeftColWidth(items: Seq[ArgSig]) = ...
```

```scala
val newLine = ...
```

```scala
def normalizeNewlines(s: String) = ...
```

```scala
def renderArgShort(arg: ArgSig) = ...
```

```scala
object ArgOrd extends math.Ordering[ArgSig]
```

```scala
override def compare(x: ArgSig, y: ArgSig): Int = ...
```

```scala
def renderArg(
      arg: ArgSig,
      leftOffset: Int,
      wrappedWidth: Int
  ): (String, String) = ...
```

```scala
def formatMainMethods(
      mainMethods: Seq[MainData[_, _]],
      totalWidth: Int,
      docsOnNewLine: Boolean,
      customNames: Map[String, String],
      customDocs: Map[String, String],
      sorted: Boolean
  ): String = ...
```

```scala
  @deprecated("Use other overload instead", "mainargs after 0.3.0")
def formatMainMethods(
      mainMethods: Seq[MainData[_, _]],
      totalWidth: Int,
      docsOnNewLine: Boolean,
      customNames: Map[String, String],
      customDocs: Map[String, String]
  ): String = ...
```

```scala
def formatMainMethodSignature(
      main: MainData[_, _],
      leftIndent: Int,
      totalWidth: Int,
      leftColWidth: Int,
      docsOnNewLine: Boolean,
      customName: Option[String],
      customDoc: Option[String],
      sorted: Boolean
  ): String = ...
```

```scala
  @deprecated("Use other overload instead", "mainargs after 0.3.0")
def formatMainMethodSignature(
      main: MainData[_, _],
      leftIndent: Int,
      totalWidth: Int,
      leftColWidth: Int,
      docsOnNewLine: Boolean,
      customName: Option[String],
      customDoc: Option[String]
  ): String = ...
```

```scala
def softWrap(s: String, leftOffset: Int, maxWidth: Int) = ...
```

```scala
def pluralize(s: String, n: Int) = ...
```

```scala
def renderEarlyError(result: Result.Failure.Early) = ...
```

```scala
def renderResult(
      main: MainData[_, _],
      result: Result.Failure,
      totalWidth: Int,
      printHelpOnError: Boolean,
      docsOnNewLine: Boolean,
      customName: Option[String],
      customDoc: Option[String],
      sorted: Boolean
  ): String = ...
```

```scala
  @deprecated("Use other overload instead", "mainargs after 0.3.0")
def renderResult(
      main: MainData[_, _],
      result: Result.Failure,
      totalWidth: Int,
      printHelpOnError: Boolean,
      docsOnNewLine: Boolean,
      customName: Option[String],
      customDoc: Option[String]
  ): String = ...
```

#### `Result.scala`

> Represents what comes out of an attempt to invoke an [[Main]].
> Could succeed with a value, but could fail in many different ways.

```scala
sealed trait Result[+T]
```

```scala
def map[V](f: T => V): Result[V] = ...
```

```scala
def flatMap[V](f: T => Result[V]): Result[V] = ...
```

```scala
object Result
```

> Invoking the [[Main]] was totally successful, and returned a
> result

```scala
case class Success[T](value: T) extends Result[T]
```

> Invoking the [[Main]] was not successful

```scala
sealed trait Failure extends Result[Nothing]
```

```scala
object Failure
```

```scala
sealed trait Early extends Failure
```

```scala
object Early
```

```scala
case class NoMainMethodsDetected() extends Early
```

```scala
case class SubcommandNotSpecified(options: Seq[String]) extends Early
```

```scala
case class UnableToFindSubcommand(options: Seq[String], token: String) extends Early
```

```scala
case class SubcommandSelectionDashes(token: String) extends Early
```

> Invoking the [[Main]] failed with an exception while executing
> code within it.

```scala
case class Exception(t: Throwable) extends Failure
```

> Invoking the [[Main]] failed because the arguments provided
> did not line up with the arguments expected

```scala
case class MismatchedArguments(
        missing: Seq[ArgSig] = Nil,
        unknown: Seq[String] = Nil,
        duplicate: Seq[(ArgSig, Seq[String])] = Nil,
        incomplete: Option[ArgSig] = None
    ) extends Failure
```

> Invoking the [[Main]] failed because there were problems
> deserializing/parsing individual arguments

```scala
case class InvalidArguments(values: Seq[ParamError]) extends Failure
```

```scala
sealed trait ParamError
```

```scala
object ParamError
```

> Something went wrong trying to de-serialize the input parameter

```scala
case class Failed(arg: ArgSig, tokens: Seq[String], errMsg: String)
```

> Something went wrong trying to de-serialize the input parameter;
> the thrown exception is stored in [[ex]]

```scala
case class Exception(arg: ArgSig, tokens: Seq[String], ex: Throwable)
```

> Something went wrong trying to evaluate the default value
> for this input parameter

```scala
case class DefaultFailed(arg: ArgSig, ex: Throwable) extends ParamError
```

```scala
sealed trait ParamResult[+T]
```

```scala
def map[V](f: T => V): ParamResult[V] = ...
```

```scala
def flatMap[V](f: T => ParamResult[V]): ParamResult[V] = ...
```

```scala
object ParamResult
```

```scala
case class Failure(errors: Seq[Result.ParamError]) extends ParamResult[Nothing]
```

```scala
case class Success[T](value: T) extends ParamResult[T]
```

#### `TokenGrouping.scala`

```scala
case class TokenGrouping[B](remaining: List[String], grouped: Map[ArgSig, Seq[String]])
```

```scala
object TokenGrouping
```

```scala
def groupArgs[B](
      flatArgs0: Seq[String],
      argSigs: Seq[(ArgSig, TokensReader.Terminal[_])],
      allowPositional: Boolean,
      allowRepeats: Boolean,
      allowLeftover: Boolean
  ): Result[TokenGrouping[B]] = ...
```

#### `TokensReader.scala`

> Represents the ability to parse CLI input arguments into a type [[T]]
>
> Has a fixed number of direct subtypes - [[Simple]], [[Constant]], [[Flag]],
> [[Leftover]], and [[Class]] - but each of those can be extended by an
> arbitrary number of user-specified instances.

```scala
sealed trait TokensReader[T]
```

```scala
def isLeftover = ...
```

```scala
def isFlag = ...
```

```scala
def isClass = ...
```

```scala
def isConstant = ...
```

```scala
def isSimple = ...
```

```scala
object TokensReader
```

```scala
sealed trait Terminal[T] extends TokensReader[T]
```

```scala
sealed trait ShortNamed[T] extends Terminal[T]
```

> The label that shows up in the CLI help message, e.g. the `bar` in
> `--foo <bar>`

```scala
def shortName: String
```

> A [[TokensReader]] for a single CLI parameter that takes a value
> e.g. `--foo bar`

```scala
trait Simple[T] extends ShortNamed[T]
```

> Converts the given input tokens to a [[T]] or an error `String`.
> The input is a `Seq` because input tokens can be passed more than once,
> e.g. `--foo bar --foo qux` will result in [[read]] being passed
> `["foo", "qux"]`

```scala
def read(strs: Seq[String]): Either[String, T]
```

> Whether is CLI param is repeatable

```scala
def alwaysRepeatable: Boolean = ...
```

> Whether this CLI param can be no passed from the CLI, even if a default
> value is not specified. In that case, [[read]] receives an empty `Seq`

```scala
def allowEmpty: Boolean = ...
```

```scala
override def isSimple = ...
```

> A [[TokensReader]] that doesn't read any tokens and just returns a value.
> Useful sometimes for injecting things into main methods that aren't
> strictly computed from CLI argument tokens but nevertheless need to get
> passed in.

```scala
trait Constant[T] extends Terminal[T]
```

```scala
def read(): Either[String, T]
```

```scala
override def isConstant = ...
```

> A [[TokensReader]] for a flag that does not take any value, e.g. `--foo`

```scala
trait Flag extends Terminal[mainargs.Flag]
```

```scala
override def isFlag = ...
```

> A [[TokensReader]] for parsing the left-over parameters that do not belong
> to any other flag or parameter.

```scala
trait Leftover[T, V] extends ShortNamed[T]
```

```scala
def read(strs: Seq[String]): Either[String, T]
```

```scala
def shortName: String
```

```scala
override def isLeftover = ...
```

> A [[TokensReader]] that can parse an instance of the class [[T]], which
> may contain multiple fields each parsed by their own [[TokensReader]]

```scala
trait Class[T] extends TokensReader[T]
```

```scala
def companion: () = ...
```

```scala
def main: MainData[T, Any]
```

```scala
override def isClass = ...
```

```scala
def tryEither[T](f: => T) = ...
```

```scala
implicit object FlagRead extends Flag
```

```scala
implicit object StringRead extends Simple[String]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object BooleanRead extends Simple[Boolean]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object ByteRead extends Simple[Byte]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object ShortRead extends Simple[Short]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object IntRead extends Simple[Int]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object LongRead extends Simple[Long]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object FloatRead extends Simple[Float]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit object DoubleRead extends Simple[Double]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
implicit def LeftoverRead[T: TokensReader.Simple]: TokensReader.Leftover[mainargs.Leftover[T], T] = ...
```

```scala
class LeftoverRead[T](implicit wrapped: TokensReader.Simple[T])
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
def shortName = ...
```

```scala
implicit def OptionRead[T: TokensReader.Simple]: TokensReader[Option[T]] = ...
```

```scala
class OptionRead[T: TokensReader.Simple] extends Simple[Option[T]]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
override def allowEmpty = ...
```

```scala
implicit def SeqRead[C[_] <: Iterable[_], T: TokensReader.Simple](implicit
      factory: Factory[T, C[T]]
  ): TokensReader[C[T]] = ...
```

```scala
class SeqRead[C[_] <: Iterable[_], T: TokensReader.Simple](implicit factory: Factory[T, C[T]])
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
override def alwaysRepeatable = ...
```

```scala
override def allowEmpty = ...
```

```scala
implicit def MapRead[K: TokensReader.Simple, V: TokensReader.Simple]: TokensReader[Map[K, V]] = ...
```

```scala
class MapRead[K: TokensReader.Simple, V: TokensReader.Simple] extends Simple[Map[K, V]]
```

```scala
def shortName = ...
```

```scala
def read(strs: Seq[String]) = ...
```

```scala
override def alwaysRepeatable = ...
```

```scala
override def allowEmpty = ...
```

```scala
object ArgSig
```

```scala
def create[T, B](name0: String, arg: mainargs.arg, defaultOpt: Option[B => T])
```

```scala
def flatten[T](x: ArgSig): Seq[(ArgSig, TokensReader.Terminal[_])] = ...
```

> Models what is known by the router about a single argument: that it has
> a [[name]], a human-readable [[typeString]] describing what the type is
> (just for logging and reading, not a replacement for a `TypeTag`) and
> possible a function that can compute its default value

```scala
case class ArgSig(
    name: Option[String],
    shortName: Option[Char],
    doc: Option[String],
    default: Option[Any => Any],
    reader: TokensReader[_],
    positional: Boolean,
    hidden: Boolean
)
```

```scala
case class MethodMains[B](value: Seq[MainData[Any, B]], base: () => B)
```

> What is known about a single endpoint for our routes. It has a [[name]],
> [[flattenedArgSigs]] for each argument, and a macro-generated [[invoke0]]
> that performs all the necessary argument parsing and de-serialization.
>
> Realistically, you will probably spend most of your time calling [[Invoker.invoke]]
> instead, which provides a nicer API to call it that mimmicks the API of
> calling a Scala method.

```scala
case class MainData[T, B](
    name: String,
    argSigs0: Seq[ArgSig],
    doc: Option[String],
    invokeRaw: (B, Seq[Any]) => T
)
```

```scala
val flattenedArgSigs: Seq[(ArgSig, TokensReader.Terminal[_])] = ...
```

```scala
val renderedArgSigs: Seq[ArgSig] = ...
```

```scala
object MainData
```

```scala
def create[T, B](
      methodName: String,
      main: mainargs.main,
      argSigs: Seq[ArgSig],
      invokeRaw: (B, Seq[Any]) => T
  ) = ...
```

#### `Util.scala`

```scala
object Util
```

```scala
def literalize(s: IndexedSeq[Char], unicode: Boolean = false) = ...
```

```scala
def stripDashes(s: String) = ...
```

```scala
def appendMap[K, V](current: Map[K, Vector[V]], k: K, v: V): Map[K, Vector[V]] = ...
```

#### `acyclic.scala`

```scala
def skipped = ...
```

