# uPickle 3.3.1 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `1220` non-private declaration signatures from `70` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::upickle:3.3.1`
- Upstream docs: https://com-lihaoyi.github.io/upickle/
- Source artifacts included:
  - `com.lihaoyi:upickle_3:3.3.1`
  - `com.lihaoyi:upickle-core_3:3.3.1`
  - `com.lihaoyi:upickle-implicits_3:3.3.1`
  - `com.lihaoyi:ujson_3:3.3.1`
  - `com.lihaoyi:upack_3:3.3.1`

## Common imports

```scala
import upickle.default.{ReadWriter, macroRW, read, write, readwriter}
```

## Usage notes

JSON / MessagePack read-write library. This doc includes the direct `upickle` façade plus common transitive API modules that define `Reader`, `Writer`, `ReadWriter`, macros, `ujson`, and `upack` values.

```scala
import upickle.default.{ReadWriter, macroRW, read, write}

case class LockedFile(mavenPath: String, sha256: String, size: Long)
object LockedFile:
  given ReadWriter[LockedFile] = macroRW

val json = write(LockedFile("com/example/app/1.0.0/app.pom", "sha256-...", 123), indent = 2)
val file = read[LockedFile](json)
```

## API signatures from upstream source

### `com.lihaoyi:upickle_3:3.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1/upickle_3-3.3.1-sources.jar

#### `upickle/Api.scala`

> An instance of the upickle API. There's a default instance at
> `upickle.default`, but you can also implement it yourself to customize
> its behavior. Override the `annotate` methods to control how a sealed
> trait instance is tagged during reading and writing.

```scala
trait Api
    extends upickle.core.Types
    with implicits.Readers
    with implicits.Writers
    with implicits.CaseClassReadWriters
    with WebJson
    with JsReadWriters
    with MsgReadWriters
    with Annotator
```

> Reads the given MessagePack input into a Scala value

```scala
def readBinary[T: Reader](s: upack.Readable, trace: Boolean = false): T = ...
```

> Reads the given JSON input into a Scala value

```scala
def read[T: Reader](s: ujson.Readable, trace: Boolean = false): T = ...
```

```scala
def reader[T: Reader] = ...
```

> Write the given Scala value as a JSON string

```scala
def write[T: Writer](t: T,
                       indent: Int = -1,
                       escapeUnicode: Boolean = false,
                       sortKeys: Boolean = false): String = ...
```

```scala
def write[T: Writer](t: T,
                       indent: Int,
                       escapeUnicode: Boolean): String = ...
```

> Write the given Scala value as a MessagePack binary

```scala
def writeBinary[T: Writer](t: T,
                             sortKeys: Boolean = false): Array[Byte] = ...
```

```scala
def writeBinary[T: Writer](t: T): Array[Byte] = ...
```

> Write the given Scala value as a JSON struct

```scala
def writeJs[T: Writer](t: T): ujson.Value = ...
```

> Write the given Scala value as a MessagePack struct

```scala
def writeMsg[T: Writer](t: T): upack.Msg = ...
```

> Write the given Scala value as a JSON string to the given Writer

```scala
def writeTo[T: Writer](t: T,
                         out: java.io.Writer,
                         indent: Int = -1,
                         escapeUnicode: Boolean = false,
                         sortKeys: Boolean = false): Unit = ...
```

```scala
def writeTo[T: Writer](t: T,
                         out: java.io.Writer,
                         indent: Int,
                         escapeUnicode: Boolean): Unit = ...
```

```scala
def writeToOutputStream[T: Writer](t: T,
                                     out: java.io.OutputStream,
                                     indent: Int = -1,
                                     escapeUnicode: Boolean = false,
                                     sortKeys: Boolean = false): Unit = ...
```

```scala
def writeToOutputStream[T: Writer](t: T,
                                     out: java.io.OutputStream,
                                     indent: Int,
                                     escapeUnicode: Boolean): Unit = ...
```

```scala
def writeToByteArray[T: Writer](t: T,
                                  indent: Int = -1,
                                  escapeUnicode: Boolean = false,
                                  sortKeys: Boolean = false): Array[Byte] = ...
```

```scala
def writeToByteArray[T: Writer](t: T,
                                  indent: Int,
                                  escapeUnicode: Boolean): Array[Byte] = ...
```

> Write the given Scala value as a JSON string via a `geny.Writable`

```scala
def stream[T: Writer](t: T,
                        indent: Int = -1,
                        escapeUnicode: Boolean = false,
                        sortKeys: Boolean = false): geny.Writable = ...
```

```scala
def stream[T: Writer](t: T,
                        indent: Int,
                        escapeUnicode: Boolean): geny.Writable = ...
```

> Write the given Scala value as a MessagePack binary to the given OutputStream

```scala
def writeBinaryTo[T: Writer](t: T,
                               out: java.io.OutputStream,
                               sortKeys: Boolean = false): Unit = ...
```

```scala
def writeBinaryTo[T: Writer](t: T,
                               out: java.io.OutputStream): Unit = ...
```

```scala
def writeBinaryToByteArray[T: Writer](t: T,
                                        sortKeys: Boolean = false): Array[Byte] = ...
```

```scala
def writeBinaryToByteArray[T: Writer](t: T): Array[Byte] = ...
```

> Write the given Scala value as a MessagePack binary via a `geny.Writable`

```scala
def streamBinary[T: Writer](t: T, sortKeys: Boolean = false): geny.Writable = ...
```

```scala
def streamBinary[T: Writer](t: T): geny.Writable = ...
```

```scala
def writer[T: Writer] = ...
```

```scala
def readwriter[T: ReadWriter] = ...
```

```scala
case class transform[T: Writer](t: T) extends upack.Readable with ujson.Readable
```

```scala
def transform[V](f: Visitor[_, V]): V = ...
```

```scala
def to[V](f: Visitor[_, V]): V = ...
```

```scala
def to[V](implicit f: Reader[V]): V = ...
```

> Mark a `ReadWriter[T]` as something that can be used as a key in a JSON
> dictionary, such that `Map[T, V]` serializes to `{"a": "b", "c": "d"}`
> rather than `[["a", "b"], ["c", "d"]]`

```scala
def stringKeyRW[T](readwriter: ReadWriter[T]): ReadWriter[T] = ...
```

> Mark a `Writer[T]` as something that can be used as a key in a JSON
> dictionary, such that `Map[T, V]` serializes to `{"a": "b", "c": "d"}`
> rather than `[["a", "b"], ["c", "d"]]`

```scala
def stringKeyW[T](readwriter: Writer[T]): Writer[T] = ...
```

> Configure whether you want upickle to skip unknown keys during de-serialization
> of `case class`es. Can be overriden for the entire serializer via `override def`, and
> further overriden for individual `case class`es via the annotation
> `@upickle.implicits.allowUnknownKeys(b: Boolean)`

```scala
override def allowUnknownKeys: Boolean = ...
```

> The default way of accessing upickle

```scala
object default extends AttributeTagged
```

> An instance of the upickle API that follows the old serialization for
> tagged instances of sealed traits: as a list with two items, the first
> being the type-tag and the second being the serialized object

```scala
object legacy extends LegacyApi
```

```scala
trait LegacyApi extends Api with Annotator
```

```scala
override def annotate[V](rw: Reader[V], key: String, value: String) = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
override final def annotate[V](rw: Reader[V], n: String) = ...
```

```scala
override def annotate[V](rw: ObjectWriter[V], key: String, value: String, checker: Annotator.Checker): TaggedWriter[V] = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
override final def annotate[V](rw: ObjectWriter[V], n: String, checker: Annotator.Checker): TaggedWriter[V] = ...
```

```scala
def taggedExpectedMsg = ...
```

```scala
sealed trait TaggedReaderState
```

```scala
object TaggedReaderState
```

```scala
case object Initializing extends TaggedReaderState
```

```scala
case class Parsing(f: Reader[_]) extends TaggedReaderState
```

```scala
case class Parsed(res: Any) extends TaggedReaderState
```

```scala
override def taggedArrayContext[T](taggedReader: TaggedReader[T], index: Int) = ...
```

```scala
override def taggedWrite[T, R](w: ObjectWriter[T], tagKey: String, tagValue: String, out: Visitor[_,  R], v: T): R = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
final def taggedWrite[T, R](w: ObjectWriter[T], tag: String, out: Visitor[_,  R], v: T): R = ...
```

> A `upickle.Api` that follows the default sealed-trait-instance-tagging
> behavior of using an attribute, but allow you to control what the name
> of the attribute is.

```scala
trait AttributeTagged extends Api with Annotator
```

```scala
  @deprecated("Not used, left for binary compatibility")
def tagName = ...
```

```scala
override def annotate[V](rw: Reader[V], key: String, value: String) = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
override final def annotate[V](rw: Reader[V], n: String) = ...
```

```scala
override def annotate[V](rw: ObjectWriter[V], key: String, value: String, checker: Annotator.Checker): TaggedWriter[V] = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
override final def annotate[V](rw: ObjectWriter[V], n: String, checker: Annotator.Checker): TaggedWriter[V] = ...
```

```scala
def taggedExpectedMsg = ...
```

```scala
override def taggedObjectContext[T](taggedReader: TaggedReader[T], index: Int) = ...
```

```scala
override def taggedWrite[T, R](w: ObjectWriter[T], tagKey: String, tagValue: String, out: Visitor[_,  R], v: T): R = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
final def taggedWrite[T, R](w: ObjectWriter[T], tag: String, out: Visitor[_,  R], v: T): R = ...
```

#### `upickle/JsReadWriters.scala`

```scala
trait JsReadWriters extends upickle.core.Types with MacroImplicits with LowPriReadWriters
```

```scala
implicit def JsObjR: Reader[ujson.Obj] = ...
```

```scala
implicit def JsArrR: Reader[ujson.Arr] = ...
```

```scala
implicit def JsStrR: Reader[ujson.Str] = ...
```

```scala
implicit def JsNumR: Reader[ujson.Num] = ...
```

```scala
implicit def JsBoolR: Reader[ujson.Bool] = ...
```

```scala
implicit def JsTrueR: Reader[ujson.True.type] = ...
```

```scala
implicit def JsFalseR: Reader[ujson.False.type] = ...
```

```scala
implicit def JsNullR: Reader[ujson.Null.type] = ...
```

```scala
implicit def JsObjW: Writer[ujson.Obj] = ...
```

```scala
implicit def JsArrW: Writer[ujson.Arr] = ...
```

```scala
implicit def JsStrW: Writer[ujson.Str] = ...
```

```scala
implicit def JsNumW: Writer[ujson.Num] = ...
```

```scala
implicit def JsBoolW: Writer[ujson.Bool] = ...
```

```scala
implicit def JsTrueW: Writer[ujson.True.type] = ...
```

```scala
implicit def JsFalseW: Writer[ujson.False.type] = ...
```

```scala
implicit def JsNullW: Writer[ujson.Null.type] = ...
```

```scala
trait LowPriReadWriters
```

```scala
implicit def JsValueR: Reader[ujson.Value] = ...
```

```scala
implicit def JsValueW: Writer[ujson.Value] = ...
```

#### `upickle/MsgReadWriters.scala`

```scala
trait MsgReadWriters extends upickle.core.Types with MacroImplicits
```

```scala
implicit val MsgValueR: Reader[upack.Msg] = ...
```

```scala
implicit val MsgValueW: Writer[upack.Msg] = ...
```

#### `upickle/WebJson.scala`

```scala
trait WebJson extends upickle.core.Types
```

### `com.lihaoyi:upickle-core_3:3.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1/upickle-core_3-3.3.1-sources.jar

#### `BufferingByteParser.scala`

> Models a growable [[buffer]] of Bytes, which are Chars or Bytes. We maintain
> an Array[Byte] as a buffer, and read Bytes into it using [[readDataIntoBuffer]]
> and drop old Bytes using [[dropBufferUntil]].
>
> In general, [[BufferingByteParser]] allows us to keep the fast path fast:
>
> - Reading byte-by-byte from the buffer is a bounds check and direct Array
> access, without any indirection or polymorphism.
> - We load Bytes in batches into the buffer, which allows us to take advantage
> of batching APIs like `InputStream.read`
> - We amortize the overhead of the indirect/polymorphic [[readDataIntoBuffer]]
> call over the size of each batch
>
> Note that [[dropBufferUntil]] only advances a [[dropped]] index and does not
> actually zero out the dropped Bytes; instead, we wait until we need to call
> [[growBuffer]], and use that as a chance to copy the remaining un-dropped Bytes
> to either the start of the current [[buffer]] or the start of a newly-allocated
> bigger [[buffer]] (if necessary)

```scala
trait BufferingByteParser
```

```scala
def getBuffer = ...
```

```scala
def getFirstIdx = ...
```

```scala
def getBufferGrowCount() = ...
```

```scala
def getBufferCopyCount() = ...
```

```scala
def getBufferLength() = ...
```

```scala
def getLastIdx = ...
```

```scala
def getByteSafe(i: Int): Byte = ...
```

```scala
def getByteUnsafe(i: Int): Byte = ...
```

```scala
def sliceString(i: Int, k: Int): String = ...
```

```scala
def sliceArr(i: Int, n: Int): (Array[Byte], Int, Int) = ...
```

> Copies the non-dropped Bytes in the current [[buffer]] to the start of either
> the current [[buffer]], or a newly-allocated larger [[buffer]] if necessary.

```scala
def growBuffer(until: Int) = ...
```

```scala
def readDataIntoBuffer(buffer: Array[Byte], bufferOffset: Int): (Array[Byte], Boolean, Int)
```

```scala
def dropBufferUntil(i: Int): Unit = ...
```

```scala
def unsafeCharSeqForRange(start: Int, length: Int) = ...
```

```scala
def appendBytesToBuilder(bytes: ByteBuilder, bytesStart: Int, bytesLength: Int) = ...
```

#### `BufferingCharParser.scala`

> Models a growable [[buffer]] of Chars, which are Chars or Bytes. We maintain
> an Array[Char] as a buffer, and read Chars into it using [[readDataIntoBuffer]]
> and drop old Chars using [[dropBufferUntil]].
>
> In general, [[BufferingCharParser]] allows us to keep the fast path fast:
>
> - Reading char-by-char from the buffer is a bounds check and direct Array
> access, without any indirection or polymorphism.
> - We load Chars in batches into the buffer, which allows us to take advantage
> of batching APIs like `InputStream.read`
> - We amortize the overhead of the indirect/polymorphic [[readDataIntoBuffer]]
> call over the size of each batch
>
> Note that [[dropBufferUntil]] only advances a [[dropped]] index and does not
> actually zero out the dropped Chars; instead, we wait until we need to call
> [[growBuffer]], and use that as a chance to copy the remaining un-dropped Chars
> to either the start of the current [[buffer]] or the start of a newly-allocated
> bigger [[buffer]] (if necessary)

```scala
trait BufferingCharParser
```

```scala
def getBuffer = ...
```

```scala
def getFirstIdx = ...
```

```scala
def getBufferGrowCount() = ...
```

```scala
def getBufferCopyCount() = ...
```

```scala
def getBufferLength() = ...
```

```scala
def getLastIdx = ...
```

```scala
def getCharSafe(i: Int): Char = ...
```

```scala
def getCharUnsafe(i: Int): Char = ...
```

```scala
def sliceString(i: Int, k: Int): String = ...
```

```scala
def sliceArr(i: Int, n: Int): (Array[Char], Int, Int) = ...
```

> Copies the non-dropped Chars in the current [[buffer]] to the start of either
> the current [[buffer]], or a newly-allocated larger [[buffer]] if necessary.

```scala
def growBuffer(until: Int) = ...
```

```scala
def readDataIntoBuffer(buffer: Array[Char], bufferOffset: Int): (Array[Char], Boolean, Int)
```

```scala
def dropBufferUntil(i: Int): Unit = ...
```

```scala
def unsafeCharSeqForRange(start: Int, length: Int) = ...
```

```scala
def appendCharsToBuilder(chars: CharBuilder, charsStart: Int, charsLength: Int) = ...
```

#### `ByteBuilder.scala`

> A fast buffer that can be used to store Bytes (Bytes or Chars).
>
> Generally faster than the equivalent [[StringBuilder]] or
> [[java.io.ByteArrayOutputStream]], since:
>
> - It is specialized and without the overhead of polymorphism or synchronization.
> - It allows the user to call `ensureLength` and `appendUnsafe` separately, e.g.
> callign `ensureLength` once before `appendUnsafe`-ing multiple Bytes
> - It provides fast methods like [[makeString]] or [[writeOutToIfLongerThan]], that
> let you push the data elsewhere with minimal unnecessary copying

```scala
class ByteBuilder(startSize: Int = 32) extends upickle.core.ByteAppendC
```

```scala
var arr: Array[Byte] = ...
```

```scala
var length: Int = ...
```

```scala
def getLength = ...
```

```scala
def reset(): Unit = ...
```

```scala
def ensureLength(increment: Int): Unit = ...
```

```scala
def append(x: Int): Unit = ...
```

```scala
def append(x: Byte): Unit = ...
```

```scala
def appendAll(bytes: Array[Byte], bytesLength: Int): Unit = ...
```

```scala
def appendAll(bytes: Array[Byte], bytesStart: Int, bytesLength: Int): Unit = ...
```

```scala
def appendAllUnsafe(other: ByteBuilder): Unit = ...
```

```scala
def appendUnsafeC(x: Char): Unit = ...
```

```scala
def appendUnsafe(x: Byte): Unit = ...
```

```scala
def makeString(): String = ...
```

```scala
def writeOutToIfLongerThan(writer: upickle.core.ByteOps.Output, threshold: Int): Unit = ...
```

#### `ByteUtils.scala`

```scala
object ByteUtils
```

```scala
def appendEscapedByte(byteBuilder: ByteBuilder, c: Char, i: Int): Boolean = ...
```

```scala
def escapeSingleByte(byteBuilder: ByteBuilder, i: Int, c: Char) = ...
```

```scala
def escapeSingleByteUnicodeEscape(byteBuilder: ByteBuilder, i: Int, c: Char) = ...
```

```scala
def appendSimpleStringSection(byteBuilder: ByteBuilder,
                               i0: Int,
                               len: Int,
                               s: CharSequence) = ...
```

```scala
def appendSimpleStringSectionNoUnicode(byteBuilder: ByteBuilder,
                                        i0: Int,
                                        len: Int,
                                        s: CharSequence) = ...
```

```scala
def parseIntegralNum(arr: Array[Byte], arrOffset: Int, arrLength: Int, decIndex: Int, expIndex: Int) = ...
```

```scala
def parseLong(cs0: Array[Byte], start0: Int, end0: Int): Long = ...
```

#### `CharBuilder.scala`

> A fast buffer that can be used to store Chars (Bytes or Chars).
>
> Generally faster than the equivalent [[StringBuilder]] or
> [[java.io.ByteArrayOutputStream]], since:
>
> - It is specialized and without the overhead of polymorphism or synchronization.
> - It allows the user to call `ensureLength` and `appendUnsafe` separately, e.g.
> callign `ensureLength` once before `appendUnsafe`-ing multiple Chars
> - It provides fast methods like [[makeString]] or [[writeOutToIfLongerThan]], that
> let you push the data elsewhere with minimal unnecessary copying

```scala
class CharBuilder(startSize: Int = 32) extends upickle.core.CharAppendC
```

```scala
var arr: Array[Char] = ...
```

```scala
var length: Int = ...
```

```scala
def getLength = ...
```

```scala
def reset(): Unit = ...
```

```scala
def ensureLength(increment: Int): Unit = ...
```

```scala
def append(x: Int): Unit = ...
```

```scala
def append(x: Char): Unit = ...
```

```scala
def appendAll(chars: Array[Char], charsLength: Int): Unit = ...
```

```scala
def appendAll(chars: Array[Char], charsStart: Int, charsLength: Int): Unit = ...
```

```scala
def appendAllUnsafe(other: CharBuilder): Unit = ...
```

```scala
def appendUnsafeC(x: Char): Unit = ...
```

```scala
def appendUnsafe(x: Char): Unit = ...
```

```scala
def makeString(): String = ...
```

```scala
def writeOutToIfLongerThan(writer: upickle.core.CharOps.Output, threshold: Int): Unit = ...
```

#### `CharUtils.scala`

```scala
object CharUtils
```

```scala
def appendEscapedChar(charBuilder: CharBuilder, c: Char, i: Int): Boolean = ...
```

```scala
def escapeSingleChar(charBuilder: CharBuilder, i: Int, c: Char) = ...
```

```scala
def escapeSingleCharUnicodeEscape(charBuilder: CharBuilder, i: Int, c: Char) = ...
```

```scala
def appendSimpleStringSection(charBuilder: CharBuilder,
                               i0: Int,
                               len: Int,
                               s: CharSequence) = ...
```

```scala
def appendSimpleStringSectionNoUnicode(charBuilder: CharBuilder,
                                        i0: Int,
                                        len: Int,
                                        s: CharSequence) = ...
```

```scala
def parseIntegralNum(arr: Array[Char], arrOffset: Int, arrLength: Int, decIndex: Int, expIndex: Int) = ...
```

```scala
def parseLong(cs0: Array[Char], start0: Int, end0: Int): Long = ...
```

#### `WrapByteArrayCharSeq.scala`

> A [[CharSequence]] that wraps an array of byteents without any copying.
>
> Note that the [[arr]] is mutable, and so the [[WrapByteArrayCharSeq]]
> should not itself be stored: either use it immediately when given it
> or call `.toString` if you want to store the data for later use.

```scala
class WrapByteArrayCharSeq(arr: Array[Byte], start: Int, length0: Int) extends CharSequence
```

#### `WrapCharArrayCharSeq.scala`

> A [[CharSequence]] that wraps an array of charents without any copying.
>
> Note that the [[arr]] is mutable, and so the [[WrapCharArrayCharSeq]]
> should not itself be stored: either use it immediately when given it
> or call `.toString` if you want to store the data for later use.

```scala
class WrapCharArrayCharSeq(arr: Array[Char], start: Int, length0: Int) extends CharSequence
```

#### `upickle/core/BufferedValue.scala`

> A reified version of [[Visitor]], allowing visitor method calls to be buffered up,
> stored somewhere, and replayed later.

```scala
sealed trait BufferedValue
```

```scala
def index: Int
```

```scala
object BufferedValue extends Transformer[BufferedValue]
```

```scala
def valueToSortKey(b: BufferedValue): String = ...
```

```scala
def maybeSortKeysTransform[T, V](tr: Transformer[T],
                                   t: T,
                                   sortKeys: Boolean,
                                   f: Visitor[_, V]): V = ...
```

```scala
case class Str(value0: java.lang.CharSequence, index: Int) extends BufferedValue
```

```scala
case class Obj(value0: mutable.ArrayBuffer[(BufferedValue, BufferedValue)], jsonableKeys: Boolean, index: Int) extends BufferedValue
```

```scala
case class Arr(value: mutable.ArrayBuffer[BufferedValue], index: Int) extends BufferedValue
```

```scala
case class Num(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) extends BufferedValue
```

```scala
case class NumRaw(d: Double, index: Int) extends BufferedValue
```

```scala
case class False(index: Int) extends BufferedValue
```

```scala
def value = ...
```

```scala
case class True(index: Int) extends BufferedValue
```

```scala
def value = ...
```

```scala
case class Null(index: Int) extends BufferedValue
```

```scala
def value = ...
```

```scala
case class Binary(bytes: Array[Byte], offset: Int, len: Int, index: Int) extends BufferedValue
```

```scala
case class Char(s: scala.Char, index: Int) extends BufferedValue
```

```scala
case class Ext(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) extends BufferedValue
```

```scala
case class Float32(d: Float, index: Int) extends BufferedValue
```

```scala
case class Float64String(s: String, index: Int) extends BufferedValue
```

```scala
case class Int32(i: Int, index: Int) extends BufferedValue
```

```scala
case class Int64(i: Long, index: Int) extends BufferedValue
```

```scala
case class UInt64(i: Long, index: Int) extends BufferedValue
```

```scala
def transform[T](j: BufferedValue, f: Visitor[_, T]): T = ...
```

```scala
object Builder extends Visitor[BufferedValue, BufferedValue]
```

```scala
def visitArray(length: Int, i: Int) = ...
```

```scala
def visitObject(length: Int, jsonableKeys: Boolean, i: Int) = ...
```

```scala
def visitNull(i: Int) = ...
```

```scala
def visitFalse(i: Int) = ...
```

```scala
def visitTrue(i: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, i: Int) = ...
```

```scala
override def visitFloat64(d: Double, i: Int) = ...
```

```scala
def visitString(s: CharSequence, i: Int) = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitChar(s: scala.Char, index: Int) = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitFloat32(d: Float, index: Int) = ...
```

```scala
def visitFloat64String(s: String, index: Int) = ...
```

```scala
def visitInt32(i: Int, index: Int) = ...
```

```scala
def visitInt64(i: Long, index: Int) = ...
```

```scala
def visitUInt64(i: Long, index: Int) = ...
```

#### `upickle/core/BufferingInputStreamParser.scala`

> Defines common functionality to any parser that works on a `java.io.InputStream`
>
> Allows you to look up individual bytes by index, take slices of byte ranges or
> strings, and drop old portions of buffered data once you are certain you no
> longer need them.
>
> The `buffer` size is managed by allowing it to grow in size until it exceeds its
> capacity. When that happens, one of two things happen:
>
> - If the buffer has enough space, we left-shift the data in the
> buffer to over-write the portion that has already been dropped.
>
> - If the buffer does not have enough space, we allocate a new buffer big
> enough to hold the new data we need to store (size a power of two multiple of
> the old size) and copy the data over, again shifted left
> .

```scala
trait BufferingInputStreamParser extends BufferingByteParser
```

```scala
def inputStream: java.io.InputStream
```

```scala
def minBufferStartSize: Int
```

```scala
def maxBufferStartSize: Int
```

```scala
def readDataIntoBuffer(buffer: Array[Byte], bufferOffset: Int) = ...
```

```scala
object BufferingInputStreamParser
```

```scala
val defaultMaxBufferStartSize: Int = ...
```

```scala
val defaultMinBufferStartSize: Int = ...
```

#### `upickle/core/ElemAppendC.scala`

```scala
abstract class CharAppendC
```

```scala
def append(x: Char): Unit
```

```scala
def appendC(x: Char): Unit = ...
```

```scala
abstract class ByteAppendC
```

```scala
def append(x: Byte): Unit
```

```scala
def appendC(x: Char): Unit = ...
```

```scala
def convertSurrogate(firstPart: Int, secondPart: Int) = ...
```

#### `upickle/core/ElemOps.scala`

```scala
object CharOps
```

```scala
def toInt(c: Char) = ...
```

```scala
def toUnsignedInt(c: Char) = ...
```

```scala
def lessThan(c1: Char, c2: Char) = ...
```

```scala
def within(c1: Char, c2: Char, c3: Char) = ...
```

```scala
type Output = ...
```

```scala
def newString(arr: Array[Char], i: Int, length: Int) = ...
```

```scala
object ByteOps
```

```scala
def toInt(c: Byte) = ...
```

```scala
def toUnsignedInt(c: Byte) = ...
```

```scala
def lessThan(c1: Byte, c2: Char) = ...
```

```scala
def within(c1: Char, c2: Byte, c3: Char) = ...
```

```scala
type Output = ...
```

```scala
def newString(arr: Array[Byte], i: Int, length: Int) = ...
```

#### `upickle/core/LinkedHashMap.scala`

```scala
object LinkedHashMap
```

```scala
def apply[K, V](): LinkedHashMap[K, V] = ...
```

```scala
def apply[K, V](items: IterableOnce[(K, V)]): LinkedHashMap[K, V] = ...
```

```scala
implicit def factory[K, V]: Factory[(K, V), LinkedHashMap[K, V]] = ...
```

#### `upickle/core/LogVisitor.scala`

> A visitor that wraps another but prints out what methods get called,
> useful for debugging

```scala
class LogVisitor[-T, +V](downstream: Visitor[T, V], log: String => Unit = println, indent: String = "    ") extends Visitor[T, V]
```

```scala
def visitNull(index: Int): V = ...
```

```scala
def visitTrue(index: Int): V = ...
```

```scala
def visitFalse(index: Int): V = ...
```

```scala
def visitString(s: CharSequence, index: Int): V = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int): V = ...
```

```scala
def visitObject(length: Int, jsonableKeys: Boolean, index: Int): ObjVisitor[T, V] = ...
```

```scala
def visitArray(length: Int, index: Int): ArrVisitor[T, V] = ...
```

```scala
def visitFloat64(d: Double, index: Int): V = ...
```

```scala
def visitFloat32(d: Float, index: Int): V = ...
```

```scala
def visitInt32(i: Int, index: Int): V = ...
```

```scala
def visitInt64(i: Long, index: Int): V = ...
```

```scala
def visitUInt64(i: Long, index: Int): V = ...
```

```scala
def visitFloat64String(s: String, index: Int): V = ...
```

```scala
def visitChar(s: Char, index: Int): V = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int): V = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int): V = ...
```

#### `upickle/core/NoOpVisitor.scala`

> NullFacade discards all JSON AST information.
>
> This is the simplest possible facade. It could be useful for
> checking JSON for correctness (via parsing) without worrying about
> saving the data.
>
> It will always return () on any successful parse, no matter the
> content.

```scala
object NoOpVisitor extends Visitor[Unit, Unit]
```

```scala
def visitArray(length: Int, index: Int) = ...
```

```scala
def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
def visitNull(index: Int): Unit = ...
```

```scala
def visitFalse(index: Int): Unit = ...
```

```scala
def visitTrue(index: Int): Unit = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int): Unit = ...
```

```scala
def visitString(s: CharSequence, index: Int): Unit = ...
```

```scala
def visitFloat64(d: Double, index: Int) = ...
```

```scala
def visitFloat32(d: Float, index: Int) = ...
```

```scala
def visitInt8(i: Byte, index: Int) = ...
```

```scala
def visitUInt8(i: Byte, index: Int) = ...
```

```scala
def visitInt16(i: Short, index: Int) = ...
```

```scala
def visitUInt16(i: Short, index: Int) = ...
```

```scala
def visitInt32(i: Int, index: Int) = ...
```

```scala
def visitUInt32(i: Int, index: Int) = ...
```

```scala
def visitInt64(i: Long, index: Int) = ...
```

```scala
def visitUInt64(i: Long, index: Int) = ...
```

```scala
def visitFloat64String(s: String, index: Int) = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int) = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitChar(s: Char, index: Int) = ...
```

#### `upickle/core/ParseUtils.scala`

```scala
object ParseUtils
```

```scala
val hexes = ...
```

```scala
def bytesToString(bs: Array[Byte]) = ...
```

```scala
def stringToBytes(s: String) = ...
```

```scala
def parseIntegralNum(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
def parseLong(cs: CharSequence, start: Int, end: Int): Long = ...
```

```scala
def reject(j: Int): PartialFunction[Throwable, Nothing] = ...
```

#### `upickle/core/RenderUtils.scala`

```scala
object RenderUtils
```

```scala
final val hexChars: Array[Int] = ...
```

```scala
def hex(i: Int): Int = ...
```

```scala
def toHex(nibble: Int): Char = ...
```

> Attempts to write the given [[CharSequence]] into the given [[ByteBuilder]].
>
> Optimistically treats the characters as ASCII characters, which can be
> directly converted to bytes and written. Only if we encounter a unicode
> character do we fall back to the slow path of constructing a
> [[java.lang.String]] which we UTF-8 encode before adding the to output.

```scala
final def escapeByte(unicodeCharBuilder: upickle.core.CharBuilder,
                       sb: upickle.core.ByteBuilder,
                       s: CharSequence,
                       escapeUnicode: Boolean,
                       wrapQuotes: Boolean): Unit = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def escapeSingleByteUnicodeRaw(unicodeCharBuilder: CharBuilder,
                                 sb: ByteBuilder,
                                 s: CharSequence,
                                 escapeUnicode: Boolean,
                                 i0: Int,
                                 len0: Int,
                                 naiveOutLen: Int,
                                 wrapQuotes: Boolean): Unit = ...
```

```scala
def escapeSingleByteUnicodeRaw(unicodeCharBuilder: CharBuilder,
                                 sb: ByteBuilder,
                                 s: CharSequence,
                                 escapeUnicode: Boolean,
                                 i0: Int,
                                 len0: Int,
                                 wrapQuotes: Boolean): Unit = ...
```

```scala
def escapeChar(unicodeCharBuilder: upickle.core.CharBuilder,
                 sb: upickle.core.CharBuilder,
                 s: CharSequence,
                 escapeUnicode: Boolean,
                 wrapQuotes: Boolean) = ...
```

```scala
final def escapeChar0(i0: Int,
                        len: Int,
                        sb: upickle.core.CharBuilder,
                        s: CharSequence,
                        escapeUnicode: Boolean,
                        wrapQuotes: Boolean): upickle.core.CharBuilder = ...
```

```scala
def intStringSize(x0: Int): Int = ...
```

```scala
def longStringSize(x0: Long): Int = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def escapeSingleChar(sb: upickle.core.CharBuilder,
                       naiveOutLen: Int,
                       i: Int,
                       c: Char) = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def escapeSingleByte(sb: upickle.core.ByteBuilder,
                       naiveOutLen: Int,
                       i: Int,
                       c: Char) = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def escapeSingleCharUnicodeEscape(naiveOutLen: Int, sb: CharBuilder, i: Int, c: Char) = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def escapeSingleByteUnicodeEscape(sb: ByteBuilder, i: Int, naiveOutLen: Int, c: Char) = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
final def escapeChar0(i0: Int,
                        naiveOutLen: Int,
                        len: Int,
                        sb: upickle.core.CharBuilder,
                        s: CharSequence,
                        escapeUnicode: Boolean,
                        wrapQuotes: Boolean): upickle.core.CharBuilder = ...
```

#### `upickle/core/SimpleVisitor.scala`

> A visitor that throws an error for all the visit methods which it does not define,
> letting you only define the handlers you care about.

```scala
trait SimpleVisitor[-T, +V] extends Visitor[T, V]
```

```scala
def expectedMsg: String
```

```scala
def visitNull(index: Int): V = ...
```

```scala
def visitTrue(index: Int): V = ...
```

```scala
def visitFalse(index: Int): V = ...
```

```scala
def visitString(s: CharSequence, index: Int): V = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int): V = ...
```

```scala
def visitObject(length: Int, jsonableKeys: Boolean, index: Int): ObjVisitor[T, V] = ...
```

```scala
def visitArray(length: Int, index: Int): ArrVisitor[T, V] = ...
```

```scala
def visitFloat64(d: Double, index: Int): V = ...
```

```scala
def visitFloat32(d: Float, index: Int): V = ...
```

```scala
def visitInt32(i: Int, index: Int): V = ...
```

```scala
def visitInt64(i: Long, index: Int): V = ...
```

```scala
def visitUInt64(i: Long, index: Int): V = ...
```

```scala
def visitFloat64String(s: String, index: Int): V = ...
```

```scala
def visitChar(s: Char, index: Int): V = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int): V = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int): V = ...
```

#### `upickle/core/StringVisitor.scala`

```scala
object StringVisitor extends SimpleVisitor[Nothing, Any]
```

```scala
def expectedMsg = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
override def visitInt32(d: Int, index: Int) = ...
```

```scala
override def visitInt64(d: Long, index: Int) = ...
```

```scala
override def visitUInt64(d: Long, index: Int) = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitTrue(index: Int) = ...
```

```scala
override def visitFalse(index: Int) = ...
```

```scala
override def visitChar(s: Char, index: Int) = ...
```

#### `upickle/core/TraceVisitor.scala`

> Adds a JSON Path to exceptions thrown by the delegate Visitor.
>
> Useful for debugging failures.
> Adds ~10% overhead depending on the parser.
>
> @see https://goessner.net/articles/JsonPath/

```scala
object TraceVisitor
```

```scala
def withTrace[T, J](trace: Boolean, v: Visitor[T, J])(f: Visitor[T, J] => J): J = ...
```

> JSON Path indicating where the problem occurred.
> Added as a suppressed exception.

```scala
class TraceException(val jsonPath: String, cause: Throwable) extends Exception(jsonPath, cause) with NoStackTrace
```

> Internally, the paths form a linked list back to the root by the visitors themselves.
> Compared to something like a List[String] or List[Object], this does not require
> extra String allocation or boxing unless we actually ask for the path.

```scala
trait HasPath
```

> Forms a chain toward the root.

```scala
def parent: Option[HasPath]
```

> @return name of a single level, if any, e.g. "foo"

```scala
def pathComponent: Option[String]
```

> @return the full JSONPath

```scala
def path: String = ...
```

```scala
override def toString: String = ...
```

```scala
object RootHasPath extends HasPath
```

```scala
override def pathComponent: Option[String] = ...
```

```scala
override def parent: Option[HasPath] = ...
```

```scala
class Wrapper[T, J]
```

```scala
def visitor(delegate: Visitor[T, J]): TraceVisitor[T, J] = ...
```

```scala
var lastHasPath: HasPath = ...
```

```scala
class TraceVisitor[T, J](
  protected val delegate: Visitor[T, J],
  parentPath: HasPath,
  wrapper: TraceVisitor.Wrapper[T, J]
) extends Visitor.Delegate[T, J](delegate)
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int): ObjVisitor[T, J] = ...
```

```scala
override def visitArray(length: Int, index: Int): ArrVisitor[T, J] = ...
```

```scala
override def toString: String = ...
```

#### `upickle/core/Transformer.scala`

```scala
trait Transformer[I]
```

```scala
def transform[T](j: I, f: Visitor[_, T]): T
```

#### `upickle/core/Types.scala`

> Basic functionality to be able to read and write objects. Kept as a trait so
> other internal files can use it, while also mixing it into the `upickle`
> package to form the public API1

```scala
trait Types
```

> A combined [[Reader]] and [[Writer]], along with some utility methods.

```scala
trait ReadWriter[T] extends Reader[T] with Writer[T]
```

```scala
override def narrow[K] = ...
```

```scala
def bimap[V](f: V => T, g: T => V): ReadWriter[V] = ...
```

```scala
object ReadWriter
```

```scala
abstract class Delegate[T](other: Visitor[Any, T])
```

```scala
def merge[T](tagKey: String, rws: ReadWriter[_ <: T]*): TaggedReadWriter[T] = {
      new TaggedReadWriter.Node(tagKey, rws.asInstanceOf[Seq[TaggedReadWriter[T]]]:_*)
```

```scala
def merge[T](rws: ReadWriter[_ <: T]*): TaggedReadWriter[T] = merge(Annotator.defaultTagKey, rws:_*)
```

```scala
implicit def join[T](implicit r0: Reader[T], w0: Writer[T]): ReadWriter[T] = ...
```

> A Reader that throws an error for all the visit methods which it does not define,
> letting you only define the handlers you care about.

```scala
trait SimpleReader[T] extends Reader[T] with upickle.core.SimpleVisitor[Any, T]
```

> Represents the ability to read a value of type [[T]].
>
> A thin wrapper around [[Visitor]], but needs to be it's own class in order
> to make type inference automatically pick up it's implicit values.

```scala
trait Reader[T] extends upickle.core.Visitor[Any, T]
```

```scala
override def map[Z](f: T => Z): Reader[Z] = ...
```

```scala
override def mapNulls[Z](f: T => Z): Reader[Z] = ...
```

```scala
def narrow[K <: T] = this.asInstanceOf[Reader[K]]
```

```scala
object Reader
```

```scala
class Delegate[T, V](delegatedReader: Visitor[T, V])
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
abstract class MapReader[-T, V, Z](delegatedReader: Visitor[T, V])
```

```scala
def mapNonNullsFunction(t: V): Z
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
def merge[T](tagKey: String, readers0: Reader[_ <: T]*): TaggedReader.Node[T] = {
      new TaggedReader.Node(tagKey, readers0.asInstanceOf[Seq[TaggedReader[T]]]:_*)
```

```scala
def merge[T](readers0: Reader[_ <: T]*): TaggedReader.Node[T] = merge(Annotator.defaultTagKey, readers0:_*)
```

> Represents the ability to write a value of type [[T]].
>
> Generally nothing more than a way of applying the [[T]] to
> a [[Visitor]], along with some utility methods

```scala
trait Writer[T] extends Transformer[T]
```

> Whether or not the type being written can be used as a key in a JSON dictionary.
> Opt-in, and only applicable to writers that write primitive types like
> strings, booleans, numbers, etc..

```scala
def isJsonDictKey: Boolean = ...
```

```scala
def narrow[K] = ...
```

```scala
def transform[V](v: T, out: Visitor[_, V]) = ...
```

```scala
def write0[V](out: Visitor[_, V], v: T): V
```

```scala
def write[V](out: Visitor[_, V], v: T): V = ...
```

```scala
def comapNulls[U](f: U => T) = ...
```

```scala
def comap[U](f: U => T) = ...
```

```scala
object Writer
```

```scala
class MapWriterNulls[U, T](src: Writer[T], f: U => T) extends Writer[U]
```

```scala
override def write[R](out: Visitor[_, R], v: U): R = ...
```

```scala
def write0[R](out: Visitor[_, R], v: U): R = ...
```

```scala
class MapWriter[U, T](src: Writer[T], f: U => T) extends Writer[U]
```

```scala
def write0[R](out: Visitor[_, R], v: U): R = ...
```

```scala
def merge[T](writers: Writer[_ <: T]*) = {
      new TaggedWriter.Node(writers.asInstanceOf[Seq[TaggedWriter[T]]]:_*)
```

```scala
trait TaggedReader[T] extends SimpleReader[T]
```

```scala
def findReader(s: String): Reader[T]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
object TaggedReader
```

```scala
class Leaf[T](private[upickle] override val tagKey: String, tagValue: String, r: Reader[T]) extends TaggedReader[T]
```

```scala
      @deprecated("Not used, left for binary compatibility")
def this(tag: String, r: Reader[T]) = ...
```

```scala
def findReader(s: String) = ...
```

```scala
class Node[T](private[upickle] override val tagKey: String, rs: TaggedReader[_ <: T]*) extends TaggedReader[T]{
      @deprecated("Not used, left for binary compatibility")
```

```scala
def this(rs: TaggedReader[_ <: T]*) = this(Annotator.defaultTagKey, rs:_*)
```

```scala
def findReader(s: String) = ...
```

```scala
trait TaggedWriter[T] extends Writer[T]
```

```scala
    @deprecated("Not used, left for binary compatibility")
def findWriter(v: Any): (String, ObjectWriter[T])
```

```scala
    @annotation.nowarn("msg=deprecated")
def findWriterWithKey(v: Any): (String, String, ObjectWriter[T]) = ...
```

```scala
def write0[R](out: Visitor[_, R], v: T): R = ...
```

```scala
object TaggedWriter
```

```scala
class Leaf[T](checker: Annotator.Checker, tagKey: String, tagValue: String, r: ObjectWriter[T]) extends TaggedWriter[T]
```

```scala
      @deprecated("Not used, left for binary compatibility")
def this(checker: Annotator.Checker, tag: String, r: ObjectWriter[T]) = ...
```

```scala
      @deprecated("Not used, left for binary compatibility")
def findWriter(v: Any) = ...
```

```scala
override def findWriterWithKey(v: Any) = ...
```

```scala
class Node[T](rs: TaggedWriter[_ <: T]*) extends TaggedWriter[T]{
      @deprecated("Not used, left for binary compatibility")
```

```scala
def findWriter(v: Any) = ...
```

```scala
override def findWriterWithKey(v: Any) = ...
```

```scala
trait TaggedReadWriter[T] extends ReadWriter[T] with TaggedReader[T] with TaggedWriter[T] with SimpleReader[T]
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
object TaggedReadWriter
```

```scala
class Leaf[T](c: ClassTag[_], private[upickle] override val tagKey: String, tagValue: String, r: ObjectWriter[T] with Reader[T]) extends TaggedReadWriter[T]
```

```scala
      @deprecated("Not used, left for binary compatibility")
def this(c: ClassTag[_], tag: String, r: ObjectWriter[T] with Reader[T]) = ...
```

```scala
def findReader(s: String) = ...
```

```scala
      @deprecated("Not used, left for binary compatibility")
def findWriter(v: Any) = ...
```

```scala
override def findWriterWithKey(v: Any) = ...
```

```scala
class Node[T](private[upickle] override val tagKey: String, rs: TaggedReadWriter[_ <: T]*) extends TaggedReadWriter[T]{
      @deprecated("Not used, left for binary compatibility")
```

```scala
def this(rs: TaggedReadWriter[_ <: T]*) = this(Annotator.defaultTagKey, rs:_*)
```

```scala
def findReader(s: String) = ...
```

```scala
      @deprecated("Not used, left for binary compatibility")
def findWriter(v: Any) = ...
```

```scala
override def findWriterWithKey(v: Any) = ...
```

```scala
def taggedExpectedMsg: String
```

```scala
def taggedArrayContext[T](taggedReader: TaggedReader[T], index: Int): ArrVisitor[Any, T] = ...
```

```scala
def taggedObjectContext[T](taggedReader: TaggedReader[T], index: Int): ObjVisitor[Any, T] = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
def taggedWrite[T, R](w: ObjectWriter[T], tag: String, out: Visitor[_,  R], v: T): R
```

```scala
  @annotation.nowarn("msg=deprecated")
def taggedWrite[T, R](w: ObjectWriter[T], tagKey: String, tagValue: String, out: Visitor[_, R], v: T): R = ...
```

```scala
trait ObjectWriter[T] extends Writer[T]
```

```scala
def length(v: T): Int
```

```scala
def writeToObject[R](ctx: ObjVisitor[_, R], v: T): Unit
```

> Implicit to indicate that we are currently deriving an implicit [[T]]. Used
> to avoid the implicit being derived from picking up its own definition,
> resulting in infinite looping/recursion

```scala
class CurrentlyDeriving[T]
```

> Wrap a CaseClassReader or CaseClassWriter reader/writer to handle $type tags during reading and writing.
>
> Note that Scala 3 singleton `enum` values do not have proper `ClassTag[V]`s
> like Scala 2 `case object`s do, so we instead use a `Checker.Val` to check
> for `.equals` equality during writes to determine which tag to use.

```scala
trait Annotator
```

```scala
  @deprecated("Not used, left for binary compatibility")
def annotate[V](rw: Reader[V], n: String): TaggedReader[V]
```

```scala
  @annotation.nowarn("msg=deprecated")
def annotate[V](rw: Reader[V], key: String, value: String): TaggedReader[V] = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
def annotate[V](rw: ObjectWriter[V], n: String, checker: Annotator.Checker): TaggedWriter[V]
```

```scala
  @annotation.nowarn("msg=deprecated")
def annotate[V](rw: ObjectWriter[V], key: String, value: String, checker: Annotator.Checker): TaggedWriter[V] = ...
```

```scala
def annotate[V](rw: ObjectWriter[V], key: String, value: String)(implicit ct: ClassTag[V]): TaggedWriter[V] = ...
```

```scala
  @deprecated("Not used, left for binary compatibility")
final def annotate[V](rw: ObjectWriter[V], n: String)(implicit ct: ClassTag[V]): TaggedWriter[V] = ...
```

```scala
object Annotator
```

```scala
def defaultTagKey = ...
```

```scala
sealed trait Checker
```

```scala
object Checker
```

```scala
case class Cls(c: Class[_]) extends Checker
```

```scala
case class Val(v: Any) extends Checker
```

#### `upickle/core/Visitor.scala`

> Standard set of hooks uPickle uses to traverse over a structured data.
> A superset of the JSON, MessagePack, and Scala object  hierarchies, since
> it needs to support efficiently processing all of them.
>
> Note that some parameters are un-set (-1) when not available; e.g.
> `visitArray`'s `length` is not set when parsing JSON input (since it cannot
> be known up front) and the various `index` parameters are not set when
> traversing Scala object hierarchies.
>
> When expecting to deal with a subset of the methods; it is common to
> forward the ones you don't care about to the ones you do; e.g. JSON visitors
> would forward all `visitFloat32`/`visitInt`/etc. methods to `visitFloat64`
>
> @see [[http://www.lihaoyi.com/post/ZeroOverheadTreeProcessingwiththeVisitorPattern.html]]
> @tparam T ???
> @tparam J the result of visiting elements (e.g. a json AST or side-effecting writer)

```scala
trait Visitor[-T, +J]
```

> @param index json source position at the start of the `[` being visited
> @return a [[Visitor]] used for visiting the elements of the array

```scala
def visitArray(length: Int, index: Int): ArrVisitor[T, J]
```

> @param index json source position at the start of the `{` being visited
> @return a [[ObjVisitor]] used for visiting the keys/values of the object

```scala
def visitObject(length: Int, jsonableKeys: Boolean, index: Int): ObjVisitor[T, J]
```

> @param index json source position at the start of the `null` being visited

```scala
def visitNull(index: Int): J
```

> @param index json source position at the start of the `false` being visited

```scala
def visitFalse(index: Int): J
```

> @param index json source position at the start of the `true` being visited

```scala
def visitTrue(index: Int): J
```

> Visit the number in its text representation.
>
> @param s        unparsed text representation of the number.
> @param decIndex index of the `.`, relative to the start of the CharSequence, or -1 if omitted
> @param expIndex index of `e` or `E` relative to the start of the CharSequence, or -1 if omitted
> @param index    json source position at the start of the number being visited

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int): J
```

```scala
def visitFloat64ByteParts(s: Array[Byte], arrOffset: Int, arrLength: Int, decIndex: Int, expIndex: Int, index: Int): J = ...
```

```scala
def visitFloat64CharParts(s: Array[Char], arrOffset: Int, arrLength: Int, decIndex: Int, expIndex: Int, index: Int): J = ...
```

> Optional handler for raw double values; can be overriden for performance
> in cases where you're translating directly between numbers to avoid the
> overhead of stringifying and re-parsing your numbers (e.g. the WebJson
> transformer gets raw doubles from the underlying Json.parse).
>
> Delegates to `visitFloat64StringParts` if not overriden
>
> @param d     the input number
> @param index json source position at the start of the number being visited

```scala
def visitFloat64(d: Double, index: Int): J
```

```scala
def visitFloat32(d: Float, index: Int): J
```

```scala
def visitInt32(i: Int, index: Int): J
```

```scala
def visitInt64(i: Long, index: Int): J
```

```scala
def visitUInt64(i: Long, index: Int): J
```

> Convenience methods to help you compute the decimal-point-index and
> exponent-index of an arbitrary numeric string
>
> @param s     the text string being visited
> @param index json source position at the start of the string being visited

```scala
def visitFloat64String(s: String, index: Int): J
```

> @param s     the text string being visited
> @param index json source position at the start of the string being visited

```scala
def visitString(s: CharSequence, index: Int): J
```

```scala
def visitChar(s: Char, index: Int): J
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int): J
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int): J
```

```scala
def map[Z](f: J => Z): Visitor[T, Z] = ...
```

```scala
def mapNulls[Z](f: J => Z): Visitor[T, Z] = ...
```

> Base class for visiting elements of json arrays and objects.
>
> @tparam T ???
> @tparam J the result of visiting elements (e.g. a json AST or side-effecting writer)

```scala
sealed trait ObjArrVisitor[-T, +J]
```

> Called on descent into elements.
>
> The returned [[Visitor]] will be used to visit this branch of the json.

```scala
def subVisitor: Visitor[_, _]
```

> Called on completion of visiting an array element or object field value, with the produced result, [[T]].
>
> @param v     result of visiting a value in this object or arary
> (not the input value, this would have been passed to [[subVisitor]])
> @param index json source character position being visited

```scala
def visitValue(v: T, index: Int): Unit
```

> Called on end of the object or array.
>
> @param index json source position at the start of the '}' or ']' being visited
> @return the result of visiting this array or object

```scala
def visitEnd(index: Int): J
```

> @return true if this is a json object
> false if this is a json array

```scala
def isObj: Boolean
```

> Casts [[T]] from _ to [[Any]].

```scala
def narrow = ...
```

```scala
object Visitor
```

```scala
class Delegate[T, V](delegatedReader: Visitor[T, V]) extends Visitor[T, V]
```

```scala
override def visitNull(index: Int) = ...
```

```scala
override def visitTrue(index: Int) = ...
```

```scala
override def visitFalse(index: Int) = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
override def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitInt32(i: Int, index: Int) = ...
```

```scala
override def visitInt64(i: Long, index: Int) = ...
```

```scala
override def visitUInt64(i: Long, index: Int) = ...
```

```scala
override def visitFloat64String(s: String, index: Int) = ...
```

```scala
override def visitChar(s: Char, index: Int) = ...
```

```scala
override def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
override def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
abstract class MapReader[-T, V, Z](delegatedReader: Visitor[T, V]) extends Visitor[T, Z]
```

```scala
def mapNonNullsFunction(t: V) : Z
```

```scala
def mapFunction(v: V): Z = ...
```

```scala
override def visitFalse(index: Int) = ...
```

```scala
override def visitNull(index: Int) = ...
```

```scala
override def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
override def visitTrue(index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int): ObjVisitor[T, Z] = ...
```

```scala
override def visitArray(length: Int, index: Int): ArrVisitor[T, Z] = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitInt32(i: Int, index: Int) = ...
```

```scala
override def visitInt64(i: Long, index: Int) = ...
```

```scala
override def visitUInt64(i: Long, index: Int) = ...
```

```scala
override def visitFloat64String(s: String, index: Int) = ...
```

```scala
override def visitChar(s: Char, index: Int) = ...
```

```scala
override def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
override def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
class MapArrContext[T, V, Z](src: ArrVisitor[T, V], f: V => Z) extends ArrVisitor[T, Z]
```

```scala
def subVisitor: Visitor[_, _] = ...
```

```scala
def visitValue(v: T, index: Int): Unit = ...
```

```scala
def visitEnd(index: Int) = ...
```

```scala
class MapObjContext[T, V, Z](src: ObjVisitor[T, V], f: V => Z) extends ObjVisitor[T, Z]
```

```scala
def subVisitor: Visitor[_, _] = ...
```

```scala
def visitKey(index: Int): Visitor[_, _] = ...
```

```scala
def visitKeyValue(s: Any) = ...
```

```scala
def visitValue(v: T, index: Int): Unit = ...
```

```scala
def visitEnd(index: Int) = ...
```

> Visits the elements of a json object.

```scala
trait ObjVisitor[-T, +J] extends ObjArrVisitor[T, J]
```

> @param s     the value of the key
> @param index json source position at the start of the key being visited

```scala
def visitKey(index: Int): Visitor[_, _]
```

```scala
def visitKeyValue(v: Any): Unit
```

```scala
def isObj = ...
```

```scala
override def narrow: ObjVisitor[Any, J] = ...
```

> Visits the elements of a json array.

```scala
trait ArrVisitor[-T, +J] extends ObjArrVisitor[T, J]
```

```scala
def isObj = ...
```

```scala
override def narrow = ...
```

> Signals failure processsing JSON after parsing.

```scala
case class AbortException(clue: String,
                          index: Int,
                          line: Int,
                          col: Int,
                          cause: Throwable) extends Exception(clue + " at index " + index, cause)
```

> Throw this inside a [[Visitor]]'s handler functions to fail the processing
> of JSON. The Facade just needs to provide the error message, and it is up
> to the driver to ensure it is properly wrapped in a [[AbortException]]
> with the relevant source information.

```scala
case class Abort(msg: String) extends Exception(msg)
```

#### `upickle/core/compat/LinkedHashMapCompat.scala`

```scala
trait LinkedHashMapCompat[K, V]
```

```scala
object LinkedHashMapCompat
```

```scala
def factory[K, V]: Factory[(K, V), LinkedHashMap[K, V]] = ...
```

#### `upickle/core/compat/SortInPlace.scala`

```scala
object SortInPlace
```

```scala
def apply[T, B: scala.Ordering](t: collection.mutable.ArrayBuffer[T])(f: PartialFunction[T, B]): Unit = ...
```

```scala
object DistinctBy
```

```scala
def apply[T, V](items: collection.Seq[T])(f: T => V) = ...
```

#### `upickle/core/compat/package.scala`

```scala
package object compat
```

```scala
type Factory[-A, +C] = ...
```

```scala
def toIterator[T](iterable: IterableOnce[T]) = ...
```

### `com.lihaoyi:upickle-implicits_3:3.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1/upickle-implicits_3-3.3.1-sources.jar

#### `upickle/Generated.scala`

> Auto-generated picklers and unpicklers, used for creating the 22
> versions of tuple-picklers and case-class picklers

```scala
trait Generated extends TupleReadWriters
```

```scala
implicit def Tuple1Writer[T1: Writer]: TupleNWriter[Tuple1[T1]] = ...
```

```scala
implicit def Tuple1Reader[T1: Reader]: TupleNReader[Tuple1[T1]] = ...
```

```scala
implicit def Tuple2Writer[T1: Writer, T2: Writer]: TupleNWriter[Tuple2[T1, T2]] = ...
```

```scala
implicit def Tuple2Reader[T1: Reader, T2: Reader]: TupleNReader[Tuple2[T1, T2]] = ...
```

```scala
implicit def Tuple3Writer[T1: Writer, T2: Writer, T3: Writer]: TupleNWriter[Tuple3[T1, T2, T3]] = ...
```

```scala
implicit def Tuple3Reader[T1: Reader, T2: Reader, T3: Reader]: TupleNReader[Tuple3[T1, T2, T3]] = ...
```

```scala
implicit def Tuple4Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer]: TupleNWriter[Tuple4[T1, T2, T3, T4]] = ...
```

```scala
implicit def Tuple4Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader]: TupleNReader[Tuple4[T1, T2, T3, T4]] = ...
```

```scala
implicit def Tuple5Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer]: TupleNWriter[Tuple5[T1, T2, T3, T4, T5]] = ...
```

```scala
implicit def Tuple5Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader]: TupleNReader[Tuple5[T1, T2, T3, T4, T5]] = ...
```

```scala
implicit def Tuple6Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer]: TupleNWriter[Tuple6[T1, T2, T3, T4, T5, T6]] = ...
```

```scala
implicit def Tuple6Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader]: TupleNReader[Tuple6[T1, T2, T3, T4, T5, T6]] = ...
```

```scala
implicit def Tuple7Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer]: TupleNWriter[Tuple7[T1, T2, T3, T4, T5, T6, T7]] = ...
```

```scala
implicit def Tuple7Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader]: TupleNReader[Tuple7[T1, T2, T3, T4, T5, T6, T7]] = ...
```

```scala
implicit def Tuple8Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer]: TupleNWriter[Tuple8[T1, T2, T3, T4, T5, T6, T7, T8]] = ...
```

```scala
implicit def Tuple8Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader]: TupleNReader[Tuple8[T1, T2, T3, T4, T5, T6, T7, T8]] = ...
```

```scala
implicit def Tuple9Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer]: TupleNWriter[Tuple9[T1, T2, T3, T4, T5, T6, T7, T8, T9]] = ...
```

```scala
implicit def Tuple9Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader]: TupleNReader[Tuple9[T1, T2, T3, T4, T5, T6, T7, T8, T9]] = ...
```

```scala
implicit def Tuple10Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer]: TupleNWriter[Tuple10[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10]] = ...
```

```scala
implicit def Tuple10Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader]: TupleNReader[Tuple10[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10]] = ...
```

```scala
implicit def Tuple11Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer]: TupleNWriter[Tuple11[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11]] = ...
```

```scala
implicit def Tuple11Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader]: TupleNReader[Tuple11[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11]] = ...
```

```scala
implicit def Tuple12Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer]: TupleNWriter[Tuple12[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12]] = ...
```

```scala
implicit def Tuple12Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader]: TupleNReader[Tuple12[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12]] = ...
```

```scala
implicit def Tuple13Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer]: TupleNWriter[Tuple13[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13]] = ...
```

```scala
implicit def Tuple13Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader]: TupleNReader[Tuple13[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13]] = ...
```

```scala
implicit def Tuple14Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer]: TupleNWriter[Tuple14[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14]] = ...
```

```scala
implicit def Tuple14Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader]: TupleNReader[Tuple14[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14]] = ...
```

```scala
implicit def Tuple15Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer]: TupleNWriter[Tuple15[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15]] = ...
```

```scala
implicit def Tuple15Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader]: TupleNReader[Tuple15[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15]] = ...
```

```scala
implicit def Tuple16Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer]: TupleNWriter[Tuple16[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16]] = ...
```

```scala
implicit def Tuple16Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader]: TupleNReader[Tuple16[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16]] = ...
```

```scala
implicit def Tuple17Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer]: TupleNWriter[Tuple17[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17]] = ...
```

```scala
implicit def Tuple17Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader]: TupleNReader[Tuple17[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17]] = ...
```

```scala
implicit def Tuple18Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer, T18: Writer]: TupleNWriter[Tuple18[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18]] = ...
```

```scala
implicit def Tuple18Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader, T18: Reader]: TupleNReader[Tuple18[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18]] = ...
```

```scala
implicit def Tuple19Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer, T18: Writer, T19: Writer]: TupleNWriter[Tuple19[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19]] = ...
```

```scala
implicit def Tuple19Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader, T18: Reader, T19: Reader]: TupleNReader[Tuple19[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19]] = ...
```

```scala
implicit def Tuple20Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer, T18: Writer, T19: Writer, T20: Writer]: TupleNWriter[Tuple20[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20]] = ...
```

```scala
implicit def Tuple20Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader, T18: Reader, T19: Reader, T20: Reader]: TupleNReader[Tuple20[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20]] = ...
```

```scala
implicit def Tuple21Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer, T18: Writer, T19: Writer, T20: Writer, T21: Writer]: TupleNWriter[Tuple21[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21]] = ...
```

```scala
implicit def Tuple21Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader, T18: Reader, T19: Reader, T20: Reader, T21: Reader]: TupleNReader[Tuple21[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21]] = ...
```

```scala
implicit def Tuple22Writer[T1: Writer, T2: Writer, T3: Writer, T4: Writer, T5: Writer, T6: Writer, T7: Writer, T8: Writer, T9: Writer, T10: Writer, T11: Writer, T12: Writer, T13: Writer, T14: Writer, T15: Writer, T16: Writer, T17: Writer, T18: Writer, T19: Writer, T20: Writer, T21: Writer, T22: Writer]: TupleNWriter[Tuple22[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21, T22]] = ...
```

```scala
implicit def Tuple22Reader[T1: Reader, T2: Reader, T3: Reader, T4: Reader, T5: Reader, T6: Reader, T7: Reader, T8: Reader, T9: Reader, T10: Reader, T11: Reader, T12: Reader, T13: Reader, T14: Reader, T15: Reader, T16: Reader, T17: Reader, T18: Reader, T19: Reader, T20: Reader, T21: Reader, T22: Reader]: TupleNReader[Tuple22[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21, T22]] = ...
```

#### `upickle/implicits/CaseClassReadWriters.scala`

> Basic functionality to be able to read and write objects. Kept as a trait so
> other internal files can use it, while also mixing it into the `upickle`
> package to form the public API1

```scala
trait CaseClassReadWriters extends upickle.core.Types
```

```scala
def allowUnknownKeys: Boolean = ...
```

```scala
abstract class CaseClassReader[V] extends SimpleReader[V]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
trait CaseClassWriter[V] extends ObjectWriter[V]
```

```scala
def length(v: V): Int
```

```scala
    @deprecated("Not used, left for binary compatibility")
def writeToObject[R](ctx: ObjVisitor[_, R], v: V): Unit
```

```scala
    @scala.annotation.nowarn
def write0[R](out: Visitor[_, R], v: V): R = ...
```

```scala
def writeSnippetMappedName[R, V](ctx: _root_.upickle.core.ObjVisitor[_, R],
                                     mappedArgsI: CharSequence,
                                     w: Any,
                                     value: Any) = ...
```

```scala
    @deprecated("Not used, left for binary compatibility")
def writeSnippet[R, V](objectAttributeKeyWriteMap: CharSequence => CharSequence,
                           ctx: _root_.upickle.core.ObjVisitor[_, R],
                           mappedArgsI: String,
                           w: Any,
                           value: Any) = ...
```

```scala
class SingletonReader[T](t: T) extends CaseClassReader[T]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
class SingletonWriter[T](f: T) extends CaseClassWriter[T]
```

```scala
def length(v: T) = ...
```

```scala
def writeToObject[R](ctx: ObjVisitor[_, R], v: T): Unit = ...
```

#### `upickle/implicits/MacroImplicits.scala`

```scala
trait MacroImplicits extends Readers with Writers with upickle.core.Annotator:
```

```scala
inline def macroRW[T: ClassTag](using Mirror.Of[T]): ReadWriter[T] = ...
```

```scala
inline def macroRWAll[T: ClassTag](using Mirror.Of[T]): ReadWriter[T] = ...
```

```scala
implicit class ReadWriterExtension(r: ReadWriter.type):
```

```scala
inline def derived[T](using Mirror.Of[T], ClassTag[T]): ReadWriter[T] = ...
```

#### `upickle/implicits/MacrosCommon.scala`

```scala
trait MacrosCommon
```

```scala
def serializeDefaults: Boolean = ...
```

```scala
def objectAttributeKeyReadMap(s: CharSequence): CharSequence = ...
```

```scala
def objectAttributeKeyWriteMap(s: CharSequence): CharSequence = ...
```

```scala
def objectTypeKeyReadMap(s: CharSequence): CharSequence = ...
```

```scala
def objectTypeKeyWriteMap(s: CharSequence): CharSequence = ...
```

```scala
object MacrosCommon
```

```scala
def tagKeyFromParents[P](
    typeName: => String,
    sealedParents: List[P],
    getKey: P => Option[String],
    getName: P => String,
    fail: String => Nothing,
  ): String = ...
```

#### `upickle/implicits/ObjectContexts.scala`

```scala
trait BaseCaseObjectContext
```

```scala
def storeAggregatedValue(currentIndex: Int, v: Any): Unit
```

```scala
def visitKey(index: Int) = ...
```

```scala
var currentIndex = ...
```

```scala
def storeValueIfNotFound(i: Int, v: Any): Unit
```

```scala
abstract class CaseObjectContext[V](fieldCount: Int) extends ObjVisitor[Any, V] with BaseCaseObjectContext
```

```scala
var found = ...
```

```scala
def visitValue(v: Any, index: Int): Unit = ...
```

```scala
def storeValueIfNotFound(i: Int, v: Any) = ...
```

```scala
abstract class HugeCaseObjectContext[V](fieldCount: Int) extends ObjVisitor[Any, V] with BaseCaseObjectContext
```

```scala
var found = ...
```

```scala
def visitValue(v: Any, index: Int): Unit = ...
```

```scala
def storeValueIfNotFound(i: Int, v: Any) = ...
```

#### `upickle/implicits/Readers.scala`

```scala
trait Readers extends upickle.core.Types
  with TupleReadWriters
  with Generated
  with ReadersVersionSpecific
```

```scala
implicit val UnitReader: Reader[Unit] = ...
```

```scala
implicit val BooleanReader: Reader[Boolean] = ...
```

```scala
implicit val DoubleReader: Reader[Double] = ...
```

```scala
implicit val IntReader: Reader[Int] = ...
```

```scala
implicit val FloatReader: Reader[Float] = ...
```

```scala
implicit val ShortReader: Reader[Short] = ...
```

```scala
implicit val ByteReader: Reader[Byte] = ...
```

```scala
implicit val StringReader: Reader[String] = ...
```

```scala
trait SimpleStringReader[T] extends SimpleReader[T]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
def readString(s: CharSequence): T
```

```scala
implicit val CharReader: Reader[Char] = ...
```

```scala
implicit val UUIDReader: Reader[UUID] = ...
```

```scala
implicit val LongReader: Reader[Long] = ...
```

```scala
implicit val BigIntReader: Reader[BigInt] = ...
```

```scala
implicit val BigDecimalReader: Reader[BigDecimal] = ...
```

```scala
implicit val SymbolReader: Reader[Symbol] = ...
```

```scala
def MapReader0[M[A, B] <: collection.Map[A, B], K, V]
                (make: Iterable[(K, V)] => M[K, V])
```

```scala
implicit def MapReader1[K: Reader, V: Reader]: Reader[collection.Map[K, V]] = ...
```

```scala
implicit def MapReader2[K: Reader, V: Reader]: Reader[collection.immutable.Map[K, V]] = ...
```

```scala
implicit def MapReader3[K: Reader, V: Reader]: Reader[collection.mutable.Map[K, V]] = ...
```

```scala
implicit def MapReader4[K: Reader, V: Reader]: Reader[collection.mutable.LinkedHashMap[K, V]] = ...
```

```scala
implicit def SortedMapReader[K: Reader: Ordering, V: Reader]: Reader[collection.mutable.SortedMap[K, V]] = ...
```

```scala
implicit def MapReader6[K: Reader: Ordering, V: Reader]: Reader[collection.immutable.SortedMap[K, V]] = ...
```

```scala
implicit def MapReader7[K: Reader: Ordering, V: Reader]: Reader[collection.SortedMap[K, V]] = ...
```

```scala
implicit def OptionReader[T: Reader]: Reader[Option[T]] = ...
```

```scala
implicit def SomeReader[T: Reader]: Reader[Some[T]] = ...
```

```scala
implicit def NoneReader: Reader[None.type] = ...
```

```scala
implicit def ArrayReader[T: Reader: ClassTag]: Reader[Array[T]] = ...
```

```scala
implicit def SeqLikeReader[C[_], T](implicit r: Reader[T],
                                      factory: Factory[T, C[T]]): Reader[C[T]] = ...
```

```scala
class SeqLikeReader[C[_], T](implicit r: Reader[T],
                                      factory: Factory[T, C[T]]) extends SimpleReader[C[T]]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
implicit val DurationReader: Reader[Duration] = ...
```

```scala
implicit val InfiniteDurationReader: Reader[Duration.Infinite] = ...
```

```scala
implicit val FiniteDurationReader: Reader[FiniteDuration] = ...
```

```scala
implicit def EitherReader[T1: Reader, T2: Reader]: SimpleReader[Either[T1, T2]] = ...
```

```scala
implicit def RightReader[T1: Reader, T2: Reader]: Reader[Right[T1, T2]] = ...
```

```scala
implicit def LeftReader[T1: Reader, T2: Reader]: Reader[Left[T1, T2]] = ...
```

```scala
implicit val JavaBooleanReader: Reader[java.lang.Boolean] = ...
```

```scala
implicit val JavaByteReader: Reader[java.lang.Byte] = ...
```

```scala
implicit val JavaCharReader: Reader[java.lang.Character] = ...
```

```scala
implicit val JavaShortReader: Reader[java.lang.Short] = ...
```

```scala
implicit val JavaIntReader: Reader[java.lang.Integer] = ...
```

```scala
implicit val JavaLongReader: Reader[java.lang.Long] = ...
```

```scala
implicit val JavaFloatReader: Reader[java.lang.Float] = ...
```

```scala
implicit val JavaDoubleReader: Reader[java.lang.Double] = ...
```

#### `upickle/implicits/TupleReadWriters.scala`

> Basic functionality to be able to read and write objects. Kept as a trait so
> other internal files can use it, while also mixing it into the `upickle`
> package to form the public API1

```scala
trait TupleReadWriters extends upickle.core.Types
```

```scala
class TupleNWriter[V](val writers: Array[Writer[_]], val f: V => Array[Any]) extends Writer[V]
```

```scala
def write0[R](out: Visitor[_, R], v: V): R = ...
```

```scala
class TupleNReader[V](val readers: Array[Reader[_]], val f: Array[Any] => V) extends SimpleReader[V]
```

```scala
override def expectedMsg = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

#### `upickle/implicits/Writers.scala`

```scala
trait Writers extends upickle.core.Types
  with TupleReadWriters
  with Generated
  with WritersVersionSpecific
  with LowPriWriters
```

```scala
implicit val StringWriter: Writer[String] = ...
```

```scala
implicit val UnitWriter: Writer[Unit] = ...
```

```scala
implicit val DoubleWriter: Writer[Double] = ...
```

```scala
implicit val IntWriter: Writer[Int] = ...
```

```scala
implicit val FloatWriter: Writer[Float] = ...
```

```scala
implicit val ShortWriter: Writer[Short] = ...
```

```scala
implicit val ByteWriter: Writer[Byte] = ...
```

```scala
implicit val BooleanWriter: Writer[Boolean] = ...
```

```scala
implicit val CharWriter: Writer[Char] = ...
```

```scala
implicit val UUIDWriter: Writer[UUID] = ...
```

```scala
implicit val LongWriter: Writer[Long] = ...
```

```scala
implicit val BigIntWriter: Writer[BigInt] = ...
```

```scala
implicit val BigDecimalWriter: Writer[BigDecimal] = ...
```

```scala
implicit val SymbolWriter: Writer[Symbol] = ...
```

```scala
implicit def OptionWriter[T: Writer]: Writer[Option[T]] = ...
```

```scala
implicit def SomeWriter[T: Writer]: Writer[Some[T]] = ...
```

```scala
implicit def NoneWriter: Writer[None.type] = ...
```

```scala
implicit def ArrayWriter[T](implicit r: Writer[T]): Writer[Array[T]] = ...
```

```scala
trait SimpleMapKeyWriter[T] extends Writer[T]
```

```scala
override def isJsonDictKey = ...
```

```scala
def writeString(v: T): String
```

```scala
def write0[R](out: Visitor[_, R], v: T): R = ...
```

```scala
def MapWriter0[M[A, B] <: collection.Map[A, B], K, V]
                (implicit kw: Writer[K], vw: Writer[V]): Writer[M[K, V]] = ...
```

```scala
implicit def MapWriter1[K: Writer, V: Writer]: Writer[collection.Map[K, V]] = ...
```

```scala
implicit def MapWriter2[K: Writer, V: Writer]: Writer[collection.immutable.Map[K, V]] = ...
```

```scala
implicit def MapWriter3[K: Writer, V: Writer]: Writer[collection.mutable.Map[K, V]] = ...
```

```scala
implicit def MapWriter4[K: Writer, V: Writer]: Writer[collection.mutable.LinkedHashMap[K, V]] = ...
```

```scala
implicit def MapWriter5[K: Writer, V: Writer]: Writer[collection.mutable.SortedMap[K, V]] = ...
```

```scala
implicit def MapWriter6[K: Writer, V: Writer]: Writer[collection.immutable.SortedMap[K, V]] = ...
```

```scala
implicit def MapWriter7[K: Writer, V: Writer]: Writer[collection.SortedMap[K, V]] = ...
```

```scala
implicit val DurationWriter: Writer[Duration] = ...
```

```scala
implicit val InfiniteDurationWriter: Writer[Duration.Infinite] = ...
```

```scala
implicit val FiniteDurationWriter: Writer[FiniteDuration] = ...
```

```scala
implicit def EitherWriter[T1: Writer, T2: Writer]: Writer[Either[T1, T2]] = ...
```

```scala
implicit def RightWriter[T1: Writer, T2: Writer]: Writer[Right[T1, T2]] = ...
```

```scala
implicit def LeftWriter[T1: Writer, T2: Writer]: Writer[Left[T1, T2]] = ...
```

```scala
implicit val JavaBooleanWriter: Writer[java.lang.Boolean] = ...
```

```scala
implicit val JavaByteWriter: Writer[java.lang.Byte] = ...
```

```scala
implicit val JavaCharWriter: Writer[java.lang.Character] = ...
```

```scala
implicit val JavaShortWriter: Writer[java.lang.Short] = ...
```

```scala
implicit val JavaIntWriter: Writer[java.lang.Integer] = ...
```

```scala
implicit val JavaLongWriter: Writer[java.lang.Long] = ...
```

```scala
implicit val JavaFloatWriter: Writer[java.lang.Float] = ...
```

```scala
implicit val JavaDoubleWriter: Writer[java.lang.Double] = ...
```

> This needs to be split into a separate trait due to https://github.com/scala/bug/issues/11768

```scala
trait LowPriWriters extends upickle.core.Types
```

```scala
implicit def SeqLikeWriter[C[_] <: Iterable[_], T](implicit r: Writer[T]): Writer[C[T]] = new Writer[C[T]] {
    def write0[R](out: Visitor[_, R], v: C[T]): R = ...
```

#### `upickle/implicits/key.scala`

```scala
case class key(s: String) extends StaticAnnotation
```

```scala
case class allowUnknownKeys(b: Boolean) extends StaticAnnotation
```

#### `upickle/implicits/macros.scala`

```scala
type IsInt[A <: Int] = A
```

```scala
def getDefaultParamsImpl0[T](using Quotes, Type[T]): Map[String, Expr[AnyRef]] = ...
```

```scala
def extractKey[A](using Quotes)(sym: quotes.reflect.Symbol): Option[String] = ...
```

```scala
inline def extractIgnoreUnknownKeys[T](): List[Boolean] = ...
```

```scala
def extractIgnoreUnknownKeysImpl[T](using Quotes, Type[T]): Expr[List[Boolean]] = ...
```

```scala
inline def paramsCount[T]: Int = ...
```

```scala
def paramsCountImpl[T](using Quotes, Type[T]) = ...
```

```scala
inline def storeDefaults[T](inline x: upickle.implicits.BaseCaseObjectContext): Unit = ...
```

```scala
inline def writeLength[T](inline thisOuter: upickle.core.Types with upickle.implicits.MacrosCommon,
                          inline v: T): Int = ...
```

```scala
def writeLengthImpl[T](thisOuter: Expr[upickle.core.Types with upickle.implicits.MacrosCommon],
                                       v: Expr[T])
```

```scala
inline def checkErrorMissingKeysCount[T](): Long = ...
```

```scala
def checkErrorMissingKeysCountImpl[T]()(using Quotes, Type[T]): Expr[Long] = ...
```

```scala
inline def writeSnippets[R, T, WS <: Tuple](inline thisOuter: upickle.core.Types with upickle.implicits.MacrosCommon,
                                   inline self: upickle.implicits.CaseClassReadWriters#CaseClassWriter[T],
                                   inline v: T,
                                   inline ctx: _root_.upickle.core.ObjVisitor[_, R]): Unit = ...
```

```scala
def writeSnippetsImpl[R, T, WS <: Tuple](thisOuter: Expr[upickle.core.Types with upickle.implicits.MacrosCommon],
                            self: Expr[upickle.implicits.CaseClassReadWriters#CaseClassWriter[T]],
                            v: Expr[T],
                            ctx: Expr[_root_.upickle.core.ObjVisitor[_, R]])
```

```scala
inline def isMemberOfSealedHierarchy[T]: Boolean = ...
```

```scala
def isMemberOfSealedHierarchyImpl[T](using Quotes, Type[T]): Expr[Boolean] = ...
```

```scala
inline def tagKey[T]: String = ...
```

```scala
def tagKeyImpl[T](using Quotes, Type[T]): Expr[String] = ...
```

```scala
inline def tagName[T]: String = ...
```

```scala
def tagNameImpl[T](using Quotes, Type[T]): Expr[String] = ...
```

```scala
inline def isSingleton[T]: Boolean = ...
```

```scala
def isSingletonImpl[T](using Quotes, Type[T]): Expr[Boolean] = ...
```

```scala
inline def getSingleton[T]: T = ...
```

```scala
def getSingletonImpl[T](using Quotes, Type[T]): Expr[T] = ...
```

```scala
inline def defineEnumReaders[T0, T <: Tuple](prefix: Any): T0 = ${ defineEnumVisitorsImpl[T0, T]('prefix, "macroR") }
inline def defineEnumWriters[T0, T <: Tuple](prefix: Any): T0 = ${ defineEnumVisitorsImpl[T0, T]('prefix, "macroW") }
def defineEnumVisitorsImpl[T0, T <: Tuple](prefix: Expr[Any], macroX: String)(using Quotes, Type[T0], Type[T]): Expr[T0] =
  import quotes.reflect._

  def handleType(tpe: TypeRepr, name: String, skipTrait: Boolean): Option[(ValDef, Symbol)] = {

    val AppliedType(typePrefix, List(arg)) = tpe: @unchecked

    if (skipTrait &&
        (arg.typeSymbol.flags.is(Flags.Trait) ||
          // Filter out `enum`s, because the `case`s of an enum are flagged as
          // abstract enums for some reasons rather than as case classes
          (arg.typeSymbol.flags.is(Flags.Abstract) && !arg.typeSymbol.flags.is(Flags.Enum)))){
      None
    } else {
      val sym = Symbol.newVal(
        Symbol.spliceOwner,
        name,
        tpe,
        Flags.Implicit | Flags.Lazy,
        Symbol.noSymbol
      )

      val macroCall = TypeApply(
        Select(prefix.asTerm, prefix.asTerm.tpe.typeSymbol.methodMember(macroX).head),
        List(TypeTree.of(using arg.asType))
      )

      val newDef = ValDef(sym, Some(macroCall))

      Some((newDef, sym))
    }
  }

  def getDefs(t: TypeRepr, defs: List[(ValDef, Symbol)]): List[(ValDef, Symbol)] = {
    t match{
      case AppliedType(prefix, args) =>
        val defAndSymbol = handleType(args(0), "x" + defs.size, skipTrait = true)
        getDefs(args(1), defAndSymbol.toList ::: defs)
```

### `com.lihaoyi:ujson_3:3.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1/ujson_3-3.3.1-sources.jar

#### `BaseByteRenderer.scala`

> A specialized JSON renderer that can render Bytes (Chars or Bytes) directly
> to a [[java.io.Writer]] or [[java.io.OutputStream]]
>
> Note that we use an internal `ByteBuilder` to buffer the output internally
> before sending it to [[out]] in batches. This lets us benefit from the high
> performance and minimal overhead of `ByteBuilder` in the fast path of
> pushing characters, and avoid the synchronization/polymorphism overhead of
> [[out]] on the fast path. Most [[out]]s would also have performance
> benefits from receiving data in batches, rather than byte by byte.

```scala
class BaseByteRenderer[T <: upickle.core.ByteOps.Output]
                      (out: T,
                       indent: Int = -1,
                       escapeUnicode: Boolean = false) extends JsVisitor[T, T]
```

```scala
def flushByteBuilder() = ...
```

```scala
def flushBuffer() = ...
```

```scala
def visitArray(length: Int, index: Int) = ...
```

```scala
def visitJsonableObject(length: Int, index: Int) = ...
```

```scala
def visitNull(index: Int) = ...
```

```scala
def visitFalse(index: Int) = ...
```

```scala
def visitTrue(index: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitInt32(i: Int, index: Int) = ...
```

```scala
override def visitInt64(i: Long, index: Int) = ...
```

```scala
override def visitUInt64(i: Long, index: Int) = ...
```

```scala
def visitString(s: CharSequence, index: Int) = ...
```

```scala
def visitNonNullString(s: CharSequence, index: Int) = ...
```

```scala
final def renderIndent() = ...
```

```scala
object BaseByteRenderer
```

#### `BaseCharRenderer.scala`

> A specialized JSON renderer that can render Chars (Chars or Bytes) directly
> to a [[java.io.Writer]] or [[java.io.OutputStream]]
>
> Note that we use an internal `CharBuilder` to buffer the output internally
> before sending it to [[out]] in batches. This lets us benefit from the high
> performance and minimal overhead of `CharBuilder` in the fast path of
> pushing characters, and avoid the synchronization/polymorphism overhead of
> [[out]] on the fast path. Most [[out]]s would also have performance
> benefits from receiving data in batches, rather than char by char.

```scala
class BaseCharRenderer[T <: upickle.core.CharOps.Output]
                      (out: T,
                       indent: Int = -1,
                       escapeUnicode: Boolean = false) extends JsVisitor[T, T]
```

```scala
def flushCharBuilder() = ...
```

```scala
def flushBuffer() = ...
```

```scala
def visitArray(length: Int, index: Int) = ...
```

```scala
def visitJsonableObject(length: Int, index: Int) = ...
```

```scala
def visitNull(index: Int) = ...
```

```scala
def visitFalse(index: Int) = ...
```

```scala
def visitTrue(index: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitInt32(i: Int, index: Int) = ...
```

```scala
override def visitInt64(i: Long, index: Int) = ...
```

```scala
override def visitUInt64(i: Long, index: Int) = ...
```

```scala
def visitString(s: CharSequence, index: Int) = ...
```

```scala
def visitNonNullString(s: CharSequence, index: Int) = ...
```

```scala
final def renderIndent() = ...
```

```scala
object BaseCharRenderer
```

#### `ByteParser.scala`

> A specialized JSON parse that can parse Bytes (Chars or Bytes), sending
> method calls to the given [[upickle.core.Visitor]].
>
> Generally has a lot of tricks for performance: e.g. having duplicate
> implementations for nested v.s. top-level parsing, using an `ByteBuilder`
> to construct the `CharSequences` that `visitString` requires, etc.

```scala
abstract class ByteParser[J] extends upickle.core.BufferingByteParser
```

> A fast-path to check whether an index can be safely accessed, before calling
> [[getByteUnsafe]]. Together, it is similar to calling [[getByteSafe]], except
> this returns the new safeIndex which the caller can then use to call
> [[getByteUnsafe]] multiple times before needing to call this again.

```scala
def requestUntilOrThrow(j: Int): Unit = ...
```

```scala
def checkSafeIndex(j: Int): Int = ...
```

```scala
override def getByteSafe(i: Int): Byte = ...
```

> Parse the JSON document into a single JSON value.
>
> The parser considers documents like '333', 'true', and '"foo"' to be
> valid, as well as more traditional documents like [1,2,3,4,5]. However,
> multiple top-level objects are not allowed.

```scala
final def parse(facade: Visitor[_, J]): J = ...
```

```scala
def visitFloat64StringPartsWithWrapper(facade: Visitor[_, J],
                                         decIndex: Int,
                                         expIndex: Int,
                                         i: Int,
                                         j: Int) = ...
```

```scala
def reject(j: Int): PartialFunction[Throwable, Nothing] = ...
```

```scala
def dieWithFailureMessage(i: Int, state: Int) = ...
```

```scala
def failIfNotData(state: Int, i: Int) = ...
```

```scala
def tryCloseCollection(stackHead: ObjArrVisitor[_, J], stackTail: List[ObjArrVisitor[_, J]], i: Int) = ...
```

```scala
def collectionEndFor(stackHead: ObjArrVisitor[_, _]) = ...
```

```scala
def parseStringToOutputBuilder(i: Int, k: Int) = ...
```

```scala
def visitString(i: Int, s: CharSequence, stackHead: ObjArrVisitor[_, J]) = ...
```

```scala
def visitStringKey(i: Int, s: CharSequence, stackHead: ObjArrVisitor[_, J]) = ...
```

#### `CharParser.scala`

> A specialized JSON parse that can parse Chars (Chars or Bytes), sending
> method calls to the given [[upickle.core.Visitor]].
>
> Generally has a lot of tricks for performance: e.g. having duplicate
> implementations for nested v.s. top-level parsing, using an `CharBuilder`
> to construct the `CharSequences` that `visitString` requires, etc.

```scala
abstract class CharParser[J] extends upickle.core.BufferingCharParser
```

> A fast-path to check whether an index can be safely accessed, before calling
> [[getCharUnsafe]]. Together, it is similar to calling [[getCharSafe]], except
> this returns the new safeIndex which the caller can then use to call
> [[getCharUnsafe]] multiple times before needing to call this again.

```scala
def requestUntilOrThrow(j: Int): Unit = ...
```

```scala
def checkSafeIndex(j: Int): Int = ...
```

```scala
override def getCharSafe(i: Int): Char = ...
```

> Parse the JSON document into a single JSON value.
>
> The parser considers documents like '333', 'true', and '"foo"' to be
> valid, as well as more traditional documents like [1,2,3,4,5]. However,
> multiple top-level objects are not allowed.

```scala
final def parse(facade: Visitor[_, J]): J = ...
```

```scala
def visitFloat64StringPartsWithWrapper(facade: Visitor[_, J],
                                         decIndex: Int,
                                         expIndex: Int,
                                         i: Int,
                                         j: Int) = ...
```

```scala
def reject(j: Int): PartialFunction[Throwable, Nothing] = ...
```

```scala
def dieWithFailureMessage(i: Int, state: Int) = ...
```

```scala
def failIfNotData(state: Int, i: Int) = ...
```

```scala
def tryCloseCollection(stackHead: ObjArrVisitor[_, J], stackTail: List[ObjArrVisitor[_, J]], i: Int) = ...
```

```scala
def collectionEndFor(stackHead: ObjArrVisitor[_, _]) = ...
```

```scala
def parseStringToOutputBuilder(i: Int, k: Int) = ...
```

```scala
def visitString(i: Int, s: CharSequence, stackHead: ObjArrVisitor[_, J]) = ...
```

```scala
def visitStringKey(i: Int, s: CharSequence, stackHead: ObjArrVisitor[_, J]) = ...
```

#### `DoubleToDecimalByte.java`

> This class exposes a method to render a {@code double} as a string.
>
> @author Raffaello Giulietti

```java
final public class DoubleToDecimalByte
```

```java
static final int P = ...
```

```java
static final int Q_MIN = ...
```

```java
static final int Q_MAX = ...
```

```java
static final int E_MIN = ...
```

```java
static final int E_MAX = ...
```

```java
static final long C_TINY = ...
```

```java
static final int K_MIN = ...
```

```java
static final int K_MAX = ...
```

```java
static final int H = ...
```

```java
public final int MAX_CHARS = ...
```

> Returns a string rendering of the {@code double} argument.
>
> <p>The characters of the result are all drawn from the ASCII set.
> <ul>
> <li> Any NaN, whether quiet or signaling, is rendered as
> {@code "NaN"}, regardless of the sign bit.
> <li> The infinities +∞ and -∞ are rendered as
> {@code "Infinity"} and {@code "-Infinity"}, respectively.
> <li> The positive and negative zeroes are rendered as
> {@code "0.0"} and {@code "-0.0"}, respectively.
> <li> A finite negative {@code v} is rendered as the sign
> '{@code -}' followed by the rendering of the magnitude -{@code v}.
> <li> A finite positive {@code v} is rendered in two stages:
> <ul>
> <li> <em>Selection of a decimal</em>: A well-defined
> decimal <i>d</i><sub><code>v</code></sub> is selected
> to represent {@code v}.
> <li> <em>Formatting as a string</em>: The decimal
> <i>d</i><sub><code>v</code></sub> is formatted as a string,
> either in plain or in computerized scientific notation,
> depending on its value.
> </ul>
> </ul>
>
> <p>A <em>decimal</em> is a number of the form
> <i>d</i>×10<sup><i>i</i></sup>
> for some (unique) integers <i>d</i> > 0 and <i>i</i> such that
> <i>d</i> is not a multiple of 10.
> These integers are the <em>significand</em> and
> the <em>exponent</em>, respectively, of the decimal.
> The <em>length</em> of the decimal is the (unique)
> integer <i>n</i> meeting
> 10<sup><i>n</i>-1</sup> ≤ <i>d</i> < 10<sup><i>n</i></sup>.
>
> <p>The decimal <i>d</i><sub><code>v</code></sub>
> for a finite positive {@code v} is defined as follows:
> <ul>
> <li>Let <i>R</i> be the set of all decimals that round to {@code v}
> according to the usual round-to-closest rule of
> IEEE 754 floating-point arithmetic.
> <li>Let <i>m</i> be the minimal length over all decimals in <i>R</i>.
> <li>When <i>m</i> ≥ 2, let <i>T</i> be the set of all decimals
> in <i>R</i> with length <i>m</i>.
> Otherwise, let <i>T</i> be the set of all decimals
> in <i>R</i> with length 1 or 2.
> <li>Define <i>d</i><sub><code>v</code></sub> as
> the decimal in <i>T</i> that is closest to {@code v}.
> Or if there are two such decimals in <i>T</i>,
> select the one with the even significand (there is exactly one).
> </ul>
>
> <p>The (uniquely) selected decimal <i>d</i><sub><code>v</code></sub>
> is then formatted.
>
> <p>Let <i>d</i>, <i>i</i> and <i>n</i> be the significand, exponent and
> length of <i>d</i><sub><code>v</code></sub>, respectively.
> Further, let <i>e</i> = <i>n</i> + <i>i</i> - 1 and let
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>
> be the usual decimal expansion of the significand.
> Note that <i>d</i><sub>1</sub> ≠ 0 ≠ <i>d</i><sub><i>n</i></sub>.
> <ul>
> <li>Case -3 ≤ <i>e</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <code>0.0</code>…<code>0</code><!--
> --><i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>,
> where there are exactly -(<i>n</i> + <i>i</i>) zeroes between
> the decimal point and <i>d</i><sub>1</sub>.
> For example, 123 × 10<sup>-4</sup> is formatted as
> {@code 0.0123}.
> <li>Case 0 ≤ <i>e</i> < 7:
> <ul>
> <li>Subcase <i>i</i> ≥ 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub><!--
> --><code>0</code>…<code>0.0</code>,
> where there are exactly <i>i</i> zeroes
> between <i>d</i><sub><i>n</i></sub> and the decimal point.
> For example, 123 × 10<sup>2</sup> is formatted as
> {@code 12300.0}.
> <li>Subcase <i>i</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<!--
> --><i>d</i><sub><i>n</i>+<i>i</i></sub>.<!--
> --><i>d</i><sub><i>n</i>+<i>i</i>+1</sub>…<!--
> --><i>d</i><sub><i>n</i></sub>.
> There are exactly -<i>i</i> digits to the right of
> the decimal point.
> For example, 123 × 10<sup>-1</sup> is formatted as
> {@code 12.3}.
> </ul>
> <li>Case <i>e</i> < -3 or <i>e</i> ≥ 7:
> computerized scientific notation is used to format
> <i>d</i><sub><code>v</code></sub>.
> Here <i>e</i> is formatted as by {@link Integer#toString(int)}.
> <ul>
> <li>Subcase <i>n</i> = 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.0E</code><i>e</i>.
> For example, 1 × 10<sup>23</sup> is formatted as
> {@code 1.0E23}.
> <li>Subcase <i>n</i> > 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.</code><i>d</i><sub>2</sub><!--
> -->…<i>d</i><sub><i>n</i></sub><code>E</code><i>e</i>.
> For example, 123 × 10<sup>-21</sup> is formatted as
> {@code 1.23E-19}.
> </ul>
> </ul>
>
> @param v the {@code double} to be rendered.
> @return a string rendering of the argument.

```java
public static int toString(byte[] bytes, int index, double v)
```

#### `DoubleToDecimalChar.java`

> This class exposes a method to render a {@code double} as a string.
>
> @author Raffaello Giulietti

```java
final public class DoubleToDecimalChar
```

```java
static final int P = ...
```

```java
static final int Q_MIN = ...
```

```java
static final int Q_MAX = ...
```

```java
static final int E_MIN = ...
```

```java
static final int E_MAX = ...
```

```java
static final long C_TINY = ...
```

```java
static final int K_MIN = ...
```

```java
static final int K_MAX = ...
```

```java
static final int H = ...
```

```java
public final int MAX_CHARS = ...
```

> Returns a string rendering of the {@code double} argument.
>
> <p>The characters of the result are all drawn from the ASCII set.
> <ul>
> <li> Any NaN, whether quiet or signaling, is rendered as
> {@code "NaN"}, regardless of the sign bit.
> <li> The infinities +∞ and -∞ are rendered as
> {@code "Infinity"} and {@code "-Infinity"}, respectively.
> <li> The positive and negative zeroes are rendered as
> {@code "0.0"} and {@code "-0.0"}, respectively.
> <li> A finite negative {@code v} is rendered as the sign
> '{@code -}' followed by the rendering of the magnitude -{@code v}.
> <li> A finite positive {@code v} is rendered in two stages:
> <ul>
> <li> <em>Selection of a decimal</em>: A well-defined
> decimal <i>d</i><sub><code>v</code></sub> is selected
> to represent {@code v}.
> <li> <em>Formatting as a string</em>: The decimal
> <i>d</i><sub><code>v</code></sub> is formatted as a string,
> either in plain or in computerized scientific notation,
> depending on its value.
> </ul>
> </ul>
>
> <p>A <em>decimal</em> is a number of the form
> <i>d</i>×10<sup><i>i</i></sup>
> for some (unique) integers <i>d</i> > 0 and <i>i</i> such that
> <i>d</i> is not a multiple of 10.
> These integers are the <em>significand</em> and
> the <em>exponent</em>, respectively, of the decimal.
> The <em>length</em> of the decimal is the (unique)
> integer <i>n</i> meeting
> 10<sup><i>n</i>-1</sup> ≤ <i>d</i> < 10<sup><i>n</i></sup>.
>
> <p>The decimal <i>d</i><sub><code>v</code></sub>
> for a finite positive {@code v} is defined as follows:
> <ul>
> <li>Let <i>R</i> be the set of all decimals that round to {@code v}
> according to the usual round-to-closest rule of
> IEEE 754 floating-point arithmetic.
> <li>Let <i>m</i> be the minimal length over all decimals in <i>R</i>.
> <li>When <i>m</i> ≥ 2, let <i>T</i> be the set of all decimals
> in <i>R</i> with length <i>m</i>.
> Otherwise, let <i>T</i> be the set of all decimals
> in <i>R</i> with length 1 or 2.
> <li>Define <i>d</i><sub><code>v</code></sub> as
> the decimal in <i>T</i> that is closest to {@code v}.
> Or if there are two such decimals in <i>T</i>,
> select the one with the even significand (there is exactly one).
> </ul>
>
> <p>The (uniquely) selected decimal <i>d</i><sub><code>v</code></sub>
> is then formatted.
>
> <p>Let <i>d</i>, <i>i</i> and <i>n</i> be the significand, exponent and
> length of <i>d</i><sub><code>v</code></sub>, respectively.
> Further, let <i>e</i> = <i>n</i> + <i>i</i> - 1 and let
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>
> be the usual decimal expansion of the significand.
> Note that <i>d</i><sub>1</sub> ≠ 0 ≠ <i>d</i><sub><i>n</i></sub>.
> <ul>
> <li>Case -3 ≤ <i>e</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <code>0.0</code>…<code>0</code><!--
> --><i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>,
> where there are exactly -(<i>n</i> + <i>i</i>) zeroes between
> the decimal point and <i>d</i><sub>1</sub>.
> For example, 123 × 10<sup>-4</sup> is formatted as
> {@code 0.0123}.
> <li>Case 0 ≤ <i>e</i> < 7:
> <ul>
> <li>Subcase <i>i</i> ≥ 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub><!--
> --><code>0</code>…<code>0.0</code>,
> where there are exactly <i>i</i> zeroes
> between <i>d</i><sub><i>n</i></sub> and the decimal point.
> For example, 123 × 10<sup>2</sup> is formatted as
> {@code 12300.0}.
> <li>Subcase <i>i</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<!--
> --><i>d</i><sub><i>n</i>+<i>i</i></sub>.<!--
> --><i>d</i><sub><i>n</i>+<i>i</i>+1</sub>…<!--
> --><i>d</i><sub><i>n</i></sub>.
> There are exactly -<i>i</i> digits to the right of
> the decimal point.
> For example, 123 × 10<sup>-1</sup> is formatted as
> {@code 12.3}.
> </ul>
> <li>Case <i>e</i> < -3 or <i>e</i> ≥ 7:
> computerized scientific notation is used to format
> <i>d</i><sub><code>v</code></sub>.
> Here <i>e</i> is formatted as by {@link Integer#toString(int)}.
> <ul>
> <li>Subcase <i>n</i> = 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.0E</code><i>e</i>.
> For example, 1 × 10<sup>23</sup> is formatted as
> {@code 1.0E23}.
> <li>Subcase <i>n</i> > 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.</code><i>d</i><sub>2</sub><!--
> -->…<i>d</i><sub><i>n</i></sub><code>E</code><i>e</i>.
> For example, 123 × 10<sup>-21</sup> is formatted as
> {@code 1.23E-19}.
> </ul>
> </ul>
>
> @param v the {@code double} to be rendered.
> @return a string rendering of the argument.

```java
public static int toString(char[] bytes, int index, double v)
```

#### `FloatToDecimalByte.java`

> This class exposes a method to render a {@code float} as a string.
>
> @author Raffaello Giulietti

```java
final public class FloatToDecimalByte
```

```java
static final int P = ...
```

```java
static final int Q_MIN = ...
```

```java
static final int Q_MAX = ...
```

```java
static final int E_MIN = ...
```

```java
static final int E_MAX = ...
```

```java
static final int C_TINY = ...
```

```java
static final int K_MIN = ...
```

```java
static final int K_MAX = ...
```

```java
static final int H = ...
```

```java
public final int MAX_CHARS = ...
```

> Returns a string rendering of the {@code float} argument.
>
> <p>The characters of the result are all drawn from the ASCII set.
> <ul>
> <li> Any NaN, whether quiet or signaling, is rendered as
> {@code "NaN"}, regardless of the sign bit.
> <li> The infinities +∞ and -∞ are rendered as
> {@code "Infinity"} and {@code "-Infinity"}, respectively.
> <li> The positive and negative zeroes are rendered as
> {@code "0.0"} and {@code "-0.0"}, respectively.
> <li> A finite negative {@code v} is rendered as the sign
> '{@code -}' followed by the rendering of the magnitude -{@code v}.
> <li> A finite positive {@code v} is rendered in two stages:
> <ul>
> <li> <em>Selection of a decimal</em>: A well-defined
> decimal <i>d</i><sub><code>v</code></sub> is selected
> to represent {@code v}.
> <li> <em>Formatting as a string</em>: The decimal
> <i>d</i><sub><code>v</code></sub> is formatted as a string,
> either in plain or in computerized scientific notation,
> depending on its value.
> </ul>
> </ul>
>
> <p>A <em>decimal</em> is a number of the form
> <i>d</i>×10<sup><i>i</i></sup>
> for some (unique) integers <i>d</i> > 0 and <i>i</i> such that
> <i>d</i> is not a multiple of 10.
> These integers are the <em>significand</em> and
> the <em>exponent</em>, respectively, of the decimal.
> The <em>length</em> of the decimal is the (unique)
> integer <i>n</i> meeting
> 10<sup><i>n</i>-1</sup> ≤ <i>d</i> < 10<sup><i>n</i></sup>.
>
> <p>The decimal <i>d</i><sub><code>v</code></sub>
> for a finite positive {@code v} is defined as follows:
> <ul>
> <li>Let <i>R</i> be the set of all decimals that round to {@code v}
> according to the usual round-to-closest rule of
> IEEE 754 floating-point arithmetic.
> <li>Let <i>m</i> be the minimal length over all decimals in <i>R</i>.
> <li>When <i>m</i> ≥ 2, let <i>T</i> be the set of all decimals
> in <i>R</i> with length <i>m</i>.
> Otherwise, let <i>T</i> be the set of all decimals
> in <i>R</i> with length 1 or 2.
> <li>Define <i>d</i><sub><code>v</code></sub> as
> the decimal in <i>T</i> that is closest to {@code v}.
> Or if there are two such decimals in <i>T</i>,
> select the one with the even significand (there is exactly one).
> </ul>
>
> <p>The (uniquely) selected decimal <i>d</i><sub><code>v</code></sub>
> is then formatted.
>
> <p>Let <i>d</i>, <i>i</i> and <i>n</i> be the significand, exponent and
> length of <i>d</i><sub><code>v</code></sub>, respectively.
> Further, let <i>e</i> = <i>n</i> + <i>i</i> - 1 and let
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>
> be the usual decimal expansion of the significand.
> Note that <i>d</i><sub>1</sub> ≠ 0 ≠ <i>d</i><sub><i>n</i></sub>.
> <ul>
> <li>Case -3 ≤ <i>e</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <code>0.0</code>…<code>0</code><!--
> --><i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>,
> where there are exactly -(<i>n</i> + <i>i</i>) zeroes between
> the decimal point and <i>d</i><sub>1</sub>.
> For example, 123 × 10<sup>-4</sup> is formatted as
> {@code 0.0123}.
> <li>Case 0 ≤ <i>e</i> < 7:
> <ul>
> <li>Subcase <i>i</i> ≥ 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub><!--
> --><code>0</code>…<code>0.0</code>,
> where there are exactly <i>i</i> zeroes
> between <i>d</i><sub><i>n</i></sub> and the decimal point.
> For example, 123 × 10<sup>2</sup> is formatted as
> {@code 12300.0}.
> <li>Subcase <i>i</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<!--
> --><i>d</i><sub><i>n</i>+<i>i</i></sub>.<!--
> --><i>d</i><sub><i>n</i>+<i>i</i>+1</sub>…<!--
> --><i>d</i><sub><i>n</i></sub>.
> There are exactly -<i>i</i> digits to the right of
> the decimal point.
> For example, 123 × 10<sup>-1</sup> is formatted as
> {@code 12.3}.
> </ul>
> <li>Case <i>e</i> < -3 or <i>e</i> ≥ 7:
> computerized scientific notation is used to format
> <i>d</i><sub><code>v</code></sub>.
> Here <i>e</i> is formatted as by {@link Integer#toString(int)}.
> <ul>
> <li>Subcase <i>n</i> = 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.0E</code><i>e</i>.
> For example, 1 × 10<sup>23</sup> is formatted as
> {@code 1.0E23}.
> <li>Subcase <i>n</i> > 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.</code><i>d</i><sub>2</sub><!--
> -->…<i>d</i><sub><i>n</i></sub><code>E</code><i>e</i>.
> For example, 123 × 10<sup>-21</sup> is formatted as
> {@code 1.23E-19}.
> </ul>
> </ul>
>
> @param  v the {@code float} to be rendered.
> @return a string rendering of the argument.

```java
public static int toString(byte[] bytes, int offset, float v)
```

#### `FloatToDecimalChar.java`

> This class exposes a method to render a {@code float} as a string.
>
> @author Raffaello Giulietti

```java
final public class FloatToDecimalChar
```

```java
static final int P = ...
```

```java
static final int Q_MIN = ...
```

```java
static final int Q_MAX = ...
```

```java
static final int E_MIN = ...
```

```java
static final int E_MAX = ...
```

```java
static final int C_TINY = ...
```

```java
static final int K_MIN = ...
```

```java
static final int K_MAX = ...
```

```java
static final int H = ...
```

```java
public final int MAX_CHARS = ...
```

> Returns a string rendering of the {@code float} argument.
>
> <p>The characters of the result are all drawn from the ASCII set.
> <ul>
> <li> Any NaN, whether quiet or signaling, is rendered as
> {@code "NaN"}, regardless of the sign bit.
> <li> The infinities +∞ and -∞ are rendered as
> {@code "Infinity"} and {@code "-Infinity"}, respectively.
> <li> The positive and negative zeroes are rendered as
> {@code "0.0"} and {@code "-0.0"}, respectively.
> <li> A finite negative {@code v} is rendered as the sign
> '{@code -}' followed by the rendering of the magnitude -{@code v}.
> <li> A finite positive {@code v} is rendered in two stages:
> <ul>
> <li> <em>Selection of a decimal</em>: A well-defined
> decimal <i>d</i><sub><code>v</code></sub> is selected
> to represent {@code v}.
> <li> <em>Formatting as a string</em>: The decimal
> <i>d</i><sub><code>v</code></sub> is formatted as a string,
> either in plain or in computerized scientific notation,
> depending on its value.
> </ul>
> </ul>
>
> <p>A <em>decimal</em> is a number of the form
> <i>d</i>×10<sup><i>i</i></sup>
> for some (unique) integers <i>d</i> > 0 and <i>i</i> such that
> <i>d</i> is not a multiple of 10.
> These integers are the <em>significand</em> and
> the <em>exponent</em>, respectively, of the decimal.
> The <em>length</em> of the decimal is the (unique)
> integer <i>n</i> meeting
> 10<sup><i>n</i>-1</sup> ≤ <i>d</i> < 10<sup><i>n</i></sup>.
>
> <p>The decimal <i>d</i><sub><code>v</code></sub>
> for a finite positive {@code v} is defined as follows:
> <ul>
> <li>Let <i>R</i> be the set of all decimals that round to {@code v}
> according to the usual round-to-closest rule of
> IEEE 754 floating-point arithmetic.
> <li>Let <i>m</i> be the minimal length over all decimals in <i>R</i>.
> <li>When <i>m</i> ≥ 2, let <i>T</i> be the set of all decimals
> in <i>R</i> with length <i>m</i>.
> Otherwise, let <i>T</i> be the set of all decimals
> in <i>R</i> with length 1 or 2.
> <li>Define <i>d</i><sub><code>v</code></sub> as
> the decimal in <i>T</i> that is closest to {@code v}.
> Or if there are two such decimals in <i>T</i>,
> select the one with the even significand (there is exactly one).
> </ul>
>
> <p>The (uniquely) selected decimal <i>d</i><sub><code>v</code></sub>
> is then formatted.
>
> <p>Let <i>d</i>, <i>i</i> and <i>n</i> be the significand, exponent and
> length of <i>d</i><sub><code>v</code></sub>, respectively.
> Further, let <i>e</i> = <i>n</i> + <i>i</i> - 1 and let
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>
> be the usual decimal expansion of the significand.
> Note that <i>d</i><sub>1</sub> ≠ 0 ≠ <i>d</i><sub><i>n</i></sub>.
> <ul>
> <li>Case -3 ≤ <i>e</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <code>0.0</code>…<code>0</code><!--
> --><i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub>,
> where there are exactly -(<i>n</i> + <i>i</i>) zeroes between
> the decimal point and <i>d</i><sub>1</sub>.
> For example, 123 × 10<sup>-4</sup> is formatted as
> {@code 0.0123}.
> <li>Case 0 ≤ <i>e</i> < 7:
> <ul>
> <li>Subcase <i>i</i> ≥ 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<i>d</i><sub><i>n</i></sub><!--
> --><code>0</code>…<code>0.0</code>,
> where there are exactly <i>i</i> zeroes
> between <i>d</i><sub><i>n</i></sub> and the decimal point.
> For example, 123 × 10<sup>2</sup> is formatted as
> {@code 12300.0}.
> <li>Subcase <i>i</i> < 0:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub>…<!--
> --><i>d</i><sub><i>n</i>+<i>i</i></sub>.<!--
> --><i>d</i><sub><i>n</i>+<i>i</i>+1</sub>…<!--
> --><i>d</i><sub><i>n</i></sub>.
> There are exactly -<i>i</i> digits to the right of
> the decimal point.
> For example, 123 × 10<sup>-1</sup> is formatted as
> {@code 12.3}.
> </ul>
> <li>Case <i>e</i> < -3 or <i>e</i> ≥ 7:
> computerized scientific notation is used to format
> <i>d</i><sub><code>v</code></sub>.
> Here <i>e</i> is formatted as by {@link Integer#toString(int)}.
> <ul>
> <li>Subcase <i>n</i> = 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.0E</code><i>e</i>.
> For example, 1 × 10<sup>23</sup> is formatted as
> {@code 1.0E23}.
> <li>Subcase <i>n</i> > 1:
> <i>d</i><sub><code>v</code></sub> is formatted as
> <i>d</i><sub>1</sub><code>.</code><i>d</i><sub>2</sub><!--
> -->…<i>d</i><sub><i>n</i></sub><code>E</code><i>e</i>.
> For example, 123 × 10<sup>-21</sup> is formatted as
> {@code 1.23E-19}.
> </ul>
> </ul>
>
> @param  v the {@code float} to be rendered.
> @return a string rendering of the argument.

```java
public static int toString(char[] bytes, int offset, float v)
```

#### `ujson/AstTransformer.scala`

```scala
trait AstTransformer[I] extends ujson.Transformer[I] with JsVisitor[I, I]
```

```scala
def apply(t: Readable): I = ...
```

```scala
def transformArray[T](f: Visitor[_, T], items: Iterable[I]) = ...
```

```scala
def transformObject[T](f: Visitor[_, T], items: Iterable[(String, I)]) = ...
```

```scala
class AstObjVisitor[T](build: T => I)
```

```scala
def subVisitor = ...
```

```scala
def visitKey(index: Int) = ...
```

```scala
def visitKeyValue(s: Any): Unit = ...
```

```scala
def visitValue(v: I, index: Int): Unit = ...
```

```scala
def visitEnd(index: Int) = ...
```

```scala
class AstArrVisitor[T[_]](build: T[I] => I)
```

```scala
def subVisitor = ...
```

```scala
def visitValue(v: I, index: Int): Unit = ...
```

```scala
def visitEnd(index: Int) = ...
```

#### `ujson/ByteArrayParser.scala`

> Basic ByteBuffer parser.
>
> This assumes that the provided ByteBuffer is ready to be read. The
> user is responsible for any necessary flipping/resetting of the
> ByteBuffer before parsing.
>
> The parser makes absolute calls to the ByteBuffer, which will not
> update its own mutable position fields.

```scala
final class ByteArrayParser[J](src: Array[Byte]) extends ByteParser[J]
```

```scala
val srcLength = ...
```

```scala
override def growBuffer(until: Int): Unit = ...
```

```scala
def readDataIntoBuffer(buffer: Array[Byte], bufferOffset: Int) = ...
```

```scala
object ByteArrayParser extends Transformer[Array[Byte]]
```

```scala
def transform[T](j: Array[Byte], f: Visitor[_, T]) = ...
```

#### `ujson/ByteBufferParser.scala`

> Basic ByteBuffer parser.
>
> This assumes that the provided ByteBuffer is ready to be read. The
> user is responsible for any necessary flipping/resetting of the
> ByteBuffer before parsing.
>
> The parser makes absolute calls to the ByteBuffer, which will not
> update its own mutable position fields.

```scala
final class ByteBufferParser[J](src: ByteBuffer) extends ByteParser[J]
```

```scala
override def growBuffer(until: Int): Unit = ...
```

```scala
def readDataIntoBuffer(buffer: Array[Byte], bufferOffset: Int) = ...
```

```scala
object ByteBufferParser extends Transformer[ByteBuffer]
```

```scala
def transform[T](j: ByteBuffer, f: Visitor[_, T]) = ...
```

#### `ujson/CharSequenceParser.scala`

```scala
object CharSequenceParser extends Transformer[CharSequence]
```

```scala
def transform[T](j: CharSequence, f: Visitor[_, T]) = ...
```

#### `ujson/Exceptions.scala`

```scala
sealed trait ParsingFailedException extends Exception
```

```scala
case class ParseException(clue: String, index: Int)
```

```scala
case class IncompleteParseException(msg: String)
```

#### `ujson/IndexedValue.scala`

> A version of [[ujson.Value]] that keeps the index positions of the various AST
> nodes it is constructing. Usually not necessary, but sometimes useful if you
> want to work with an AST but still provide source-index error positions if
> something goes wrong

```scala
@deprecated("Left for binary compatibility, use upickle.core.BufferedValue instead", "upickle after 3.1.4")
sealed trait IndexedValue
```

```scala
def index: Int
```

```scala
@deprecated("Left for binary compatibility, use upickle.core.BufferedValue instead", "upickle after 3.1.4")
object IndexedValue extends Transformer[IndexedValue]
```

```scala
case class Str(index: Int, value0: java.lang.CharSequence) extends IndexedValue
```

```scala
case class Obj(index: Int, value0: (java.lang.CharSequence, IndexedValue)*) extends IndexedValue
```

```scala
case class Arr(index: Int, value: IndexedValue*) extends IndexedValue
```

```scala
case class Num(index: Int, s: CharSequence, decIndex: Int, expIndex: Int) extends IndexedValue
```

```scala
case class NumRaw(index: Int, d: Double) extends IndexedValue
```

```scala
case class False(index: Int) extends IndexedValue
```

```scala
def value = ...
```

```scala
case class True(index: Int) extends IndexedValue
```

```scala
def value = ...
```

```scala
case class Null(index: Int) extends IndexedValue
```

```scala
def value = ...
```

```scala
def transform[T](j: IndexedValue, f: Visitor[_, T]): T = ...
```

```scala
object Builder extends JsVisitor[IndexedValue, IndexedValue]
```

```scala
def visitArray(length: Int, i: Int) = ...
```

```scala
def visitJsonableObject(length: Int, i: Int) = ...
```

```scala
def visitNull(i: Int) = ...
```

```scala
def visitFalse(i: Int) = ...
```

```scala
def visitTrue(i: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, i: Int) = ...
```

```scala
override def visitFloat64(d: Double, i: Int) = ...
```

```scala
def visitString(s: CharSequence, i: Int) = ...
```

#### `ujson/InputStreamParser.scala`

> Parser that reads in bytes from an InputStream, buffering them in memory
> until a `reset` call discards them.
>
> Mostly the same as ByteArrayParser, except using an UberBuffer rather than
> reading directly from an Array[Byte].
>
> Generally not meant to be used directly, but via [[ujson.Readable.fromReadable]]

```scala
final class InputStreamParser[J](val inputStream: java.io.InputStream,
                                 val minBufferStartSize: Int = BufferingInputStreamParser.defaultMinBufferStartSize,
                                 val maxBufferStartSize: Int = BufferingInputStreamParser.defaultMaxBufferStartSize)
```

```scala
object InputStreamParser extends Transformer[java.io.InputStream]
```

```scala
def transform[T](j: java.io.InputStream, f: Visitor[_, T]) = ...
```

#### `ujson/JsVisitor.scala`

> A [[Visitor]] specialized to work with JSON types. Forwards the
> not-JSON-related methods to their JSON equivalents.

```scala
trait JsVisitor[-T, +J] extends Visitor[T, J]
```

```scala
def visitFloat64(d: Double, index: Int): J = ...
```

```scala
def visitFloat32(d: Float, index: Int): J = ...
```

```scala
def visitInt32(i: Int, index: Int): J = ...
```

```scala
def visitInt64(i: Long, index: Int): J = ...
```

```scala
def visitUInt64(i: Long, index: Int): J = ...
```

```scala
def visitFloat64String(s: String, index: Int): J = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int): J = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int): J = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int): J = ...
```

```scala
def visitChar(s: Char, index: Int) = ...
```

```scala
def visitJsonableObject(length: Int, index: Int): ObjVisitor[T, J]
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

#### `ujson/MathUtils.java`

> This class exposes package private utilities for other classes.
> Thus, all methods are assumed to be invoked with correct arguments,
> so these are not checked at all.
>
> @author Raffaello Giulietti

```java
final class MathUtils
```

```java
static final int K_MIN = ...
```

```java
static final int K_MAX = ...
```

```java
static final int H = ...
```

> Returns 10<sup>{@code e}</sup>.
>
> @param e The exponent which must meet
> 0 ≤ {@code e} ≤ {@link #H}.
> @return 10<sup>{@code e}</sup>.

```java
static long pow10(int e)
```

> Returns the unique integer <i>k</i> such that
> 10<sup><i>k</i></sup> ≤ 2<sup>{@code e}</sup>
> < 10<sup><i>k</i>+1</sup>.
> <p>
> The result is correct when |{@code e}| ≤ 5_456_721.
> Otherwise the result is undefined.
>
> @param e The exponent of 2, which should meet
> |{@code e}| ≤ 5_456_721 for safe results.
> @return ⌊log<sub>10</sub>2<sup>{@code e}</sup>⌋.

```java
static int flog10pow2(int e)
```

> Returns the unique integer <i>k</i> such that
> 10<sup><i>k</i></sup> ≤ 3/4 · 2<sup>{@code e}</sup>
> < 10<sup><i>k</i>+1</sup>.
> <p>
> The result is correct when
> -2_956_395 ≤ {@code e} ≤ 2_500_325.
> Otherwise the result is undefined.
>
> @param e The exponent of 2, which should meet
> -2_956_395 ≤ {@code e} ≤ 2_500_325 for safe results.
> @return ⌊log<sub>10</sub>(3/4 ·
> 2<sup>{@code e}</sup>)⌋.

```java
static int flog10threeQuartersPow2(int e)
```

> Returns the unique integer <i>k</i> such that
> 2<sup><i>k</i></sup> ≤ 10<sup>{@code e}</sup>
> < 2<sup><i>k</i>+1</sup>.
> <p>
> The result is correct when |{@code e}| ≤ 1_838_394.
> Otherwise the result is undefined.
>
> @param e The exponent of 10, which should meet
> |{@code e}| ≤ 1_838_394 for safe results.
> @return ⌊log<sub>2</sub>10<sup>{@code e}</sup>⌋.

```java
static int flog2pow10(int e)
```

> Let 10<sup>-{@code k}</sup> = <i>β</i> 2<sup><i>r</i></sup>,
> for the unique pair of integer <i>r</i> and real <i>β</i> meeting
> 2<sup>125</sup> ≤ <i>β</i> < 2<sup>126</sup>.
> Further, let <i>g</i> = ⌊<i>β</i>⌋ + 1.
> Split <i>g</i> into the higher 63 bits <i>g</i><sub>1</sub> and
> the lower 63 bits <i>g</i><sub>0</sub>. Thus,
> <i>g</i><sub>1</sub> =
> ⌊<i>g</i> 2<sup>-63</sup>⌋
> and
> <i>g</i><sub>0</sub> =
> <i>g</i> - <i>g</i><sub>1</sub> 2<sup>63</sup>.
> <p>
> This method returns <i>g</i><sub>1</sub> while
> {@link #g0(int)} returns <i>g</i><sub>0</sub>.
> <p>
> If needed, the exponent <i>r</i> can be computed as
> <i>r</i> = {@code flog2pow10(-k)} - 125 (see {@link #flog2pow10(int)}).
>
> @param k The exponent of 10, which must meet
> {@link #K_MIN} ≤ {@code e} ≤ {@link #K_MAX}.
> @return <i>g</i><sub>1</sub> as described above.

```java
static long g1(int k)
```

> Returns <i>g</i><sub>0</sub> as described in
> {@link #g1(int)}.
>
> @param k The exponent of 10, which must meet
> {@link #K_MIN} ≤ {@code e} ≤ {@link #K_MAX}.
> @return <i>g</i><sub>0</sub> as described in
> {@link #g1(int)}.

```java
static long g0(int k)
```

```java
static long multiplyHigh(long x, long y)
```

#### `ujson/Readable.scala`

```scala
trait Readable
```

```scala
def transform[T](f: Visitor[_, T]): T
```

```scala
object Readable extends ReadableLowPri with Transformer[Readable]
```

```scala
def transform[T](j: ujson.Readable, f: upickle.core.Visitor[_, T]): T = ...
```

```scala
case class fromTransformer[T](t: T, w: Transformer[T]) extends Readable
```

```scala
def transform[T](f: Visitor[_, T]): T = ...
```

```scala
implicit def fromString(s: String): fromTransformer[String] = ...
```

```scala
implicit def fromCharSequence(s: CharSequence): fromTransformer[CharSequence] = ...
```

```scala
implicit def fromPath(s: java.nio.file.Path): Readable = ...
```

```scala
implicit def fromFile(s: java.io.File): Readable = ...
```

```scala
implicit def fromByteBuffer(s: ByteBuffer): fromTransformer[ByteBuffer] = ...
```

```scala
implicit def fromByteArray(s: Array[Byte]): fromTransformer[Array[Byte]] = ...
```

```scala
trait ReadableLowPri
```

```scala
implicit def fromReadable[T](s: T)(implicit conv: T => geny.Readable): Readable = ...
```

#### `ujson/Renderer.scala`

```scala
case class BytesRenderer(indent: Int = -1, escapeUnicode: Boolean = false)
```

```scala
case class StringRenderer(indent: Int = -1,
                          escapeUnicode: Boolean = false)
```

```scala
case class Renderer(out: java.io.Writer,
                    indent: Int = -1,
                    escapeUnicode: Boolean = false)
```

#### `ujson/StringParser.scala`

```scala
object StringParser extends Transformer[String]
```

```scala
def transform[T](j: String, f: Visitor[_, T]) = ...
```

#### `ujson/Transformer.scala`

```scala
trait Transformer[I] extends upickle.core.Transformer[I]
```

```scala
def transformable[T](j: I) = ...
```

#### `ujson/Value.scala`

```scala
sealed trait Value extends Readable with geny.Writable
```

```scala
override def httpContentType = ...
```

```scala
def value: Any
```

> Returns the `String` value of this [[Value]], fails if it is not
> a [[ujson.Str]]

```scala
def str = ...
```

> Returns an Optional `String` value of this [[Value]] in case this [[Value]] is a 'String'.

```scala
def strOpt = ...
```

> Returns the key/value map of this [[Value]], fails if it is not
> a [[ujson.Obj]]

```scala
def obj = ...
```

> Returns an Optional key/value map of this [[Value]] in case this [[Value]] is a 'Obj'.

```scala
def objOpt = ...
```

> Returns the elements of this [[Value]], fails if it is not
> a [[ujson.Arr]]

```scala
def arr = ...
```

> Returns The optional elements of this [[Value]] in case this [[Value]] is a 'Arr'.

```scala
def arrOpt = ...
```

> Returns the `Double` value of this [[Value]], fails if it is not
> a [[ujson.Num]]

```scala
def num = ...
```

> Returns an Option[Double] in case this [[Value]] is a 'Num'.

```scala
def numOpt = ...
```

> Returns the `Boolean` value of this [[Value]], fails if it is not
> a [[ujson.Bool]]

```scala
def bool = ...
```

> Returns an Optional `Boolean` value of this [[Value]] in case this [[Value]] is a 'Bool'.

```scala
def boolOpt = ...
```

> Returns true if the value of this [[Value]] is ujson.Null, false otherwise

```scala
def isNull = ...
```

```scala
def apply(s: Value.Selector): Value = ...
```

```scala
def update(s: Value.Selector, v: Value): Unit = ...
```

> Update a value in-place. Takes an `Int` or a `String`, through the
> implicitly-constructe [[Value.Selector]] type.
>
> We cannot just overload `update` on `s: Int` and `s: String` because
> of type inference problems in Scala 2.11.

```scala
def update(s: Value.Selector, f: Value => Value): Unit = ...
```

```scala
def transform[T](f: Visitor[_, T]) = ...
```

```scala
override def toString = ...
```

```scala
def render(indent: Int = -1, escapeUnicode: Boolean = false) = ...
```

```scala
def writeBytesTo(out: java.io.OutputStream, indent: Int = -1, escapeUnicode: Boolean = false): Unit = ...
```

```scala
def writeBytesTo(out: java.io.OutputStream): Unit = ...
```

> A very small, very simple JSON AST that uPickle uses as part of its
> serialization process. A common standard between the Jawn AST (which
> we don't use so we don't pull in the bulk of Spire) and the Javascript
> JSON AST.

```scala
object Value extends AstTransformer[Value]
```

```scala
type Value = ...
```

```scala
sealed trait Selector
```

```scala
def apply(x: Value): Value
```

```scala
def update(x: Value, y: Value): Unit
```

```scala
object Selector
```

```scala
implicit class IntSelector(i: Int) extends Selector
```

```scala
def apply(x: Value): Value = ...
```

```scala
def update(x: Value, y: Value) = ...
```

```scala
implicit class StringSelector(i: String) extends Selector
```

```scala
def apply(x: Value): Value = ...
```

```scala
def update(x: Value, y: Value) = ...
```

```scala
implicit def JsonableSeq[T](items: IterableOnce[T])
```

```scala
implicit def JsonableDict[T](items: IterableOnce[(String, T)])
```

```scala
implicit def JsonableBoolean(i: Boolean): Bool = ...
```

```scala
implicit def JsonableByte(i: Byte): Num = ...
```

```scala
implicit def JsonableShort(i: Short): Num = ...
```

```scala
implicit def JsonableInt(i: Int): Num = ...
```

```scala
implicit def JsonableLong(i: Long): Str = ...
```

```scala
implicit def JsonableFloat(i: Float): Num = ...
```

```scala
implicit def JsonableDouble(i: Double): Num = ...
```

```scala
implicit def JsonableNull(i: Null): Null.type = ...
```

```scala
implicit def JsonableString(s: CharSequence): Str = ...
```

```scala
def transform[T](j: Value, f: Visitor[_, T]): T = ...
```

```scala
def visitArray(length: Int, index: Int) = ...
```

```scala
def visitJsonableObject(length: Int, index: Int) = ...
```

```scala
def visitNull(index: Int) = ...
```

```scala
def visitFalse(index: Int) = ...
```

```scala
def visitTrue(index: Int) = ...
```

```scala
override def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
def visitString(s: CharSequence, index: Int) = ...
```

> Thrown when uPickle tries to convert a JSON blob into a given data
> structure but fails because part the blob is invalid
>
> @param data The section of the JSON blob that uPickle tried to convert.
> This could be the entire blob, or it could be some subtree.
> @param msg Human-readable text saying what went wrong

```scala
case class InvalidData(data: Value, msg: String)
```

```scala
case class Str(value: String) extends Value
```

```scala
case class Obj(value: LinkedHashMap[String, Value]) extends Value
```

```scala
object Obj
```

```scala
implicit def from(items: IterableOnce[(String, Value)]): Obj = ...
```

```scala
def apply[V](item: (String, V),
               items: (String, Value)*)(implicit conv: V => Value): Obj = ...
```

```scala
def apply(): Obj = ...
```

```scala
case class Arr(value: mutable.ArrayBuffer[Value]) extends Value
```

```scala
object Arr
```

```scala
implicit def from[T](items: IterableOnce[T])(implicit conv: T => Value): Arr = ...
```

```scala
def apply(items: Value*): Arr = ...
```

```scala
case class Num(value: Double) extends Value
```

```scala
sealed abstract class Bool extends Value
```

```scala
def value: Boolean
```

```scala
object Bool
```

```scala
def apply(value: Boolean): Bool = ...
```

```scala
def unapply(bool: Bool): Some[Boolean] = ...
```

```scala
case object False extends Bool
```

```scala
def value = ...
```

```scala
case object True extends Bool
```

```scala
def value = ...
```

```scala
case object Null extends Value
```

```scala
def value = ...
```

#### `ujson/package.scala`

```scala
package object ujson
```

```scala
def transform[T](t: Readable,
                   v: upickle.core.Visitor[_, T],
                   sortKeys: Boolean = false): T = ...
```

### `com.lihaoyi:upack_3:3.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1/upack_3-3.3.1-sources.jar

#### `upack/Msg.scala`

> In-memory representation of the MessagePack data model
>
> test - https://msgpack.org/index.html
>
> Note that we do not model all the fine details of the MessagePack format
> in this type; fixed and variable length strings/maps/arrays are all
> modelled using the same [[Str]]/[[Obj]]/[[Arr]] types, and the various
> sized integers are all collapsed into [[Int32]]/[[Int64]]/[[UInt64]]. The
> appropriately sized versions are written out when the message is serialized
> to bytes.

```scala
sealed trait Msg extends Readable with geny.Writable
```

```scala
override def httpContentType = ...
```

```scala
def transform[T](f: Visitor[_, T]) = ...
```

> Returns the `String` value of this [[Msg]], fails if it is not
> a [[upack.Str]]

```scala
def binary = ...
```

> Returns the `String` value of this [[Msg]], fails if it is not
> a [[upack.Str]]

```scala
def str = ...
```

> Returns the key/value map of this [[Msg]], fails if it is not
> a [[upack.Obj]]

```scala
def obj = ...
```

> Returns the elements of this [[Msg]], fails if it is not
> a [[upack.Arr]]

```scala
def arr = ...
```

> Returns the `Double` value of this [[Msg]], fails if it is not
> a [[upack.Int32]], [[upack.Int64]] or [[upack.UInt64]]

```scala
def int32 = ...
```

> Returns the `Double` value of this [[Msg]], fails if it is not
> a [[upack.Int32]], [[upack.Int64]] or [[upack.UInt64]]

```scala
def int64 = ...
```

> Returns the `Boolean` value of this [[Msg]], fails if it is not
> a [[upack.Bool]]

```scala
def bool = ...
```

> Returns true if the value of this [[Msg]] is ujson.Null, false otherwise

```scala
def isNull = ...
```

```scala
def writeBytesTo(out: java.io.OutputStream): Unit = ...
```

```scala
case object Null extends Msg
```

```scala
case object True extends Bool
```

```scala
def value = ...
```

```scala
case object False extends Bool
```

```scala
def value = ...
```

```scala
case class Int32(value: Int) extends Msg
```

```scala
case class Int64(value: Long) extends Msg
```

```scala
case class UInt64(value: Long) extends Msg
```

```scala
case class Float32(value: Float) extends Msg
```

```scala
case class Float64(value: Double) extends Msg
```

```scala
case class Str(value: String) extends Msg
```

```scala
case class Binary(value: Array[Byte]) extends Msg
```

```scala
case class Arr(value: mutable.ArrayBuffer[Msg]) extends Msg
```

```scala
object Arr
```

```scala
def apply(items: Msg*): Arr = ...
```

```scala
case class Obj(value: LinkedHashMap[Msg, Msg]) extends Msg
```

```scala
object Obj
```

```scala
def apply(item: (Msg, Msg),
            items: (Msg, Msg)*): Obj = ...
```

```scala
def apply(): Obj = ...
```

```scala
case class Ext(tag: Byte, data: Array[Byte]) extends Msg
```

```scala
sealed abstract class Bool extends Msg
```

```scala
def value: Boolean
```

```scala
object Bool
```

```scala
def apply(value: Boolean): Bool = ...
```

```scala
def unapply(bool: Bool): Some[Boolean] = ...
```

```scala
object Msg extends MsgVisitor[Msg, Msg]
```

> Thrown when uPickle tries to convert a JSON blob into a given data
> structure but fails because part the blob is invalid
>
> @param data The section of the JSON blob that uPickle tried to convert.
> This could be the entire blob, or it could be some subtree.
> @param msg Human-readable text saying what went wrong

```scala
case class InvalidData(data: Msg, msg: String)
```

```scala
sealed trait Selector
```

```scala
def apply(x: Msg): Msg
```

```scala
def update(x: Msg, y: Msg): Unit
```

```scala
object Selector
```

```scala
implicit class IntSelector(i: Int) extends Selector
```

```scala
def apply(x: Msg): Msg = ...
```

```scala
def update(x: Msg, y: Msg) = ...
```

```scala
implicit class StringSelector(i: String) extends Selector
```

```scala
def apply(x: Msg): Msg = ...
```

```scala
def update(x: Msg, y: Msg) = ...
```

```scala
implicit class MsgSelector(i: Msg) extends Selector
```

```scala
def apply(x: Msg): Msg = ...
```

```scala
def update(x: Msg, y: Msg) = ...
```

```scala
def transform[T](j: Msg, f: Visitor[_, T]): T = ...
```

```scala
def visitArray(length: Int, index: Int) = ...
```

```scala
def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
def visitNull(index: Int) = ...
```

```scala
def visitFalse(index: Int) = ...
```

```scala
def visitTrue(index: Int) = ...
```

```scala
def visitFloat64(d: Double, index: Int) = ...
```

```scala
def visitFloat32(d: Float, index: Int) = ...
```

```scala
def visitInt32(i: Int, index: Int) = ...
```

```scala
def visitInt64(i: Long, index: Int) = ...
```

```scala
def visitUInt64(i: Long, index: Int) = ...
```

```scala
def visitString(s: CharSequence, index: Int) = ...
```

```scala
def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitChar(s: Char, index: Int) = ...
```

#### `upack/MsgPackKeys.scala`

```scala
object MsgPackKeys
```

```scala
final val PositiveFixInt = ...
```

```scala
final val FixMapMask = ...
```

```scala
final val FixMap = ...
```

```scala
final val FixArrMask = ...
```

```scala
final val FixArray = ...
```

```scala
final val FixStrMask = ...
```

```scala
final val FixStr = ...
```

```scala
final val Nil = ...
```

```scala
final val False = ...
```

```scala
final val True = ...
```

```scala
final val Bin8 = ...
```

```scala
final val Bin16 = ...
```

```scala
final val Bin32 = ...
```

```scala
final val Ext8 = ...
```

```scala
final val Ext16 = ...
```

```scala
final val Ext32 = ...
```

```scala
final val Float32 = ...
```

```scala
final val Float64 = ...
```

```scala
final val UInt8 = ...
```

```scala
final val UInt16 = ...
```

```scala
final val UInt32 = ...
```

```scala
final val UInt64 = ...
```

```scala
final val Int8 = ...
```

```scala
final val Int16 = ...
```

```scala
final val Int32 = ...
```

```scala
final val Int64 = ...
```

```scala
final val FixExt1 = ...
```

```scala
final val FixExt2 = ...
```

```scala
final val FixExt4 = ...
```

```scala
final val FixExt8 = ...
```

```scala
final val FixExt16 = ...
```

```scala
final val Str8 = ...
```

```scala
final val Str16 = ...
```

```scala
final val Str32 = ...
```

```scala
final val Array16 = ...
```

```scala
final val Array32 = ...
```

```scala
final val Map16 = ...
```

```scala
final val Map32 = ...
```

#### `upack/MsgPackReader.scala`

```scala
class MsgPackReader(input0: Array[Byte]) extends BaseMsgPackReader
```

```scala
val srcLength = ...
```

```scala
override def growBuffer(until: Int): Unit = ...
```

```scala
def readDataIntoBuffer(buffer: Array[Byte], bufferOffset: Int) = ...
```

```scala
class InputStreamMsgPackReader(val inputStream: java.io.InputStream,
                               val minBufferStartSize: Int = BufferingInputStreamParser.defaultMinBufferStartSize,
                               val maxBufferStartSize: Int = BufferingInputStreamParser.defaultMaxBufferStartSize)
```

```scala
abstract class BaseMsgPackReader extends upickle.core.BufferingByteParser
```

```scala
def getIndex = ...
```

```scala
def parse[T](visitor: Visitor[_, T]): T = ...
```

```scala
def parseExt[T](n: Int, visitor: Visitor[_, T]) = ...
```

```scala
def parseStr[T](n: Int, visitor: Visitor[_, T]) = ...
```

```scala
def parseBin[T](n: Int, visitor: Visitor[_, T]) = ...
```

```scala
def parseMap[T](n: Int, visitor: Visitor[_, T]) = ...
```

```scala
def parseArray[T](n: Int, visitor: Visitor[_, T]) = ...
```

```scala
def parseUInt8(i: Int) = ...
```

```scala
def parseUInt16(i: Int) = ...
```

```scala
def parseUInt32(i: Int) = ...
```

```scala
def parseUInt64(i: Int) = ...
```

#### `upack/MsgPackWriter.scala`

```scala
class MsgPackWriter[T <: java.io.OutputStream](out: T = new ByteArrayOutputStream())
```

```scala
def flushElemBuilder() = ...
```

```scala
override def visitArray(length: Int, index: Int) = ...
```

```scala
override def visitObject(length: Int, jsonableKeys: Boolean, index: Int) = ...
```

```scala
override def visitNull(index: Int) = ...
```

```scala
override def visitFalse(index: Int) = ...
```

```scala
override def visitTrue(index: Int) = ...
```

```scala
override def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

```scala
override def visitFloat64(d: Double, index: Int) = ...
```

```scala
override def visitFloat32(d: Float, index: Int) = ...
```

```scala
override def visitInt32(i: Int, index: Int) = ...
```

```scala
override def visitInt64(i: Long, index: Int) = ...
```

```scala
override def visitUInt64(i: Long, index: Int) = ...
```

```scala
override def visitString(s: CharSequence, index: Int) = ...
```

```scala
override def visitBinary(bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def writeUInt8(arr: Array[Byte], length: Int, i: Int): Unit = ...
```

```scala
def writeUInt16(arr: Array[Byte], length: Int, i: Int): Unit = ...
```

```scala
def writeUInt32(arr: Array[Byte], length: Int, i: Int): Unit = ...
```

```scala
def writeUInt64(arr: Array[Byte], length: Int, i: Long): Unit = ...
```

```scala
def visitExt(tag: Byte, bytes: Array[Byte], offset: Int, len: Int, index: Int) = ...
```

```scala
def visitChar(s: Char, index: Int) = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def writeUInt8(i: Int): Unit = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def writeUInt16(i: Int): Unit = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def writeUInt32(i: Int): Unit = ...
```

```scala
  @deprecated("Not used, kept for binary compatibility")
def writeUInt64(i: Long): Unit = ...
```

#### `upack/MsgVisitor.scala`

> A [[Visitor]] specialized to work with msgpack types. Forwards the
> not-msgpack-related methods to their msgpack equivalents.

```scala
trait MsgVisitor[-T, +J] extends Visitor[T, J]
```

```scala
def visitFloat64String(s: String, index: Int) = ...
```

```scala
def visitFloat64StringParts(s: CharSequence, decIndex: Int, expIndex: Int, index: Int) = ...
```

#### `upack/Readable.scala`

```scala
trait Readable
```

```scala
def transform[T](f: Visitor[_, T]): T
```

```scala
object Readable extends ReadableLowPri
```

```scala
implicit def fromByteArray(s: Array[Byte]): Readable = ...
```

```scala
trait ReadableLowPri
```

```scala
implicit def fromReadable[T](s: T)(implicit conv: T => geny.Readable): Readable = ...
```

#### `upack/package.scala`

```scala
package object upack
```

```scala
def transform[T](t: Readable, v: upickle.core.Visitor[_, T]) = ...
```

> Read the given MessagePack input into a MessagePack struct

```scala
def read(s: Readable, trace: Boolean = false): Msg = ...
```

```scala
def copy(t: Msg): Msg = ...
```

> Write the given MessagePack struct as a binary

```scala
def write(t: Msg): Array[Byte] = ...
```

> Write the given MessagePack struct as a binary to the given OutputStream

```scala
def writeTo(t: Msg, out: java.io.OutputStream): Unit = ...
```

```scala
def writeToByteArray(t: Msg) = ...
```

> Parse the given MessagePack input, failing if it is invalid

```scala
def validate(s: Readable): Unit = ...
```

