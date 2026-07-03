# os-lib 0.10.0 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `514` non-private declaration signatures from `15` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::os-lib:0.10.0`
- Upstream docs: https://com-lihaoyi.github.io/os-lib/
- Source artifacts included:
  - `com.lihaoyi:os-lib_3:0.10.0`

## Common imports

```scala
import os.* // usually accessed as os.pwd, os.Path, os.read, os.write, os.proc, ...
```

## Usage notes

Filesystem, subprocess, path, and environment helper library used throughout this project via the `os` package object.

```scala
val repo = os.pwd / ".mif" / "repository"
val pom = repo / os.RelPath("com/example/app/1.0.0/app-1.0.0.pom")

os.makeDir.all(pom / os.up)
os.write.over(pom, "<project></project>")

val bytes: Array[Byte] = os.read.bytes(pom)
val files: Seq[os.Path] = os.walk(repo).filter(os.isFile)

val result = os.proc("git", "--version").call(cwd = os.pwd)
println(result.out.text())
```

## API signatures from upstream source

### `com.lihaoyi:os-lib_3:0.10.0`

Source: https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.0/os-lib_3-0.10.0-sources.jar

#### `FileOps.scala`

> Create a single directory at the specified path. Optionally takes in a
> [[PermSet]] to specify the filesystem permissions of the created
> directory.
>
> Errors out if the directory already exists, or if the parent directory of the
> specified path does not exist. To automatically create enclosing directories and
> ignore the destination if it already exists, using [[os.makeDir.all]]

```scala
object makeDir extends Function1[Path, Unit]
```

```scala
def apply(path: Path): Unit = ...
```

```scala
def apply(path: Path, perms: PermSet): Unit = ...
```

> Similar to [[os.makeDir]], but automatically creates any necessary
> enclosing directories if they do not exist, and does not raise an error if the
> destination path already containts a directory

```scala
object all extends Function1[Path, Unit]
```

```scala
def apply(path: Path): Unit = ...
```

```scala
def apply(path: Path, perms: PermSet = null, acceptLinkedDirectory: Boolean = true): Unit = ...
```

> Moves a file or folder from one path to another. Errors out if the destination
> path already exists, or is within the source path.

```scala
object move
```

```scala
def matching(
      replaceExisting: Boolean = false,
      atomicMove: Boolean = false,
      createFolders: Boolean = false
  )(partialFunction: PartialFunction[Path, Path]): PartialFunction[Path, Unit] = ...
```

```scala
def matching(partialFunction: PartialFunction[Path, Path]): PartialFunction[Path, Unit] = ...
```

```scala
def apply(
      from: Path,
      to: Path,
      replaceExisting: Boolean = false,
      atomicMove: Boolean = false,
      createFolders: Boolean = false
  ): Unit = ...
```

> Move a file into a particular folder, rather
> than into a particular path

```scala
object into
```

```scala
def apply(
        from: Path,
        to: Path,
        replaceExisting: Boolean = false,
        atomicMove: Boolean = false,
        createFolders: Boolean = false
    ): Unit = ...
```

> Move a file into a particular folder, rather
> than into a particular path

```scala
object over
```

```scala
def apply(
        from: Path,
        to: Path,
        replaceExisting: Boolean = false,
        atomicMove: Boolean = false,
        createFolders: Boolean = false
    ): Unit = ...
```

> Copy a file or folder from one path to another. Recursively copies folders with
> all their contents. Errors out if the destination path already exists, or is
> within the source path.

```scala
object copy
```

```scala
def matching(
      followLinks: Boolean = true,
      replaceExisting: Boolean = false,
      copyAttributes: Boolean = false,
      createFolders: Boolean = false,
      mergeFolders: Boolean = false
  )(partialFunction: PartialFunction[Path, Path]): PartialFunction[Path, Unit] = ...
```

```scala
def matching(partialFunction: PartialFunction[Path, Path]): PartialFunction[Path, Unit] = ...
```

```scala
def apply(
      from: Path,
      to: Path,
      followLinks: Boolean = true,
      replaceExisting: Boolean = false,
      copyAttributes: Boolean = false,
      createFolders: Boolean = false,
      mergeFolders: Boolean = false
  ): Unit = ...
```

```scala
def apply(
      from: Path,
      to: Path,
      followLinks: Boolean,
      replaceExisting: Boolean,
      copyAttributes: Boolean,
      createFolders: Boolean
  ): Unit = ...
```

> Copy a file into a particular folder, rather
> than into a particular path

```scala
object into
```

```scala
def apply(
        from: Path,
        to: Path,
        followLinks: Boolean = true,
        replaceExisting: Boolean = false,
        copyAttributes: Boolean = false,
        createFolders: Boolean = false,
        mergeFolders: Boolean = false
    ): Unit = ...
```

```scala
def apply(
        from: Path,
        to: Path,
        followLinks: Boolean,
        replaceExisting: Boolean,
        copyAttributes: Boolean,
        createFolders: Boolean
    ): Unit = ...
```

> Copy a file into a particular path

```scala
object over
```

```scala
def apply(
        from: Path,
        to: Path,
        followLinks: Boolean = true,
        replaceExisting: Boolean = false,
        copyAttributes: Boolean = false,
        createFolders: Boolean = false
    ): Unit = ...
```

> Roughly equivalent to bash's `rm -rf`. Deletes
> any files or folders in the target path, or
> does nothing if there aren't any

```scala
object remove extends Function1[Path, Boolean]
```

```scala
def apply(target: Path): Boolean = ...
```

```scala
def apply(target: Path, checkExists: Boolean = false): Boolean = ...
```

```scala
object all extends Function1[Path, Unit]
```

```scala
def apply(target: Path) = ...
```

> Checks if a file or folder exists at the given path.

```scala
object exists extends Function1[Path, Boolean]
```

```scala
def apply(p: Path): Boolean = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): Boolean = ...
```

> Creates a hardlink between two paths

```scala
object hardlink
```

```scala
def apply(link: Path, dest: Path) = ...
```

> Creates a symbolic link between two paths

```scala
object symlink
```

```scala
def apply(link: Path, dest: FilePath, perms: PermSet = null): Unit = ...
```

> Attempts to any symbolic links in the given path and return the canonical path.
> Returns `None` if the path cannot be resolved (i.e. some symbolic link in the
> given path is broken)

```scala
object followLink extends Function1[Path, Option[Path]]
```

```scala
def apply(src: Path): Option[Path] = ...
```

> Reads the destination that the given symbolic link is pointed to

```scala
object readLink extends Function1[Path, os.FilePath]
```

```scala
def apply(src: Path): FilePath = ...
```

```scala
def absolute(src: Path): os.Path = ...
```

#### `GlobInterpolator.scala`

```scala
object GlobInterpolator
```

```scala
class Interped(parts: Seq[String])
```

```scala
def unapplySeq(s: String) = ...
```

> Lets you pattern match strings with interpolated glob-variables

```scala
class GlobInterpolator(sc: StringContext)
```

```scala
def g(parts: Any*) = ...
```

```scala
def g = ...
```

#### `Internals.scala`

```scala
object Internals
```

```scala
val emptyStringArray = ...
```

```scala
def transfer0(src: InputStream, sink: (Array[Byte], Int) => Unit) = ...
```

```scala
def transfer(src: InputStream, dest: OutputStream) = ...
```

#### `ListOps.scala`

> Returns all the files and folders directly within the given folder. If the
> given path is not a folder, raises an error. Can be called with
> [[list.stream]] to return an iterator. To list files recursively, use
> [[walk]]
>
> For convenience `os.list` sorts the entries in the folder before returning
> them. You can disable sorted by passing in the flag `sort = false`.

```scala
object list extends Function1[Path, IndexedSeq[Path]]
```

```scala
def apply(src: Path, sort: Boolean = true): IndexedSeq[Path] = ...
```

```scala
def apply(src: Path): IndexedSeq[Path] = ...
```

> Similar to [[os.list]]], except provides a [[os.Generator]] of results
> rather than accumulating all of them in memory. Useful if the result set
> is large.

```scala
object stream extends Function1[Path, geny.Generator[Path]]
```

```scala
def apply(arg: Path) = ...
```

> Recursively walks the given folder and returns the paths of every file or folder
> within.
>
> You can pass in a `skip` callback to skip files or folders you are not
> interested in. This can avoid walking entire parts of the folder hierarchy,
> saving time as compared to filtering them after the fact.
>
> By default, the paths are returned as a pre-order traversal: the enclosing
> folder is occurs first before any of it's contents. You can pass in `preOrder =
> false` to turn it into a post-order traversal, such that the enclosing folder
> occurs last after all it's contents.
>
> `os.walk` returns but does not follow symlinks; pass in `followLinks = true` to
> override that behavior. You can also specify a maximum depth you wish to walk
> via the `maxDepth` parameter.

```scala
object walk
```

> @param path the root path whose contents you wish to walk
>
> @param skip Skip certain files or folders from appearing in the output.
> If you skip a folder, its entire subtree is ignored
>
> @param preOrder Whether you want a folder to appear before or after its
> contents in the final sequence. e.g. if you're deleting
> them recursively you want it to be false so the folder
> gets deleted last, but if you're copying them recursively
> you want `preOrder` to be `true` so the folder gets
> created first.
>
> @param followLinks Whether or not to follow symlinks while walking; defaults
> to false
>
> @param maxDepth The max depth of the tree you wish to walk; defaults to unlimited
>
> @param includeTarget Whether or not to include the given path as part of the walk.
> If `true`, does not raise an error if the given path is a
> simple file and not a folder

```scala
def apply(
      path: Path,
      skip: Path => Boolean = _ => false,
      preOrder: Boolean = true,
      followLinks: Boolean = false,
      maxDepth: Int = Int.MaxValue,
      includeTarget: Boolean = false
  ): IndexedSeq[Path] = ...
```

> @param path the root path whose contents you wish to walk
>
> @param skip Skip certain files or folders from appearing in the output.
> If you skip a folder, its entire subtree is ignored
>
> @param preOrder Whether you want a folder to appear before or after its
> contents in the final sequence. e.g. if you're deleting
> them recursively you want it to be false so the folder
> gets deleted last, but if you're copying them recursively
> you want `preOrder` to be `true` so the folder gets
> created first.
>
> @param followLinks Whether or not to follow symlinks while walking; defaults
> to false
>
> @param maxDepth The max depth of the tree you wish to walk; defaults to unlimited
>
> @param includeTarget Whether or not to include the given path as part of the walk.
> If `true`, does not raise an error if the given path is a
> simple file and not a folder

```scala
def attrs(
      path: Path,
      skip: (Path, os.StatInfo) => Boolean = (_, _) => false,
      preOrder: Boolean = true,
      followLinks: Boolean = false,
      maxDepth: Int = Int.MaxValue,
      includeTarget: Boolean = false
  ): IndexedSeq[(Path, os.StatInfo)] = ...
```

```scala
object stream
```

> @param path the root path whose contents you wish to walk
>
> @param skip Skip certain files or folders from appearing in the output.
> If you skip a folder, its entire subtree is ignored
>
> @param preOrder Whether you want a folder to appear before or after its
> contents in the final sequence. e.g. if you're deleting
> them recursively you want it to be false so the folder
> gets deleted last, but if you're copying them recursively
> you want `preOrder` to be `true` so the folder gets
> created first.
>
> @param followLinks Whether or not to follow symlinks while walking; defaults
> to false
>
> @param maxDepth The max depth of the tree you wish to walk; defaults to unlimited
>
> @param includeTarget Whether or not to include the given path as part of the walk.
> If `true`, does not raise an error if the given path is a
> simple file and not a folder

```scala
def apply(
        path: Path,
        skip: Path => Boolean = _ => false,
        preOrder: Boolean = true,
        followLinks: Boolean = false,
        maxDepth: Int = Int.MaxValue,
        includeTarget: Boolean = false
    ): Generator[Path] = ...
```

> @param path the root path whose contents you wish to walk
>
> @param skip Skip certain files or folders from appearing in the output.
> If you skip a folder, its entire subtree is ignored
>
> @param preOrder Whether you want a folder to appear before or after its
> contents in the final sequence. e.g. if you're deleting
> them recursively you want it to be false so the folder
> gets deleted last, but if you're copying them recursively
> you want `preOrder` to be `true` so the folder gets
> created first.
>
> @param followLinks Whether or not to follow symlinks while walking; defaults
> to false
>
> @param maxDepth The max depth of the tree you wish to walk; defaults to unlimited
>
> @param includeTarget Whether or not to include the given path as part of the walk.
> If `true`, does not raise an error if the given path is a
> simple file and not a folder

```scala
def attrs(
        path: Path,
        skip: (Path, os.StatInfo) => Boolean = (_, _) => false,
        preOrder: Boolean = true,
        followLinks: Boolean = false,
        maxDepth: Int = Int.MaxValue,
        includeTarget: Boolean = false
    ): Generator[(Path, os.StatInfo)] = ...
```

#### `Model.scala`

> Simple enum with the possible filesystem objects a path can resolve to

```scala
sealed trait FileType
```

```scala
object FileType
```

```scala
case object File extends FileType
```

```scala
case object Dir extends FileType
```

```scala
case object SymLink extends FileType
```

```scala
case object Other extends FileType
```

```scala
object PermSet
```

```scala
implicit def fromSet(value: java.util.Set[PosixFilePermission]): PermSet = ...
```

> Parses a `rwx-wxr-w` string into a [[PermSet]]

```scala
implicit def fromString(arg: String): PermSet = ...
```

> Parses a 0x777 integer into a [[PermSet]]

```scala
implicit def fromInt(value: Int): PermSet = ...
```

```scala
def permToMask(elem: PosixFilePermission) = ...
```

```scala
def permToChar(elem: PosixFilePermission) = ...
```

```scala
def permToOffset(elem: PosixFilePermission) = ...
```

> A set of permissions; can be converted easily to the rw-rwx-r-x form via
> [[toString]], or to a set of [[PosixFilePermission]]s via [[toSet]] and the
> other way via `PermSet.fromString`/`PermSet.fromSet`

```scala
case class PermSet(value: Int)
```

```scala
def contains(elem: PosixFilePermission) = ...
```

```scala
def +(elem: PosixFilePermission) = ...
```

```scala
def ++(other: PermSet) = ...
```

```scala
def -(elem: PosixFilePermission) = ...
```

```scala
def --(other: PermSet) = ...
```

```scala
def toInt(): Int = ...
```

```scala
def toSet(): java.util.Set[PosixFilePermission] = ...
```

```scala
override def toString() = ...
```

> Contains the accumulated output for the invocation of a subprocess command.
>
> Apart from the exit code, the primary data-structure is a sequence of byte
> chunks, tagged with [[Left]] for stdout and [[Right]] for stderr. This is
> interleaved roughly in the order it was emitted by the subprocess, and
> reflects what a user would have see if the subprocess was run manually.
>
> Derived from that, is the aggregate `out` and `err` [[StreamValue]]s,
> wrapping stdout/stderr respectively, and providing convenient access to
> the aggregate output of each stream, as bytes or strings or lines.

```scala
case class CommandResult(
    command: Seq[String],
    exitCode: Int,
    chunks: Seq[Either[geny.Bytes, geny.Bytes]]
)
```

> The standard output and error of the executed command, exposed in a
> number of ways for convenient access

```scala
val (out, err) = ...
```

```scala
override def toString() = ...
```

> Thrown when a shellout command results in a non-zero exit code.
>
> Doesn't contain any additional information apart from the [[CommandResult]]
> that is normally returned, but ensures that failures in subprocesses happen
> loudly and won't get ignored unless intentionally caught

```scala
case class SubprocessException(result: CommandResult) extends Exception(result.toString)
```

> An implicit wrapper defining the things that can
> be "interpolated" directly into a subprocess call.

```scala
case class Shellable(value: Seq[String])
```

```scala
object Shellable
```

```scala
implicit def StringShellable(s: String): Shellable = ...
```

```scala
implicit def CharSequenceShellable(cs: CharSequence): Shellable = ...
```

```scala
implicit def SymbolShellable(s: Symbol): Shellable = ...
```

```scala
implicit def PathShellable(s: Path): Shellable = ...
```

```scala
implicit def RelPathShellable(s: RelPath): Shellable = ...
```

```scala
implicit def NumericShellable[T: Numeric](s: T): Shellable = ...
```

```scala
implicit def OptionShellable[T](s: Option[T])(implicit f: T => Shellable): Shellable = ...
```

```scala
implicit def IterableShellable[T](s: Iterable[T])(implicit f: T => Shellable): Shellable = ...
```

```scala
implicit def ArrayShellable[T](s: Array[T])(implicit f: T => Shellable): Shellable = ...
```

> The result from doing an system `stat` on a particular path.
>
> Note: ctime is not same as ctime (Change Time) in `stat`,
> it is creation time maybe fall back to mtime if system not supported it.
>
> Created via `stat! filePath`.
>
> If you want more information, use `stat.full`

```scala
case class StatInfo(
    size: Long,
    mtime: FileTime,
    ctime: FileTime,
    atime: FileTime,
    fileType: FileType
)
```

```scala
def isDir = ...
```

```scala
def isSymLink = ...
```

```scala
def isFile = ...
```

```scala
object StatInfo
```

```scala
def make(attrs: BasicFileAttributes) = ...
```

```scala
case class PosixStatInfo(owner: UserPrincipal, permissions: PermSet)
```

```scala
object PosixStatInfo
```

```scala
def make(posixAttrs: PosixFileAttributes) = ...
```

#### `Path.scala`

```scala
trait PathChunk
```

```scala
def segments: Seq[String]
```

```scala
def ups: Int
```

```scala
object PathChunk
```

```scala
implicit class RelPathChunk(r: RelPath) extends PathChunk
```

```scala
def segments = ...
```

```scala
def ups = ...
```

```scala
override def toString() = ...
```

```scala
implicit class SubPathChunk(r: SubPath) extends PathChunk
```

```scala
def segments = ...
```

```scala
def ups = ...
```

```scala
override def toString() = ...
```

```scala
implicit class StringPathChunk(s: String) extends PathChunk
```

```scala
def segments = ...
```

```scala
def ups = ...
```

```scala
override def toString() = ...
```

```scala
implicit class SymbolPathChunk(s: Symbol) extends PathChunk
```

```scala
def segments = ...
```

```scala
def ups = ...
```

```scala
override def toString() = ...
```

```scala
implicit class ArrayPathChunk[T](a: Array[T])(implicit f: T => PathChunk) extends PathChunk
```

```scala
val inner = ...
```

```scala
def segments = ...
```

```scala
def ups = ...
```

```scala
override def toString() = ...
```

```scala
implicit class SeqPathChunk[T](a: Seq[T])(implicit f: T => PathChunk) extends PathChunk
```

```scala
    @deprecated("never used, really shouldn't exist, kept for bincompat")
var segments0 = ...
```

```scala
    @deprecated("never used, really shouldn't exist, kept for bincompat")
var ups0 = ...
```

```scala
val (segments, ups) = ...
```

```scala
override def toString() = ...
```

> A path which is either an absolute [[Path]], a relative [[RelPath]],
> or a [[ResourcePath]] with shared APIs and implementations.
>
> Most of the filesystem-independent path-manipulation logic that lets you
> splice paths together or navigate in and out of paths lives in this interface

```scala
trait BasePath
```

```scala
type ThisType <: BasePath
```

> Combines this path with the given relative path, returning
> a path of the same type as this one (e.g. `Path` returns `Path`,
> `RelPath` returns `RelPath`

```scala
def /(chunk: PathChunk): ThisType
```

> Relativizes this path with the given `target` path, finding a
> relative path `p` such that base/p == this.
>
> Note that you can only relativize paths of the same type, e.g.
> `Path` & `Path` or `RelPath` & `RelPath`. In the case of `RelPath`,
> this can throw a [[PathError.NoRelativePath]] if there is no
> relative path that satisfies the above requirement in the general
> case.

```scala
def relativeTo(target: ThisType): RelPath
```

> Relativizes this path with the given `target` path, finding a
> sub path `p` such that base/p == this.

```scala
def subRelativeTo(target: ThisType): SubPath = ...
```

> This path starts with the target path, including if it's identical

```scala
def startsWith(target: ThisType): Boolean
```

> This path ends with the target path, including if it's identical

```scala
def endsWith(target: RelPath): Boolean
```

> The last segment in this path. Very commonly used, e.g. it
> represents the name of the file/folder in filesystem paths

```scala
def last: String
```

> Gives you the file extension of this path, or the empty
> string if there is no extension

```scala
def ext: String
```

> Gives you the base name of this path, ie without the extension

```scala
def baseName: String
```

> The individual path segments of this path.

```scala
def segments: TraversableOnce[String]
```

```scala
object BasePath
```

```scala
def checkSegment(s: String) = ...
```

```scala
def chunkify(s: java.nio.file.Path) = ...
```

```scala
trait SegmentedPath extends BasePath
```

> The individual path segments of this path.

```scala
def segments: IndexedSeq[String]
```

```scala
override def /(chunk: PathChunk): ThisType = ...
```

```scala
def endsWith(target: RelPath): Boolean = ...
```

```scala
trait BasePathImpl extends BasePath
```

```scala
def /(chunk: PathChunk): ThisType
```

```scala
def ext = ...
```

```scala
override def baseName: String = ...
```

```scala
def last: String = ...
```

```scala
def lastOpt: Option[String]
```

```scala
object PathError
```

```scala
type IAE = ...
```

```scala
case class InvalidSegment(segment: String, msg: String) extends IAE(errorMsg(segment, msg))
```

```scala
case object AbsolutePathOutsideRoot
      extends IAE("The path created has enough ..s that it would start outside the root directory")
```

```scala
case class NoRelativePath(src: RelPath, base: RelPath)
```

```scala
case class LastOnEmptyPath()
```

> Represents a value that is either an absolute [[Path]] or a
> relative [[RelPath]], and can be constructed from a
> java.nio.file.Path or java.io.File

```scala
sealed trait FilePath extends BasePath
```

```scala
def toNIO: java.nio.file.Path
```

```scala
def resolveFrom(base: os.Path): os.Path
```

```scala
object FilePath
```

```scala
def apply[T: PathConvertible](f0: T) = ...
```

> A relative path on the filesystem. Note that the path is
> normalized and cannot contain any empty or ".". Parent ".."
> segments can only occur at the left-end of the path, and
> are collapsed into a single number [[ups]].

```scala
class RelPath private[os] (segments0: Array[String], val ups: Int)
```

```scala
def lastOpt = ...
```

```scala
val segments: IndexedSeq[String] = ...
```

```scala
type ThisType = ...
```

```scala
def relativeTo(base: RelPath): RelPath = ...
```

```scala
def startsWith(target: RelPath) = ...
```

```scala
override def toString = ...
```

```scala
override def hashCode = ...
```

```scala
override def equals(o: Any): Boolean = ...
```

```scala
def toNIO = ...
```

```scala
def asSubPath = ...
```

```scala
def resolveFrom(base: os.Path) = ...
```

```scala
object RelPath
```

```scala
def apply[T: PathConvertible](f0: T): RelPath = ...
```

```scala
def apply(segments0: IndexedSeq[String], ups: Int) = ...
```

```scala
implicit val relPathOrdering: Ordering[RelPath] = ...
```

```scala
val up: RelPath = ...
```

```scala
val rel: RelPath = ...
```

```scala
implicit def SubRelPath(p: SubPath): RelPath = ...
```

> A relative path on the filesystem, without any `..` or `.` segments

```scala
class SubPath private[os] (val segments0: Array[String])
```

```scala
def lastOpt = ...
```

```scala
val segments: IndexedSeq[String] = ...
```

```scala
override type ThisType = ...
```

```scala
def relativeTo(base: SubPath): RelPath = ...
```

```scala
def startsWith(target: SubPath) = ...
```

```scala
override def toString = ...
```

```scala
override def hashCode = ...
```

```scala
override def equals(o: Any): Boolean = ...
```

```scala
def toNIO = ...
```

```scala
def resolveFrom(base: os.Path) = ...
```

```scala
object SubPath
```

```scala
def apply[T: PathConvertible](f0: T): SubPath = ...
```

```scala
def apply(segments0: IndexedSeq[String]): SubPath = ...
```

```scala
implicit val subPathOrdering: Ordering[SubPath] = ...
```

```scala
val sub: SubPath = ...
```

```scala
object Path
```

```scala
def apply(p: FilePath, base: Path) = ...
```

> Equivalent to [[os.Path.apply]], but automatically expands a
> leading `~/` into the user's home directory, for convenience

```scala
def expandUser[T: PathConvertible](f0: T, base: Path = null) = ...
```

```scala
def apply[T: PathConvertible](f: T, base: Path): Path = ...
```

```scala
def apply[T: PathConvertible](f0: T): Path = ...
```

```scala
implicit val pathOrdering: Ordering[Path] = ...
```

> @return true if Windows OS and path begins with slash or backslash.
> Examples:
> driveRelative("/Users")   // true in `Windows`, false elsewhere.
> driveRelative("\\Users")  // true in `Windows`, false elsewhere.
> driveRelative("C:/Users") // false always

```scala
def driveRelative[T: PathConvertible](f0: T): Boolean = ...
```

> @return current working drive if Windows, empty string elsewhere.
> Paths.get(driveRoot) == current working directory on all platforms.

```scala
lazy val driveRoot: String = ...
```

```scala
trait ReadablePath
```

```scala
def toSource: os.Source
```

```scala
def getInputStream: java.io.InputStream
```

> An absolute path on the filesystem. Note that the path is
> normalized and cannot contain any empty `""`, `"."` or `".."` segments

```scala
class Path private[os] (val wrapped: java.nio.file.Path)
```

```scala
def toSource: SeekableSource = ...
```

```scala
def root = ...
```

```scala
def fileSystem = ...
```

```scala
def segments: Iterator[String] = ...
```

```scala
def getSegment(i: Int): String = ...
```

```scala
def segmentCount = ...
```

```scala
override type ThisType = ...
```

```scala
def lastOpt = ...
```

```scala
override def /(chunk: PathChunk): Path = ...
```

```scala
override def toString = ...
```

```scala
override def equals(o: Any): Boolean = ...
```

```scala
override def hashCode = ...
```

```scala
def startsWith(target: Path) = ...
```

```scala
def endsWith(target: RelPath) = ...
```

```scala
def relativeTo(base: Path): RelPath = ...
```

```scala
def toIO: java.io.File = ...
```

```scala
def toNIO: java.nio.file.Path = ...
```

```scala
def resolveFrom(base: os.Path) = ...
```

```scala
def getInputStream = ...
```

```scala
sealed trait PathConvertible[T]
```

```scala
def apply(t: T): java.nio.file.Path
```

```scala
def isCustomFs(t: T): Boolean = ...
```

```scala
object PathConvertible
```

```scala
implicit object StringConvertible extends PathConvertible[String]
```

```scala
def apply(t: String) = ...
```

```scala
implicit object JavaIoFileConvertible extends PathConvertible[java.io.File]
```

```scala
def apply(t: java.io.File) = ...
```

```scala
implicit object NioPathConvertible extends PathConvertible[java.nio.file.Path]
```

```scala
def apply(t: java.nio.file.Path) = ...
```

```scala
override def isCustomFs(t: java.nio.file.Path): Boolean = ...
```

```scala
implicit object UriPathConvertible extends PathConvertible[URI]
```

```scala
def apply(uri: URI) = ...
```

#### `PermsOps.scala`

> Get the filesystem permissions of the file/folder at the given path

```scala
object perms extends Function1[Path, PermSet]
```

```scala
def apply(p: Path): PermSet = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): PermSet = ...
```

> Set the filesystem permissions of the file/folder at the given path
>
> Note that if you want to create a file or folder with a given set of
> permissions, you can pass in an [[os.PermSet]] to [[os.write]]
> or [[os.makeDir]]. That will ensure the file or folder is created
> atomically with the given permissions, rather than being created with the
> default set of permissions and having `os.perms.set` over-write them later

```scala
object set
```

```scala
def apply(p: Path, arg2: PermSet): Unit = ...
```

> Get the owner of the file/folder at the given path

```scala
object owner extends Function1[Path, UserPrincipal]
```

```scala
def apply(p: Path): UserPrincipal = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): UserPrincipal = ...
```

> Set the owner of the file/folder at the given path

```scala
object set
```

```scala
def apply(arg1: Path, arg2: UserPrincipal): Unit = ...
```

```scala
def apply(arg1: Path, arg2: String): Unit = ...
```

> Get the owning group of the file/folder at the given path

```scala
object group extends Function1[Path, GroupPrincipal]
```

```scala
def apply(p: Path): GroupPrincipal = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): GroupPrincipal = ...
```

> Set the owning group of the file/folder at the given path

```scala
object set
```

```scala
def apply(arg1: Path, arg2: GroupPrincipal): Unit = ...
```

```scala
def apply(arg1: Path, arg2: String): Unit = ...
```

#### `ProcessOps.scala`

> Convenience APIs around [[java.lang.Process]] and [[java.lang.ProcessBuilder]]:
>
> - os.proc.call provides a convenient wrapper for "function-like" processes
> that you invoke with some input, whose entire output you need, but
> otherwise do not have any intricate back-and-forth communication
>
> - os.proc.stream provides a lower level API: rather than providing the output
> all at once, you pass in callbacks it invokes whenever there is a chunk of
> output received from the spawned process.
>
> - os.proc(...) provides the lowest level API: an simple Scala API around
> [[java.lang.ProcessBuilder]], that spawns a normal [[java.lang.Process]]
> for you to deal with. You can then interact with it normally through
> the standard stdin/stdout/stderr streams, using whatever protocol you
> want

```scala
case class proc(command: Shellable*)
```

```scala
def commandChunks: Seq[String] = ...
```

> Invokes the given subprocess like a function, passing in input and returning a
> [[CommandResult]]. You can then call `result.exitCode` to see how it exited, or
> `result.out.bytes` or `result.err.text()` to access the aggregated stdout and
> stderr of the subprocess in a number of convenient ways. If a non-zero exit code
> is returned, this throws a [[os.SubprocessException]] containing the
> [[CommandResult]], unless you pass in `check = false`.
>
> If you want to spawn an interactive subprocess, such as `vim`, `less`, or a
> `python` shell, set all of `stdin`/`stdout`/`stderr` to [[os.Inherit]]
>
> `call` provides a number of parameters that let you configure how the subprocess
> is run:
>
> @param cwd             the working directory of the subprocess
> @param env             any additional environment variables you wish to set in the subprocess
> @param stdin           any data you wish to pass to the subprocess's standard input
> @param stdout          How the process's output stream is configured.
> @param stderr          How the process's error stream is configured.
> @param mergeErrIntoOut merges the subprocess's stderr stream into it's stdout
> @param timeout         how long to wait in milliseconds for the subprocess to complete
> @param check           disable this to avoid throwing an exception if the subprocess
> fails with a non-zero exit code
> @param propagateEnv    disable this to avoid passing in this parent process's
> environment variables to the subprocess

```scala
def call(
      cwd: Path = null,
      env: Map[String, String] = null,
      stdin: ProcessInput = Pipe,
      stdout: ProcessOutput = Pipe,
      stderr: ProcessOutput = os.Inherit,
      mergeErrIntoOut: Boolean = false,
      timeout: Long = -1,
      check: Boolean = true,
      propagateEnv: Boolean = true
  ): CommandResult = ...
```

> The most flexible of the [[os.proc]] calls, `os.proc.spawn` simply configures
> and starts a subprocess, and returns it as a `java.lang.Process` for you to
> interact with however you like.
>
> Note that if you provide `ProcessOutput` callbacks to `stdout`/`stderr`,
> the calls to those callbacks take place on newly spawned threads that
> execute in parallel with the main thread. Thus make sure any data
> processing you do in those callbacks is thread safe!

```scala
def spawn(
      cwd: Path = null,
      env: Map[String, String] = null,
      stdin: ProcessInput = Pipe,
      stdout: ProcessOutput = Pipe,
      stderr: ProcessOutput = os.Inherit,
      mergeErrIntoOut: Boolean = false,
      propagateEnv: Boolean = true
  ): SubProcess = ...
```

> Pipes the output of this process into the input of the [[next]] process. Returns a
> [[ProcGroup]] containing both processes, which you can then either execute or
> pipe further.

```scala
def pipeTo(next: proc): ProcGroup = ...
```

> A group of processes that are piped together, corresponding to e.g. `ls -l | grep .scala`.
> You can create a `ProcGroup` by calling `.pipeTo` on a [[proc]] multiple times.
> Contains methods corresponding to the methods on [[proc]], but defined for pipelines
> of processes.

```scala
case class ProcGroup private[os] (commands: Seq[proc])
```

> Invokes the given pipeline like a function, passing in input and returning a
> [[CommandResult]]. You can then call `result.exitCode` to see how it exited, or
> `result.out.bytes` or `result.err.string` to access the aggregated stdout and
> stderr of the subprocess in a number of convenient ways. If a non-zero exit code
> is returned, this throws a [[os.SubprocessException]] containing the
> [[CommandResult]], unless you pass in `check = false`.
>
> For each process in pipeline, the output will be forwarded to the input of the next
> process. Input of the first process is set to provided [[stdin]] The output of the last
> process will be returned as the output of the pipeline. [[stderr]] is set for all processes.
>
> `call` provides a number of parameters that let you configure how the pipeline
> is run:
>
> @param cwd              the working directory of the pipeline
> @param env              any additional environment variables you wish to set in the pipeline
> @param stdin            any data you wish to pass to the pipelines's standard input (to the first process)
> @param stdout           How the pipelines's output stream is configured (the last process stdout)
> @param stderr           How the process's error stream is configured (set for all processes)
> @param mergeErrIntoOut  merges the pipeline's stderr stream into it's stdout. Note that then the
> stderr will be forwarded with stdout to subsequent processes in the pipeline.
> @param timeout          how long to wait in milliseconds for the pipeline to complete
> @param check            disable this to avoid throwing an exception if the pipeline
> fails with a non-zero exit code
> @param propagateEnv     disable this to avoid passing in this parent process's
> environment variables to the pipeline
> @param pipefail         if true, the pipeline's exitCode will be the exit code of the first
> failing process. If no process fails, the exit code will be 0.
> @param handleBrokenPipe if true, every [[java.io.IOException]] when redirecting output of a process
> will be caught and handled by killing the writing process. This behaviour
> is consistent with handlers of SIGPIPE signals in most programs
> supporting interruptable piping. Disabled by default on Windows.

```scala
def call(
      cwd: Path = null,
      env: Map[String, String] = null,
      stdin: ProcessInput = Pipe,
      stdout: ProcessOutput = Pipe,
      stderr: ProcessOutput = os.Inherit,
      mergeErrIntoOut: Boolean = false,
      timeout: Long = -1,
      check: Boolean = true,
      propagateEnv: Boolean = true,
      pipefail: Boolean = true,
      handleBrokenPipe: Boolean = !isWindows
  ): CommandResult = ...
```

> The most flexible of the [[os.ProcGroup]] calls. It sets-up a pipeline of processes,
> and returns a [[ProcessPipeline]] for you to interact with however you like.
>
> Note that if you provide `ProcessOutput` callbacks to `stdout`/`stderr`,
> the calls to those callbacks take place on newly spawned threads that
> execute in parallel with the main thread. Thus make sure any data
> processing you do in those callbacks is thread safe!
> @param cwd              the working directory of the pipeline
> @param env              any additional environment variables you wish to set in the pipeline
> @param stdin            any data you wish to pass to the pipelines's standard input (to the first process)
> @param stdout           How the pipelines's output stream is configured (the last process stdout)
> @param stderr           How the process's error stream is configured (set for all processes)
> @param mergeErrIntoOut  merges the pipeline's stderr stream into it's stdout. Note that then the
> stderr will be forwarded with stdout to subsequent processes in the pipeline.
> @param propagateEnv     disable this to avoid passing in this parent process's
> environment variables to the pipeline
> @param pipefail         if true, the pipeline's exitCode will be the exit code of the first
> failing process. If no process fails, the exit code will be 0.
> @param handleBrokenPipe if true, every [[java.io.IOException]] when redirecting output of a process
> will be caught and handled by killing the writing process. This behaviour
> is consistent with handlers of SIGPIPE signals in most programs
> supporting interruptable piping. Disabled by default on Windows.

```scala
def spawn(
      cwd: Path = null,
      env: Map[String, String] = null,
      stdin: ProcessInput = Pipe,
      stdout: ProcessOutput = Pipe,
      stderr: ProcessOutput = os.Inherit,
      mergeErrIntoOut: Boolean = false,
      propagateEnv: Boolean = true,
      pipefail: Boolean = true,
      handleBrokenPipe: Boolean = !isWindows
  ): ProcessPipeline = ...
```

> Pipes the output of this pipeline into the input of the [[next]] process.

```scala
def pipeTo(next: proc) = ...
```

#### `ReadWriteOps.scala`

> Write some data to a file. This can be a String, an Array[Byte], or a
> Seq[String] which is treated as consecutive lines. By default, this
> fails if a file already exists at the target location. Use [[write.over]]
> or [[write.append]] if you want to over-write it or add to what's already
> there.

```scala
object write
```

> Open a [[java.io.OutputStream]] to write to the given file

```scala
def outputStream(
      target: Path,
      perms: PermSet = null,
      createFolders: Boolean = false,
      openOptions: Seq[OpenOption] = Seq(CREATE, WRITE)
  ) = ...
```

> Performs the actual opening and writing to a file. Basically cribbed
> from `java.nio.file.Files.write` so we could re-use it properly for
> different combinations of flags and all sorts of [[Source]]s

```scala
def write(
      target: Path,
      data: Source,
      flags: Seq[StandardOpenOption],
      perms: PermSet,
      offset: Long
  ) = ...
```

```scala
def apply(
      target: Path,
      data: Source,
      perms: PermSet = null,
      createFolders: Boolean = false
  ): Unit = ...
```

> Identical to [[write]], except if the file already exists,
> appends to the file instead of error-ing out

```scala
object append
```

```scala
def apply(
        target: Path,
        data: Source,
        perms: PermSet = null,
        createFolders: Boolean = false
    ): Unit = ...
```

> Open a [[java.io.OutputStream]] to write or append to the given file

```scala
def outputStream(target: Path, perms: PermSet = null, createFolders: Boolean = false) = ...
```

> Similar to [[os.write]], except if the file already exists this
> over-writes the existing file contents. You can also pass in `truncate = false`
> to avoid truncating the file if the new contents is shorter than the old
> contents, and an `offset` to the file you want to write to.

```scala
object over
```

```scala
def apply(
        target: Path,
        data: Source,
        perms: PermSet = null,
        offset: Long = 0,
        createFolders: Boolean = false,
        truncate: Boolean = true
    ): Unit = ...
```

> Open a [[java.io.OutputStream]] to write to the given file

```scala
def outputStream(target: Path, perms: PermSet = null, createFolders: Boolean = false) = ...
```

> Opens a [[SeekableByteChannel]] to write to the given file.

```scala
object channel extends Function1[Path, SeekableByteChannel]
```

```scala
def write(p: Path, options: Seq[StandardOpenOption]) = ...
```

```scala
def apply(p: Path): SeekableByteChannel = ...
```

> Opens a [[SeekableByteChannel]] to write to the given file.

```scala
object append extends Function1[Path, SeekableByteChannel]
```

```scala
def apply(p: Path): SeekableByteChannel = ...
```

> Opens a [[SeekableByteChannel]] to write to the given file.

```scala
object over extends Function1[Path, SeekableByteChannel]
```

```scala
def apply(p: Path): SeekableByteChannel = ...
```

> Truncate the given file to the given size. If the file is smaller than the
> given size, does nothing.

```scala
object truncate
```

```scala
def apply(p: Path, size: Long): Unit = ...
```

> Reads the contents of a [[os.Path]] or other [[os.Source]] as a
> `java.lang.String`. Defaults to reading the entire file as UTF-8, but you can
> also select a different `charSet` to use, and provide an `offset`/`count` to
> read from if the source supports seeking.

```scala
object read extends Function1[ReadablePath, String]
```

```scala
def apply(arg: ReadablePath): String = ...
```

```scala
def apply(arg: ReadablePath, charSet: Codec): String = ...
```

```scala
def apply(
      arg: Path,
      charSet: Codec = java.nio.charset.StandardCharsets.UTF_8,
      offset: Long = 0,
      count: Int = Int.MaxValue
  ): String = ...
```

> Opens a [[java.io.InputStream]] to read from the given file

```scala
object inputStream extends Function1[ReadablePath, java.io.InputStream]
```

```scala
def apply(p: ReadablePath): java.io.InputStream = ...
```

```scala
object stream extends Function1[ReadablePath, geny.Readable]
```

```scala
def apply(p: ReadablePath): geny.Readable = ...
```

> Opens a [[SeekableByteChannel]] to read from the given file.

```scala
object channel extends Function1[Path, SeekableByteChannel]
```

```scala
def apply(p: Path): SeekableByteChannel = ...
```

> Reads the contents of a [[os.Path]] or [[os.Source]] as an
> `Array[Byte]`; you can provide an `offset`/`count` to read from if the source
> supports seeking.

```scala
object bytes extends Function1[ReadablePath, Array[Byte]]
```

```scala
def apply(arg: ReadablePath): Array[Byte] = ...
```

```scala
def apply(arg: Path, offset: Long, count: Int): Array[Byte] = ...
```

> Reads the contents of the given [[os.Path]] in chunks of the given size;
> returns a generator which provides a byte array and an offset into that
> array which contains the data for that chunk. All chunks will be of the
> given size, except for the last chunk which may be smaller.
>
> Note that the array returned by the generator is shared between each
> callback; make sure you copy the bytes/array somewhere else if you want
> to keep them around.
>
> Optionally takes in a provided input `buffer` instead of a `chunkSize`,
> allowing you to re-use the buffer between invocations.

```scala
object chunks
```

```scala
def apply(p: ReadablePath, chunkSize: Int): geny.Generator[(Array[Byte], Int)] = ...
```

```scala
def apply(p: ReadablePath, buffer: Array[Byte]): geny.Generator[(Array[Byte], Int)] = ...
```

> Reads the given [[os.Path]] or other [[os.Source]] as a string
> and splits it into lines; defaults to reading as UTF-8, which you
> can override by specifying a `charSet`.

```scala
object lines extends Function1[ReadablePath, IndexedSeq[String]]
```

```scala
def apply(src: ReadablePath): IndexedSeq[String] = ...
```

```scala
def apply(arg: ReadablePath, charSet: Codec): IndexedSeq[String] = ...
```

> Identical to [[os.read.lines]], but streams the results back to you
> in a [[os.Generator]] rather than accumulating them in memory. Useful
> if the file is large.

```scala
object stream extends Function1[ReadablePath, geny.Generator[String]]
```

```scala
def apply(arg: ReadablePath) = ...
```

```scala
def apply(arg: ReadablePath, charSet: Codec) = ...
```

#### `ResourcePath.scala`

```scala
object ResourcePath
```

```scala
def resource(resRoot: ResourceRoot) = ...
```

> Represents path to a resource on the java classpath.
>
> Classloaders are tricky: http://stackoverflow.com/questions/12292926

```scala
class ResourcePath private[os] (val resRoot: ResourceRoot, segments0: Array[String])
```

```scala
def getInputStream = ...
```

```scala
def toSource = ...
```

```scala
val segments: IndexedSeq[String] = ...
```

```scala
type ThisType = ...
```

```scala
def lastOpt = ...
```

```scala
override def toString = ...
```

```scala
def relativeTo(base: ResourcePath) = ...
```

```scala
def startsWith(target: ResourcePath) = ...
```

> Thrown when you try to read from a resource that doesn't exist.
> @param path

```scala
case class ResourceNotFoundException(path: ResourcePath) extends Exception(path.toString)
```

> Represents a possible root where classpath resources can be loaded from;
> either a [[ResourceRoot.ClassLoader]] or a [[ResourceRoot.Class]]. Resources
> loaded from classloaders are always loaded via their absolute path, while
> resources loaded via classes are always loaded relatively.

```scala
sealed trait ResourceRoot
```

```scala
def getResourceAsStream(s: String): InputStream
```

```scala
def errorName: String
```

```scala
object ResourceRoot
```

```scala
implicit def classResourceRoot(cls: java.lang.Class[_]): ResourceRoot = ...
```

```scala
case class Class(cls: java.lang.Class[_]) extends ResourceRoot
```

```scala
def getResourceAsStream(s: String) = ...
```

```scala
def errorName = ...
```

```scala
implicit def classLoaderResourceRoot(cl: java.lang.ClassLoader): ResourceRoot = ...
```

```scala
case class ClassLoader(cl: java.lang.ClassLoader) extends ResourceRoot
```

```scala
def getResourceAsStream(s: String) = ...
```

```scala
def errorName = ...
```

#### `Source.scala`

> A source of bytes; must provide either an [[InputStream]] or a
> [[SeekableByteChannel]] to read from. Can be constructed implicitly from
> strings, byte arrays, inputstreams, channels or file paths

```scala
trait Source extends geny.Writable
```

```scala
override def httpContentType = ...
```

```scala
def getHandle(): Either[geny.Writable, SeekableByteChannel]
```

```scala
def writeBytesTo(out: java.io.OutputStream) = ...
```

```scala
def writeBytesTo(out: WritableByteChannel) = ...
```

```scala
object Source extends WritableLowPri
```

```scala
implicit class ChannelSource(cn: SeekableByteChannel) extends Source
```

```scala
def getHandle() = ...
```

```scala
implicit class WritableSource[T](s: T)(implicit f: T => geny.Writable) extends Source
```

```scala
val writable = ...
```

```scala
def getHandle() = ...
```

```scala
trait WritableLowPri
```

```scala
implicit def WritableGenerator[T](a: geny.Generator[T])(implicit
      f: T => geny.Writable
  ): Source = ...
```

```scala
implicit def WritableTraversable[M[_], T](a: M[T])(implicit
      f: T => geny.Writable,
      g: M[T] => TraversableOnce[T]
  ): Source = ...
```

> A source which is guaranteeds to provide a [[SeekableByteChannel]]

```scala
trait SeekableSource extends Source
```

```scala
def getHandle(): Right[geny.Writable, SeekableByteChannel]
```

```scala
def getChannel() = ...
```

```scala
object SeekableSource
```

```scala
implicit class ChannelSource(cn: SeekableByteChannel) extends SeekableSource
```

```scala
def getHandle() = ...
```

#### `StatOps.scala`

> Checks whether the given path is a symbolic link
>
> Returns `false` if the path does not exist

```scala
object isLink extends Function1[Path, Boolean]
```

```scala
def apply(p: Path): Boolean = ...
```

> Checks whether the given path is a regular file
>
> Returns `false` if the path does not exist

```scala
object isFile extends Function1[Path, Boolean]
```

```scala
def apply(p: Path): Boolean = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): Boolean = ...
```

> Checks whether the given path is a directory
>
> Returns `false` if the path does not exist

```scala
object isDir extends Function1[Path, Boolean]
```

```scala
def apply(p: Path): Boolean = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): Boolean = ...
```

> Gets the size of the given file or folder
>
> Throws an exception if the file or folder does not exist
>
> When called on folders, returns the size of the folder metadata
> (i.e. the list of children names), and not the size of the folder's
> recursive contents. Use [[os.walk]] if you want to sum up the total
> size of a directory tree.

```scala
object size extends Function1[Path, Long]
```

```scala
def apply(p: Path): Long = ...
```

> Gets the mtime of the given file or directory

```scala
object mtime extends Function1[Path, Long]
```

```scala
def apply(p: Path): Long = ...
```

```scala
def apply(p: Path, followLinks: Boolean = true): Long = ...
```

> Sets the mtime of the given file.
>
> Note that this always follows links to set the mtime of the referred-to file.
> Unfortunately there is no Java API to set the mtime of the link itself:
>
> https://stackoverflow.com/questions/17308363/symlink-lastmodifiedtime-in-java-1-7

```scala
object set
```

```scala
def apply(p: Path, millis: Long) = ...
```

> Reads in the basic filesystem metadata for the given file. By default follows
> symbolic links to read the metadata of whatever the link is pointing at; set
> `followLinks = false` to disable that and instead read the metadata of the
> symbolic link itself.
>
> Throws an exception if the file or folder does not exist

```scala
object stat extends Function1[os.Path, os.StatInfo]
```

```scala
def apply(p: os.Path): os.StatInfo = ...
```

```scala
def apply(p: os.Path, followLinks: Boolean = true): os.StatInfo = ...
```

> Reads POSIX metadata for the given file: ownership and permissions data

```scala
object posix
```

```scala
def apply(p: os.Path): os.PosixStatInfo = ...
```

```scala
def apply(p: os.Path, followLinks: Boolean = true): os.PosixStatInfo = ...
```

#### `SubProcess.scala`

> Parent type for single processes and process pipelines.

```scala
sealed trait ProcessLike extends java.lang.AutoCloseable
```

> The exit code of this [[ProcessLike]]. Conventionally, 0 exit code represents a
> successful termination, and non-zero exit code indicates a failure.
>
> Throws an exception if the subprocess has not terminated

```scala
def exitCode(): Int
```

> Returns `true` if the [[ProcessLike]] is still running and has not terminated

```scala
def isAlive(): Boolean
```

> Attempt to destroy the [[ProcessLike]] (gently), via the underlying JVM APIs

```scala
def destroy(): Unit
```

> Force-destroys the [[ProcessLike]], via the underlying JVM APIs

```scala
def destroyForcibly(): Unit
```

> Alias for [[destroy]], implemented for [[java.lang.AutoCloseable]]

```scala
override def close(): Unit
```

> Wait up to `millis` for the [[ProcessLike]] to terminate, by default waits
> indefinitely. Returns `true` if the [[ProcessLike]] has terminated by the time
> this method returns.

```scala
def waitFor(timeout: Long = -1): Boolean
```

> Wait up to `millis` for the [[ProcessLike]] to terminate and all stdout and stderr
> from the subprocess to be handled. By default waits indefinitely; if a time
> limit is given, explicitly destroys the [[ProcessLike]] if it has not completed by
> the time the timeout has occurred

```scala
def join(timeout: Long = -1): Boolean
```

> Represents a spawn subprocess that has started and may or may not have
> completed.

```scala
class SubProcess(
    val wrapped: java.lang.Process,
    val inputPumperThread: Option[Thread],
    val outputPumperThread: Option[Thread],
    val errorPumperThread: Option[Thread]
) extends ProcessLike
```

```scala
val stdin: SubProcess.InputStream = ...
```

```scala
val stdout: SubProcess.OutputStream = ...
```

```scala
val stderr: SubProcess.OutputStream = ...
```

> The subprocess' exit code. Conventionally, 0 exit code represents a
> successful termination, and non-zero exit code indicates a failure.
>
> Throws an exception if the subprocess has not terminated

```scala
def exitCode(): Int = ...
```

> Returns `true` if the subprocess is still running and has not terminated

```scala
def isAlive(): Boolean = ...
```

> Attempt to destroy the subprocess (gently), via the underlying JVM APIs

```scala
def destroy(): Unit = ...
```

> Force-destroys the subprocess, via the underlying JVM APIs

```scala
def destroyForcibly(): Unit = ...
```

> Alias for [[destroy]]

```scala
def close() = ...
```

> Wait up to `millis` for the subprocess to terminate, by default waits
> indefinitely. Returns `true` if the subprocess has terminated by the time
> this method returns.

```scala
def waitFor(timeout: Long = -1): Boolean = ...
```

> Wait up to `millis` for the subprocess to terminate and all stdout and stderr
> from the subprocess to be handled. By default waits indefinitely; if a time
> limit is given, explicitly destroys the subprocess if it has not completed by
> the time the timeout has occurred

```scala
def join(timeout: Long = -1): Boolean = ...
```

```scala
object SubProcess
```

> A [[BufferedWriter]] with the underlying [[java.io.OutputStream]] exposed
>
> Note that all writes that occur through this class are thread-safe and
> synchronized. If you wish to perform writes without the synchronization
> overhead, you can use the underlying [[wrapped]] stream directly

```scala
class InputStream(val wrapped: java.io.OutputStream)
```

```scala
val data = ...
```

```scala
val buffered = ...
```

```scala
def write(b: Int) = ...
```

```scala
override def write(b: Array[Byte]): Unit = ...
```

```scala
override def write(b: Array[Byte], off: Int, len: Int): Unit = ...
```

```scala
def writeBoolean(v: Boolean) = ...
```

```scala
def writeByte(v: Int) = ...
```

```scala
def writeShort(v: Int) = ...
```

```scala
def writeChar(v: Int) = ...
```

```scala
def writeInt(v: Int) = ...
```

```scala
def writeLong(v: Long) = ...
```

```scala
def writeFloat(v: Float) = ...
```

```scala
def writeDouble(v: Double) = ...
```

```scala
def writeBytes(s: String) = ...
```

```scala
def writeChars(s: String) = ...
```

```scala
def writeUTF(s: String) = ...
```

```scala
def writeLine(s: String) = ...
```

```scala
def write(s: String) = ...
```

```scala
def write(s: Array[Char]) = ...
```

```scala
override def flush() = ...
```

```scala
override def close() = ...
```

> A combination [[BufferedReader]] and [[java.io.InputStream]], this allows
> you to read both bytes and lines, without worrying about the buffer used
> for reading lines messing up your reading of bytes.
>
> Note that all reads that occur through this class are thread-safe and
> synchronized. If you wish to perform writes without the synchronization
> overhead, you can use the underlying [[wrapped]] stream directly

```scala
class OutputStream(val wrapped: java.io.InputStream)
```

```scala
val data = ...
```

```scala
val buffered = ...
```

```scala
def read() = ...
```

```scala
override def read(b: Array[Byte]) = ...
```

```scala
override def read(b: Array[Byte], off: Int, len: Int) = ...
```

```scala
def readFully(b: Array[Byte]) = ...
```

```scala
def readFully(b: Array[Byte], off: Int, len: Int) = ...
```

```scala
def skipBytes(n: Int) = ...
```

```scala
def readBoolean() = ...
```

```scala
def readByte() = ...
```

```scala
def readUnsignedByte() = ...
```

```scala
def readShort() = ...
```

```scala
def readUnsignedShort() = ...
```

```scala
def readChar() = ...
```

```scala
def readInt() = ...
```

```scala
def readLong() = ...
```

```scala
def readFloat() = ...
```

```scala
def readDouble() = ...
```

```scala
def readUTF() = ...
```

```scala
def readLine() = ...
```

```scala
def bytes: Array[Byte] = ...
```

```scala
override def close() = ...
```

```scala
class ProcessPipeline(
    val processes: Seq[SubProcess],
    pipefail: Boolean,
    brokenPipeQueue: Option[LinkedBlockingQueue[Int]] // to emulate pipeline behavior in jvm < 9
) extends ProcessLike
```

> String representation of the pipeline.

```scala
def commandString = ...
```

> The exit code of this [[ProcessPipeline]]. Conventionally, 0 exit code represents a
> successful termination, and non-zero exit code indicates a failure. Throws an exception
> if the subprocess has not terminated.
>
> If pipefail is set, the exit code is the first non-zero exit code of the pipeline. If no
> process in the pipeline has a non-zero exit code, the exit code is 0.

```scala
override def exitCode(): Int = ...
```

> Returns `true` if the [[ProcessPipeline]] is still running and has not terminated.
> Any process in the pipeline can be alive for the pipeline to be alive.

```scala
override def isAlive(): Boolean = ...
```

> Attempt to destroy the [[ProcessPipeline]] (gently), via the underlying JVM APIs.
> All processes in the pipeline are destroyed.

```scala
override def destroy(): Unit = ...
```

> Force-destroys the [[ProcessPipeline]], via the underlying JVM APIs.
> All processes in the pipeline are force-destroyed.

```scala
override def destroyForcibly(): Unit = ...
```

> Alias for [[destroy]], implemented for [[java.lang.AutoCloseable]].

```scala
override def close(): Unit = ...
```

> Wait up to `millis` for the [[ProcessPipeline]] to terminate, by default waits
> indefinitely. Returns `true` if the [[ProcessPipeline]] has terminated by the time
> this method returns.
>
> Waits for each process one by one, while aggregating the total time waited. If
> [[timeout]] has passed before all processes have terminated, returns `false`.

```scala
override def waitFor(timeout: Long = -1): Boolean = ...
```

> Wait up to `millis` for the [[ProcessPipeline]] to terminate all the processes
> in pipeline. By default waits indefinitely; if a time limit is given, explicitly
> destroys each process if it has not completed by the time the timeout has occurred.

```scala
override def join(timeout: Long = -1): Boolean = ...
```

> Represents the configuration of a SubProcess's input stream. Can either be
> [[os.Inherit]], [[os.Pipe]], [[os.Path]] or a [[os.Source]]

```scala
trait ProcessInput
```

```scala
def redirectFrom: ProcessBuilder.Redirect
```

```scala
def processInput(stdin: => SubProcess.InputStream): Option[Runnable]
```

```scala
object ProcessInput
```

```scala
implicit def makeSourceInput[T](r: T)(implicit f: T => Source): ProcessInput = ...
```

```scala
implicit def makePathRedirect(p: Path): ProcessInput = ...
```

```scala
case class SourceInput(r: Source) extends ProcessInput
```

```scala
def redirectFrom = ...
```

```scala
def processInput(stdin: => SubProcess.InputStream): Option[Runnable] = ...
```

> Represents the configuration of a SubProcess's output or error stream. Can
> either be [[os.Inherit]], [[os.Pipe]], [[os.Path]] or a [[os.ProcessOutput]]

```scala
trait ProcessOutput
```

```scala
def redirectTo: ProcessBuilder.Redirect
```

```scala
def processOutput(out: => SubProcess.OutputStream): Option[Runnable]
```

```scala
object ProcessOutput
```

```scala
implicit def makePathRedirect(p: Path): ProcessOutput = ...
```

```scala
def apply(f: (Array[Byte], Int) => Unit) = ...
```

```scala
case class ReadBytes(f: (Array[Byte], Int) => Unit)
```

```scala
def redirectTo = ...
```

```scala
def processOutput(out: => SubProcess.OutputStream) = ...
```

```scala
case class Readlines(f: String => Unit)
```

```scala
def redirectTo = ...
```

```scala
def processOutput(out: => SubProcess.OutputStream) = ...
```

> Inherit the input/output stream from the current process

```scala
object Inherit extends ProcessInput with ProcessOutput
```

```scala
def redirectTo = ...
```

```scala
def redirectFrom = ...
```

```scala
def processInput(stdin: => SubProcess.InputStream) = ...
```

```scala
def processOutput(stdin: => SubProcess.OutputStream) = ...
```

> Pipe the input/output stream to the current process to be used via
> `java.lang.Process#{getInputStream,getOutputStream,getErrorStream}`

```scala
object Pipe extends ProcessInput with ProcessOutput
```

```scala
def redirectTo = ...
```

```scala
def redirectFrom = ...
```

```scala
def processInput(stdin: => SubProcess.InputStream) = ...
```

```scala
def processOutput(stdin: => SubProcess.OutputStream) = ...
```

```scala
case class PathRedirect(p: Path) extends ProcessInput with ProcessOutput
```

```scala
def redirectFrom = ...
```

```scala
def processInput(stdin: => SubProcess.InputStream) = ...
```

```scala
def redirectTo = ...
```

```scala
def processOutput(out: => SubProcess.OutputStream) = ...
```

```scala
case class PathAppendRedirect(p: Path) extends ProcessOutput
```

```scala
def redirectTo = ...
```

```scala
def processOutput(out: => SubProcess.OutputStream) = ...
```

#### `TempOps.scala`

> Alias for `java.nio.file.Files.createTempFile` and
> `java.io.File.deleteOnExit`. Pass in `deleteOnExit = false` if you want
> the temp file to stick around.

```scala
object temp
```

> Creates a temporary file. You can optionally provide a `dir` to specify where
> this file lives, file-`prefix` and file-`suffix` to customize what it looks
> like, and a [[PermSet]] to customize its filesystem permissions.
>
> Passing in a [[os.Source]] will initialize the contents of that file to
> the provided data; otherwise it is created empty.
>
> By default, temporary files are deleted on JVM exit. You can disable that
> behavior by setting `deleteOnExit = false`

```scala
def apply(
      contents: Source = null,
      dir: Path = null,
      prefix: String = null,
      suffix: String = null,
      deleteOnExit: Boolean = true,
      perms: PermSet = null
  ): Path = ...
```

> Creates a temporary directory. You can optionally provide a `dir` to specify
> where this file lives, a `prefix` to customize what it looks like, and a
> [[PermSet]] to customize its filesystem permissions.
>
> By default, temporary directories are deleted on JVM exit. You can disable that
> behavior by setting `deleteOnExit = false`

```scala
def dir(
      dir: Path = null,
      prefix: String = null,
      deleteOnExit: Boolean = true,
      perms: PermSet = null
  ): Path = ...
```

#### `package.scala`

```scala
package object os
```

```scala
type Generator[+T] = ...
```

```scala
val Generator = ...
```

```scala
implicit def GlobSyntax(s: StringContext): GlobInterpolator = ...
```

> The root of the filesystem

```scala
val root: Path = ...
```

```scala
def root(root: String, fileSystem: FileSystem = FileSystems.getDefault()): Path = ...
```

```scala
def resource(implicit resRoot: ResourceRoot = Thread.currentThread().getContextClassLoader) = ...
```

> The user's home directory

```scala
def home: Path = ...
```

> The current working directory for this process.

```scala
val pwd: Path = ...
```

```scala
val up: RelPath = ...
```

```scala
val rel: RelPath = ...
```

```scala
val sub: SubPath = ...
```

> Extractor to let you easily pattern match on [[os.Path]]s. Lets you do
>
> {{{
> @ val base/segment/filename = pwd
> base: Path = Path(Vector("Users", "haoyi", "Dropbox (Personal)"))
> segment: String = "Workspace"
> filename: String = "Ammonite"
> }}}
>
> To break apart a path and extract various pieces of it.

```scala
object /
```

```scala
def unapply(p: Path): Option[(Path, String)] = ...
```

