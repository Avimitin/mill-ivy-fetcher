# Coursier 2.1.25-M3 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `1412` non-private declaration signatures from `163` source files.

## Coordinates
- Direct dependency: `io.get-coursier:coursier_2.13:2.1.25-M3`
- Upstream docs: https://get-coursier.io/docs/api
- Source artifacts included:
  - `io.get-coursier:coursier_2.13:2.1.25-M3`
  - `io.get-coursier:coursier-core_2.13:2.1.25-M3`
  - `io.get-coursier:coursier-cache_2.13:2.1.25-M3`
  - `io.get-coursier:coursier-proxy-setup:2.1.25-M3`
  - `io.get-coursier:dependency_2.13:0.3.2`

## Common imports

```scala
import coursier.*
import coursier.cache.FileCache
```

## Usage notes

Dependency resolution/fetching library. This doc includes the high-level `coursier` module plus core/cache/proxy/dependency source artifacts that expose `Fetch`, `Dependency`, `Module`, `Repositories`, `FileCache`, and Maven repository APIs.

```scala
import coursier.*
import coursier.cache.FileCache

val dep = Dependency(
  Module(Organization("com.lihaoyi"), ModuleName("os-lib_3"), Map.empty),
  VersionConstraint("0.10.0")
)

val result = Fetch()
  .addDependencies(dep)
  .withRepositories(Seq(Repositories.central))
  .withCache(FileCache().withLocation((os.pwd / ".mif" / "coursier-cache").toIO))
  .runResult()
```

## API signatures from upstream source

### `io.get-coursier:coursier_2.13:2.1.25-M3`

Source: https://repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M3/coursier_2.13-2.1.25-M3-sources.jar

#### `coursier/Artifacts.scala`

```scala
object Artifacts
```

```scala
def apply(): Artifacts[Task] = ...
```

```scala
implicit class ArtifactsTaskOps(private val artifacts: Artifacts[Task]) extends AnyVal
```

```scala
def future()(implicit
      ec: ExecutionContext = artifacts.cache.ec
    ): Future[Seq[(Artifact, File)]] = ...
```

```scala
def either()(implicit
      ec: ExecutionContext = artifacts.cache.ec
    ): Either[FetchError, Seq[(Artifact, File)]] = ...
```

```scala
def run()(implicit ec: ExecutionContext = artifacts.cache.ec): Seq[(Artifact, File)] = ...
```

```scala
def futureResult()(implicit ec: ExecutionContext = artifacts.cache.ec): Future[Result] = ...
```

```scala
def eitherResult()(implicit
      ec: ExecutionContext = artifacts.cache.ec
    ): Either[FetchError, Result] = ...
```

```scala
def runResult()(implicit ec: ExecutionContext = artifacts.cache.ec): Result = ...
```

```scala
def defaultTypes(
    classifiers: Set[Classifier] = Set.empty,
    mainArtifactsOpt: Option[Boolean] = None
  ): Set[Type] = ...
```

```scala
  @deprecated("Use artifacts0 instead", "2.1.25")
def artifacts(
    resolution: Resolution,
    classifiers: Set[Classifier],
    mainArtifactsOpt: Option[Boolean],
    artifactTypesOpt: Option[Set[Type]],
    classpathOrder: Boolean
  ): Seq[(Dependency, Publication, Artifact)] = ...
```

```scala
def artifacts0(
    resolution: Resolution,
    classifiers: Set[Classifier],
    mainArtifactsOpt: Option[Boolean],
    artifactTypesOpt: Option[Set[Type]],
    classpathOrder: Boolean
  ): Seq[(Dependency, Either[VariantPublication, Publication], Artifact)] = ...
```

#### `coursier/Fetch.scala`

```scala
object Fetch
```

```scala
def apply(): Fetch[Task] = ...
```

```scala
def apply[F[_]](cache: Cache[F])(implicit S: Sync[F]): Fetch[F] = ...
```

```scala
implicit class FetchTaskOps(private val fetch: Fetch[Task]) extends AnyVal
```

```scala
def futureResult()(implicit ec: ExecutionContext = fetch.resolve.cache.ec): Future[Result] = ...
```

```scala
def future()(implicit ec: ExecutionContext = fetch.resolve.cache.ec): Future[Seq[File]] = ...
```

```scala
def eitherResult()(implicit
      ec: ExecutionContext = fetch.resolve.cache.ec
    ): Either[CoursierError, Result] = ...
```

```scala
def either()(implicit
      ec: ExecutionContext = fetch.resolve.cache.ec
    ): Either[CoursierError, Seq[File]] = ...
```

```scala
def runResult()(implicit ec: ExecutionContext = fetch.resolve.cache.ec): Result = ...
```

```scala
def run()(implicit ec: ExecutionContext = fetch.resolve.cache.ec): Seq[File] = ...
```

#### `coursier/LocalRepositories.scala`

```scala
object LocalRepositories
```

```scala
lazy val ivy2Local = ...
```

> These repositories aren't guaranteed to always work fine with coursier (they sometimes have
> only the metadata of some dependencies, and coursier isn't fine with that - coursier requires
> both the metadata and the JARs to be in the same repo) see
> https://github.com/coursier/coursier/pull/868#issuecomment-398779799

```scala
object Dangerous
```

```scala
lazy val maven2Local = ...
```

```scala
lazy val ivy2Cache = ...
```

#### `coursier/PlatformResolve.scala`

```scala
abstract class PlatformResolve
```

```scala
type Path = ...
```

```scala
def defaultConfFiles: Seq[Path] = ...
```

```scala
def defaultMirrorConfFiles: Seq[MirrorConfFile] = ...
```

```scala
def confFileMirrors(confFile: Path): Seq[Mirror] = ...
```

```scala
def confFileRepositories(confFile: Path): Option[Seq[Repository]] = ...
```

```scala
lazy val defaultRepositories: Seq[Repository] = ...
```

```scala
def proxySetup(): Unit = ...
```

#### `coursier/error/FetchError.scala`

```scala
sealed abstract class FetchError(message: String, cause: Throwable = null)
```

```scala
object FetchError
```

```scala
final class DownloadingArtifacts(val errors: Seq[(Artifact, ArtifactError)]) extends FetchError(
    "Error fetching artifacts:" + System.lineSeparator() +
      errors.map { case (a, e) =>
        s"${a.url}: ${e.describe}" + System.lineSeparator()
      }.mkString,
    errors.headOption.map(_._2).orNull
  )
```

#### `coursier/internal/Defaults.scala`

```scala
object Defaults
```

```scala
def scalaVersion: String = ...
```

```scala
def scalaVersionConstraint: VersionConstraint = ...
```

#### `coursier/internal/FetchCache.scala`

```scala
object FetchCache
```

#### `coursier/internal/InMemoryCachingFetcher.scala`

> For benchmarking purposes

```scala
final class InMemoryCachingFetcher[F[_]](underlying: Repository.Fetch[F])(implicit S: Sync[F])
```

```scala
def onlyCache(): Unit = ...
```

```scala
def fromCache(url: String): String = ...
```

```scala
def fetcher: Repository.Fetch[F] = ...
```

#### `coursier/internal/PlatformMirrorConfFile.scala`

```scala
abstract class PlatformMirrorConfFile
```

```scala
def path: String
```

```scala
def optional: Boolean
```

```scala
def mirrors(): Seq[Mirror] = ...
```

#### `coursier/internal/PlatformRepositoryParser.scala`

```scala
abstract class PlatformRepositoryParser
```

```scala
def repository(input: String): Either[String, Repository] = ...
```

```scala
def repository(input: String, maybeFile: Boolean): Either[String, Repository] = ...
```

#### `coursier/util/InMemoryRepository.scala`

```scala
object InMemoryRepository
```

```scala
def forDependencies(dependencies: (Dependency, String)*): InMemoryRepository = ...
```

```scala
  @deprecated("Use the override accepting a cache", "2.0.0-RC3")
def exists(
    url: URL,
    localArtifactsShouldBeCached: Boolean
  ): Boolean = ...
```

```scala
def exists(
    url: URL,
    localArtifactsShouldBeCached: Boolean,
    cacheOpt: Option[FileCache[Nothing]]
  ): Boolean = ...
```

```scala
  @deprecated("Use the override accepting a cache", "2.0.0-RC3")
def apply(
    fallbacks: Map[(Module, String), (URL, Boolean)]
  ): InMemoryRepository = ...
```

```scala
  @deprecated("Use the override accepting a cache", "2.0.0-RC3")
def apply(
    fallbacks: Map[(Module, String), (URL, Boolean)],
    localArtifactsShouldBeCached: Boolean
  ): InMemoryRepository = ...
```

```scala
def create[F[_]](
    fallbacks: Map[(Module, Version0), (URL, Boolean)],
    cache: FileCache[F]
  ): InMemoryRepository = ...
```

```scala
  @deprecated("Use create instead", "2.1.25")
def apply[F[_]](
    fallbacks: Map[(Module, String), (URL, Boolean)],
    cache: FileCache[F]
  ): InMemoryRepository = ...
```

```scala
def apply(
    fallbacks0: Map[(Module, String), (URL, Boolean)],
    localArtifactsShouldBeCached: Boolean,
    cacheOpt: Option[FileCache[Nothing]]
  ): InMemoryRepository = ...
```

#### `scala/coursier/Repositories.scala`

```scala
object Repositories
```

```scala
def central: MavenRepository = ...
```

```scala
def sonatype(name: String): MavenRepository = ...
```

```scala
def sonatypeS01(name: String): MavenRepository = ...
```

```scala
def bintray(id: String): MavenRepository = ...
```

```scala
def bintray(owner: String, repo: String): MavenRepository = ...
```

```scala
def bintrayIvy(id: String): IvyRepository = ...
```

```scala
def typesafe(id: String): MavenRepository = ...
```

```scala
def typesafeIvy(id: String): IvyRepository = ...
```

```scala
def sbtPlugin(id: String): IvyRepository = ...
```

```scala
def sbtMaven(id: String): MavenRepository = ...
```

```scala
def scalaIntegration: MavenRepository = ...
```

```scala
def jitpack: MavenRepository = ...
```

```scala
def clojars: MavenRepository = ...
```

```scala
def jcenter: MavenRepository = ...
```

```scala
def google: MavenRepository = ...
```

```scala
def centralGcs: MavenRepository = ...
```

```scala
def centralGcsEu: MavenRepository = ...
```

```scala
def centralGcsAsia: MavenRepository = ...
```

```scala
def apache(id: String): MavenRepository = ...
```

#### `scala/coursier/Resolve.scala`

```scala
object Resolve extends PlatformResolve
```

```scala
def apply(): Resolve[Task] = ...
```

```scala
implicit class ResolveTaskOps(private val resolve: Resolve[Task]) extends AnyVal
```

```scala
def future()(implicit ec: ExecutionContext = resolve.cache.ec): Future[Resolution] = ...
```

```scala
def either()(implicit
      ec: ExecutionContext = resolve.cache.ec
    ): Either[ResolutionError, Resolution] = ...
```

```scala
def futureEither()(implicit
      ec: ExecutionContext = resolve.cache.ec
    ): Future[Either[ResolutionError, Resolution]] = ...
```

```scala
def run()(implicit ec: ExecutionContext = resolve.cache.ec): Resolution = ...
```

```scala
def validate(res: Resolution): ValidationNel[ResolutionError, Unit] = ...
```

#### `scala/coursier/Versions.scala`

```scala
object Versions
```

```scala
def apply(): Versions[Task] = ...
```

```scala
implicit class VersionsTaskOps(private val versions: Versions[Task]) extends AnyVal
```

```scala
def futureResult()(implicit ec: ExecutionContext = versions.cache.ec): Future[Result] = ...
```

```scala
def future()(implicit
      ec: ExecutionContext = versions.cache.ec
    ): Future[coursier.core.Versions] = ...
```

```scala
def eitherResult()(implicit
      ec: ExecutionContext = versions.cache.ec
    ): Either[CoursierError, Result] = ...
```

```scala
def either()(implicit
      ec: ExecutionContext = versions.cache.ec
    ): Either[CoursierError, coursier.core.Versions] = ...
```

```scala
def runResult()(implicit ec: ExecutionContext = versions.cache.ec): Result = ...
```

```scala
def run()(implicit ec: ExecutionContext = versions.cache.ec): coursier.core.Versions = ...
```

#### `scala/coursier/complete/Complete.scala`

```scala
object Complete
```

```scala
def apply(): Complete[Task] = ...
```

```scala
def scalaBinaryVersion(scalaVersion: String): String = ...
```

#### `scala/coursier/error/CoursierError.scala`

```scala
abstract class CoursierError(message: String, cause: Throwable = null)
```

#### `scala/coursier/error/ResolutionError.scala`

```scala
sealed abstract class ResolutionError(
  val resolution: Resolution,
  message: String,
  cause: Throwable = null
) extends CoursierError(message, cause)
```

```scala
def errors: Seq[ResolutionError.Simple]
```

```scala
object ResolutionError
```

```scala
final class MaximumIterationReached(resolution: Resolution) extends Simple(
    resolution,
    "Maximum number of iterations reached"
  )
```

```scala
final class CantDownloadModule(
    resolution: Resolution,
    val module: Module,
    val versionConstraint: VersionConstraint,
    val perRepositoryErrors: Seq[String]
  ) extends Simple(
    resolution,
    s"Error downloading $module:${versionConstraint.asString}" + System.lineSeparator() +
      perRepositoryErrors
        .map { err =>
          "  " + err.replace(System.lineSeparator(), "  " + System.lineSeparator())
        }
        .mkString(System.lineSeparator())
  )
```

```scala
    @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def this(
      resolution: Resolution,
      module: Module,
      version: String,
      perRepositoryErrors: Seq[String]
    ) = ...
```

```scala
    @deprecated("Use version0 instead", "2.1.25")
def version: String = ...
```

```scala
final class ConflictingDependencies(
    resolution: Resolution,
    val dependencies: Set[Dependency]
  ) extends Simple(resolution, conflictingDependenciesErrorMessage(resolution))
```

```scala
sealed abstract class Simple(resolution: Resolution, message: String, cause: Throwable = null)
```

```scala
def errors: Seq[ResolutionError.Simple] = ...
```

```scala
final class Several(val head: Simple, val tail: Seq[Simple]) extends ResolutionError(
    head.resolution,
    (head +: tail).map(_.getMessage).mkString(System.lineSeparator())
  )
```

```scala
def errors: Seq[ResolutionError.Simple] = ...
```

```scala
def from(head: ResolutionError, tail: ResolutionError*): ResolutionError = ...
```

```scala
abstract class UnsatisfiableRule(
    resolution: Resolution,
    val rule: Rule,
    val conflict: UnsatisfiedRule,
    message: String
  ) extends Simple(resolution, message, conflict)
```

#### `scala/coursier/error/conflict/StrictRule.scala`

```scala
final class StrictRule(
  resolution: Resolution,
  rule: Rule,
  conflict: UnsatisfiedRule
) extends UnsatisfiableRule(
  resolution,
  rule,
  conflict,
  s"Rule $rule not satisfied: $conflict"
)
```

#### `scala/coursier/error/conflict/UnsatisfiedRule.scala`

```scala
abstract class UnsatisfiedRule(
  val rule: Rule,
  message: String,
  cause: Throwable = null
) extends Exception(s"Unsatisfied rule ${rule.repr}: $message", cause)
```

#### `scala/coursier/internal/SharedRepositoryParser.scala`

```scala
object SharedRepositoryParser
```

```scala
def repository(s: String): Either[String, Repository] = ...
```

#### `scala/coursier/internal/Typelevel.scala`

```scala
object Typelevel
```

```scala
val mainLineOrg = ...
```

```scala
val typelevelOrg = ...
```

```scala
val modules = ...
```

```scala
def swap(module: Module): Module = ...
```

```scala
val swap: Dependency = ...
```

#### `scala/coursier/package.scala`

> Mainly pulls definitions from coursier.core, sometimes with default arguments.

```scala
package object coursier
```

```scala
type Organization = ...
```

```scala
val Organization = ...
```

```scala
type ModuleName = ...
```

```scala
val ModuleName = ...
```

```scala
type Dependency = ...
```

```scala
object Dependency
```

```scala
def apply(
      module: Module,
      version: VersionConstraint0
    ): Dependency = ...
```

```scala
    @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def apply(
      module: Module,
      version: String
    ): Dependency = ...
```

```scala
type VersionConstraint = ...
```

```scala
val VersionConstraint = ...
```

```scala
type Variant = ...
```

```scala
val Variant = ...
```

```scala
type VariantSelector = ...
```

```scala
val VariantSelector = ...
```

```scala
type BomDependency = ...
```

```scala
val BomDependency = ...
```

```scala
type Attributes = ...
```

```scala
object Attributes extends Serializable
```

```scala
def apply(
      `type`: Type = Type.empty,
      classifier: Classifier = Classifier.empty
    ): Attributes = ...
```

```scala
type Project = ...
```

```scala
val Project = ...
```

```scala
type Info = ...
```

```scala
val Info = ...
```

```scala
type Profile = ...
```

```scala
val Profile = ...
```

```scala
type Module = ...
```

```scala
object Module extends Serializable
```

```scala
def apply(
      organization: Organization,
      name: ModuleName,
      attributes: Map[String, String] = Map.empty
    ): Module = ...
```

```scala
type ModuleVersion = ...
```

```scala
type ProjectCache = ...
```

```scala
type Repository = ...
```

```scala
val Repository = ...
```

```scala
type MavenRepository = ...
```

```scala
val MavenRepository = ...
```

```scala
type Resolution = ...
```

```scala
object Resolution
```

```scala
val empty = ...
```

```scala
def apply(): Resolution = ...
```

```scala
def apply(dependencies: Seq[Dependency]): Resolution = ...
```

```scala
def defaultTypes: Set[Type] = ...
```

```scala
def enableDependencyOverridesDefault = ...
```

```scala
type Classifier = ...
```

```scala
val Classifier = ...
```

```scala
type Type = ...
```

```scala
val Type = ...
```

```scala
type ResolutionProcess = ...
```

```scala
val ResolutionProcess = ...
```

```scala
implicit class ResolutionExtensions(val underlying: Resolution) extends AnyVal
```

```scala
def process: ResolutionProcess = ...
```

```scala
implicit def organizationString(sc: StringContext): SafeOrganization = ...
```

```scala
implicit def moduleNameString(sc: StringContext): SafeModuleName = ...
```

```scala
implicit def moduleString(sc: StringContext): SafeModule = ...
```

```scala
implicit def moduleExclString(sc: StringContext): SafeModuleExclusionMatcher = ...
```

```scala
implicit def moduleInclString(sc: StringContext): SafeModuleInclusionMatcher = ...
```

```scala
implicit def dependencyString(sc: StringContext): SafeDependency = ...
```

```scala
implicit def mavenRepositoryString(sc: StringContext): SafeMavenRepository = ...
```

```scala
implicit def ivyRepositoryString(sc: StringContext): SafeIvyRepository = ...
```

#### `scala/coursier/params/MavenMirror.scala`

```scala
object MavenMirror
```

```scala
def apply(to: String, first: String, others: String*): MavenMirror = ...
```

#### `scala/coursier/params/Mirror.scala`

```scala
abstract class Mirror extends Serializable
```

```scala
def matches(repo: Repository): Option[Repository]
```

```scala
object Mirror
```

```scala
def replace(repositories: Seq[Repository], mirrors: Seq[Mirror]): Seq[Repository] = ...
```

```scala
def parse(input: String): Either[String, Mirror] = ...
```

#### `scala/coursier/params/TreeMirror.scala`

```scala
object TreeMirror
```

```scala
def apply(to: String, first: String, others: String*): TreeMirror = ...
```

#### `scala/coursier/params/rule/AlwaysFail.scala`

```scala
object AlwaysFail
```

```scala
final class Nope(override val rule: AlwaysFail) extends UnsatisfiedRule(rule, "nope")
```

```scala
final class NopityNope(resolution: Resolution, rule: AlwaysFail, conflict: Nope)
```

#### `scala/coursier/params/rule/DontBumpRootDependencies.scala`

```scala
object DontBumpRootDependencies
```

```scala
def apply(): DontBumpRootDependencies = ...
```

```scala
final class BumpedRootDependencies(
    val bumpedRootDependencies: Seq[(Dependency, String)],
    override val rule: DontBumpRootDependencies
  ) extends UnsatisfiedRule(
        rule,
        s"Some root dependency versions were bumped: " +
          bumpedRootDependencies.map(d => s"${d._1.module}:${d._1.versionConstraint.asString}")
            .toVector
            .sorted
            .mkString(", ")
      )
```

```scala
final class CantForceRootDependencyVersions(
    resolution: Resolution,
    cantBump: Map[Module, VersionConstraint],
    conflict: BumpedRootDependencies,
    override val rule: DontBumpRootDependencies
  ) extends UnsatisfiableRule(
        resolution,
        rule,
        conflict, {
          val mods = cantBump
            .toVector
            .map {
              case (k, v) =>
                s"$k ($v)"
            }
            .sorted
            .mkString(", ")
          // FIXME More detailed message? (say why it can't be forced)
          s"Can't force version of modules $mods"
        }
      )
```

#### `scala/coursier/params/rule/Rule.scala`

```scala
abstract class Rule extends Product with Serializable
```

```scala
type C <: UnsatisfiedRule
```

```scala
def check(res: Resolution): Option[C]
```

```scala
def tryResolve(res: Resolution, conflict: C): Either[UnsatisfiableRule, Resolution]
```

```scala
def enforce(
    res: Resolution,
    ruleRes: RuleResolution
  ): Either[UnsatisfiableRule, Either[UnsatisfiedRule, Option[Resolution]]] = ...
```

```scala
def repr: String = ...
```

#### `scala/coursier/params/rule/RuleResolution.scala`

```scala
sealed abstract class RuleResolution extends Product with Serializable
```

```scala
def isWarn: Boolean = ...
```

```scala
object RuleResolution
```

```scala
case object TryResolve extends RuleResolution
```

```scala
case object Warn       extends RuleResolution
```

```scala
case object Fail       extends RuleResolution
```

#### `scala/coursier/params/rule/SameVersion.scala`

```scala
object SameVersion
```

```scala
def apply(module: Module, other: Module*): SameVersion = ...
```

```scala
final class SameVersionConflict(
    override val rule: SameVersion,
    val modules: Set[Module],
    val foundVersions: Set[VersionConstraint]
  ) extends UnsatisfiedRule(
        rule,
        s"Found versions ${foundVersions.toVector.sorted.map(_.asString).mkString(", ")} " +
          s"for ${modules.toVector.map(_.toString).sorted.mkString(", ")}"
      )
```

```scala
final class CantForceSameVersion(
    resolution: Resolution,
    override val rule: SameVersion,
    modules: Set[Module],
    version: Version,
    conflict: SameVersionConflict
  ) extends UnsatisfiableRule(
        resolution,
        rule,
        conflict,
        // FIXME More detailed message? (say why it can't be forced)
        s"Can't force version ${version.asString} for modules ${modules.toVector.map(_.toString).mkString(", ")}"
      )
```

```scala
    @deprecated("Use the override accepting a coursier.version.Version instead", "2.1.25")
def this(
      resolution: Resolution,
      rule: SameVersion,
      modules: Set[Module],
      version: String,
      conflict: SameVersionConflict
    ) = ...
```

#### `scala/coursier/params/rule/Strict.scala`

```scala
object Strict
```

```scala
final class EvictedDependencies(
    override val rule: Strict,
    val evicted: Seq[Conflicted]
  ) extends UnsatisfiedRule(
        rule,
        s"Found evicted dependencies:" + System.lineSeparator() +
          evicted.map(_.repr + System.lineSeparator()).mkString
      )
```

```scala
final class UnsatisfiableRule(
    resolution: Resolution,
    override val rule: Strict,
    override val conflict: EvictedDependencies
  ) extends coursier.error.ResolutionError.UnsatisfiableRule(
        resolution,
        rule,
        conflict,
        conflict.getMessage
      )
```

#### `scala/coursier/parse/DependencyParser.scala`

> These are not meant to be used by coursier users. Better coursier/dependency based parsers to
> come.

```scala
object DependencyParser
```

```scala
def dependency(
    input: String,
    defaultScalaVersion: String
  ): Either[String, Dependency] = ...
```

```scala
def dependency(
    input: String,
    defaultScalaVersion: String,
    defaultConfiguration: Configuration
  ): Either[String, Dependency] = ...
```

```scala
def dependencies(
    inputs: Seq[String],
    defaultScalaVersion: String
  ): ValidationNel[String, Seq[Dependency]] = ...
```

```scala
def dependencies(
    inputs: Seq[String],
    defaultScalaVersion: String,
    defaultConfiguration: Configuration
  ): ValidationNel[String, Seq[Dependency]] = ...
```

```scala
def javaOrScalaDependencies(
    inputs: Seq[String]
  ): ValidationNel[String, Seq[JavaOrScalaDependency]] = ...
```

```scala
def javaOrScalaDependencies(
    inputs: Seq[String],
    defaultConfiguration: Configuration
  ): ValidationNel[String, Seq[JavaOrScalaDependency]] = ...
```

> Parses coordinates like org:name:version possibly with attributes, like
> org:name;attr1=val1;attr2=val2:version

```scala
def moduleVersion0(
    input: String,
    defaultScalaVersion: String
  ): Either[String, (Module, VersionConstraint)] = ...
```

```scala
  @deprecated("Use moduleVersion0 instead", "2.1.25")
def moduleVersion(
    input: String,
    defaultScalaVersion: String
  ): Either[String, (Module, String)] = ...
```

```scala
def moduleVersions0(
    inputs: Seq[String],
    defaultScalaVersion: String
  ): ValidationNel[String, Seq[(Module, VersionConstraint)]] = ...
```

```scala
  @deprecated("Use moduleVersions0 instead", "2.1.25")
def moduleVersions(
    inputs: Seq[String],
    defaultScalaVersion: String
  ): ValidationNel[String, Seq[(Module, String)]] = ...
```

```scala
def dependencyParams(
    input: String,
    defaultScalaVersion: String
  ): Either[String, (Dependency, Map[String, String])] = ...
```

```scala
def javaOrScalaDependencyParams(
    input: String
  ): Either[String, (JavaOrScalaDependency, Map[String, String])] = ...
```

> Parses coordinates like org:name:version with attributes, like
> org:name:version,attr1=val1,attr2=val2 and a configuration, like org:name:version:config or
> org:name:version:config,attr1=val1,attr2=val2
>
> Currently only the "classifier" and "url attributes are used, and others throw errors.

```scala
def javaOrScalaDependencyParams(
    input: String,
    defaultConfiguration: Configuration
  ): Either[String, (JavaOrScalaDependency, Map[String, String])] = ...
```

> Parses coordinates like org:name:version with attributes, like
> org:name:version,attr1=val1,attr2=val2 and a configuration, like org:name:version:config or
> org:name:version:config,attr1=val1,attr2=val2
>
> Currently only the "classifier", "type", "extension", and "url attributes are used, and others
> throw errors.

```scala
def dependencyParams(
    input: String,
    defaultScalaVersion: String,
    defaultConfiguration: Configuration
  ): Either[String, (Dependency, Map[String, String])] = ...
```

```scala
def dependenciesParams(
    inputs: Seq[String],
    defaultConfiguration: Configuration,
    defaultScalaVersion: String
  ): ValidationNel[String, Seq[(Dependency, Map[String, String])]] = ...
```

```scala
def javaOrScalaDependenciesParams(
    inputs: Seq[String]
  ): ValidationNel[String, Seq[(JavaOrScalaDependency, Map[String, String])]] = ...
```

```scala
def javaOrScalaDependenciesParams(
    inputs: Seq[String],
    defaultConfiguration: Configuration
  ): ValidationNel[String, Seq[(JavaOrScalaDependency, Map[String, String])]] = ...
```

#### `scala/coursier/parse/JavaOrScalaDependency.scala`

```scala
sealed abstract class JavaOrScalaDependency extends Product with Serializable
```

```scala
def module: JavaOrScalaModule
```

```scala
def versionConstraint: VersionConstraint
```

```scala
def exclude: Set[JavaOrScalaModule]
```

```scala
def addExclude(excl: JavaOrScalaModule*): JavaOrScalaDependency
```

```scala
def dependency(scalaBinaryVersion: String, scalaVersion: String, platformName: String): Dependency
```

```scala
def withPlatform(platformSuffix: String): JavaOrScalaDependency
```

```scala
def withUnderlyingDependency(f: Dependency => Dependency): JavaOrScalaDependency
```

```scala
final def dependency(scalaVersion: String): Dependency = ...
```

```scala
  @deprecated("Use versionConstraint instead", "2.1.25")
def version: String = ...
```

```scala
object JavaOrScalaDependency
```

```scala
def apply(mod: JavaOrScalaModule, dep: Dependency): JavaOrScalaDependency = ...
```

```scala
def leftOverUserParams(dep: dependency.AnyDependency): Seq[(String, Option[String])] = ...
```

```scala
  @deprecated("Use from0 instead", "2.1.25")
def from(dep: dependency.AnyDependency): Either[String, JavaOrScalaDependency] = ...
```

```scala
def from0(dep: dependency.AnyDependency)
```

#### `scala/coursier/parse/JavaOrScalaModule.scala`

```scala
sealed abstract class JavaOrScalaModule extends Product with Serializable
```

```scala
def attributes: Map[String, String]
```

```scala
def module(scalaBinaryVersion: String, scalaVersion: String): Module
```

```scala
final def module(scalaVersion: String): Module = ...
```

```scala
object JavaOrScalaModule
```

```scala
def scalaBinaryVersion(scalaVersion: String): String = ...
```

#### `scala/coursier/parse/JsonRuleParser.scala`

```scala
class JsonRuleParser(
  defaultScalaVersion: String,
  defaultRuleResolution: RuleResolution
)
```

```scala
def parseRule(s: String): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def parseRule(b: Array[Byte]): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def parseRules(s: String): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

```scala
def parseRules(b: Array[Byte]): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

```scala
object JsonRuleParser
```

```scala
def parseRule(
    s: String,
    defaultScalaVersion: String,
    defaultRuleResolution: RuleResolution = RuleResolution.TryResolve
  ): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def parseRule(
    content: Array[Byte],
    defaultScalaVersion: String,
    defaultRuleResolution: RuleResolution
  ): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def parseRule(
    content: Array[Byte],
    defaultScalaVersion: String
  ): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def parseRules(
    s: String,
    defaultScalaVersion: String,
    defaultRuleResolution: RuleResolution = RuleResolution.TryResolve
  ): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

```scala
def parseRules(
    content: Array[Byte],
    defaultScalaVersion: String,
    defaultRuleResolution: RuleResolution
  ): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

```scala
def parseRules(
    content: Array[Byte],
    defaultScalaVersion: String
  ): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

#### `scala/coursier/parse/ModuleParser.scala`

```scala
object ModuleParser
```

> Parses a module like org:name possibly with attributes, like org:name;attr1=val1;attr2=val2
>
> Two semi-columns after the org part is interpreted as a scala module. E.g. if the scala
> version is 2.11., org::name is equivalent to org:name_2.11.

```scala
def javaOrScalaModule(s: String): Either[String, JavaOrScalaModule] = ...
```

> Parses a module like org:name possibly with attributes, like org:name;attr1=val1;attr2=val2
>
> Two semi-columns after the org part is interpreted as a scala module. E.g. if
> `defaultScalaVersion` is `"2.11.x"`, org::name is equivalent to org:name_2.11.

```scala
def module(s: String, defaultScalaVersion: String): Either[String, Module] = ...
```

```scala
def javaOrScalaModules(
    inputs: Seq[String]
  ): ValidationNel[String, Seq[JavaOrScalaModule]] = ...
```

```scala
def modules(
    inputs: Seq[String],
    defaultScalaVersion: String
  ): ValidationNel[String, Seq[Module]] = ...
```

#### `scala/coursier/parse/RawJson.scala`

```scala
final case class RawJson(value: Array[Byte])
```

```scala
override lazy val hashCode: Int = ...
```

```scala
override def equals(obj: Any): Boolean = ...
```

```scala
override def toString: String = ...
```

```scala
object RawJson
```

```scala
implicit val codec: JsonValueCodec[RawJson] = ...
```

```scala
val emptyObj: RawJson = ...
```

#### `scala/coursier/parse/ReconciliationParser.scala`

```scala
object ReconciliationParser
```

```scala
def reconciliation0(
    input: Seq[String],
    scalaVersionOrDefault: String
  ): ValidationNel[String, Seq[(ModuleMatchers, ConstraintReconciliation)]] = ...
```

```scala
  @deprecated("Use reconciliation0 instead", "2.1.25")
def reconciliation(
    input: Seq[String],
    scalaVersionOrDefault: String
  ): ValidationNel[String, Seq[(ModuleMatchers, coursier.core.Reconciliation)]] = ...
```

#### `scala/coursier/parse/RepositoryParser.scala`

```scala
object RepositoryParser extends PlatformRepositoryParser
```

```scala
def repositories(inputs: Seq[String]): ValidationNel[String, Seq[Repository]] = ...
```

#### `scala/coursier/parse/RuleParser.scala`

```scala
object RuleParser
```

```scala
def rule(input: String): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def rule(
    input: String,
    defaultResolution: RuleResolution
  ): Either[String, (Rule, RuleResolution)] = ...
```

```scala
def rules(input: String): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

```scala
def rules(
    input: String,
    defaultResolution: RuleResolution
  ): Either[String, Seq[(Rule, RuleResolution)]] = ...
```

#### `scala/coursier/util/ModuleMatcher.scala`

```scala
object ModuleMatcher
```

```scala
def apply(
    org: Organization,
    name: ModuleName,
    attributes: Map[String, String] = Map.empty
  ): ModuleMatcher = ...
```

```scala
def all: ModuleMatcher = ...
```

#### `scala/coursier/util/ModuleMatchers.scala`

```scala
object ModuleMatchers
```

```scala
def all: ModuleMatchers = ...
```

```scala
def only(mod: Module): ModuleMatchers = ...
```

```scala
def only(mod: ModuleMatcher): ModuleMatchers = ...
```

```scala
def only(org: Organization, name: ModuleName): ModuleMatchers = ...
```

#### `scala/coursier/util/StringInterpolators.scala`

```scala
object StringInterpolators
```

```scala
implicit class SafeOrganization(val sc: StringContext) extends AnyVal
```

```scala
def org(args: Any*): Organization = ...
```

```scala
implicit class SafeModuleName(val sc: StringContext) extends AnyVal
```

```scala
def name(args: Any*): ModuleName = ...
```

```scala
implicit class SafeModule(val sc: StringContext) extends AnyVal
```

```scala
def mod(args: Any*): Module = ...
```

```scala
implicit class SafeModuleExclusionMatcher(val sc: StringContext) extends AnyVal
```

```scala
def excl(args: Any*): ModuleMatchers = ...
```

```scala
implicit class SafeModuleInclusionMatcher(val sc: StringContext) extends AnyVal
```

```scala
def incl(args: Any*): ModuleMatchers = ...
```

```scala
implicit class SafeDependency(val sc: StringContext) extends AnyVal
```

```scala
def dep(args: Any*): Dependency = ...
```

```scala
implicit class SafeMavenRepository(val sc: StringContext) extends AnyVal
```

```scala
def mvn(args: Any*): MavenRepository = ...
```

```scala
implicit class SafeIvyRepository(val sc: StringContext) extends AnyVal
```

```scala
def ivy(args: Any*): IvyRepository = ...
```

```scala
def safeOrganization(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[Organization] = ...
```

```scala
def safeModuleName(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[ModuleName] = ...
```

```scala
def safeModule(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[Module] = ...
```

```scala
def safeModuleExclusionMatcher(
    c: blackbox.Context
  )(
    args: c.Expr[Any]*
  ): c.Expr[ModuleMatchers] = ...
```

```scala
def safeModuleInclusionMatcher(
    c: blackbox.Context
  )(
    args: c.Expr[Any]*
  ): c.Expr[ModuleMatchers] = ...
```

```scala
def safeDependency(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[Dependency] = ...
```

```scala
def safeMavenRepository(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[MavenRepository] = ...
```

```scala
def safeIvyRepository(c: blackbox.Context)(args: c.Expr[Any]*): c.Expr[IvyRepository] = ...
```

### `io.get-coursier:coursier-core_2.13:2.1.25-M3`

Source: https://repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M3/coursier-core_2.13-2.1.25-M3-sources.jar

#### `Properties.scala`

> Build-time constants. Generated from mill.

```scala
object Properties
```

```scala
def version = ...
```

```scala
def commitHash = ...
```

#### `coursier/core/compatibility/Entities.scala`

```scala
object Entities
```

```scala
val entities = ...
```

```scala
lazy val map = ...
```

#### `coursier/core/compatibility/package.scala`

```scala
package object compatibility
```

```scala
implicit class RichChar(val c: Char) extends AnyVal
```

```scala
def letterOrDigit = ...
```

```scala
def letter = ...
```

```scala
def xmlPreprocess(s: String): String = ...
```

```scala
def xmlParseSax(str: String, handler: SaxHandler): handler.type = ...
```

```scala
def xmlParseDom(s: String): Either[String, Xml.Node] = ...
```

```scala
def xmlFromElem(elem: Elem): Xml.Node = ...
```

```scala
def xmlParse(s: String): Either[String, Xml.Node] = ...
```

```scala
def encodeURIComponent(s: String): String = ...
```

```scala
def regexLookbehind: String = ...
```

```scala
def coloredOutput: Boolean = ...
```

```scala
def hasConsole: Boolean = ...
```

#### `coursier/maven/WritePom.scala`

```scala
object WritePom
```

```scala
def project(proj: Project, packaging: Option[String]) = ...
```

#### `scala/coursier/core/Activation.scala`

```scala
object Activation
```

```scala
object Os
```

```scala
val empty = ...
```

```scala
def families(name: String, pathSep: String): Set[String] = ...
```

```scala
def fromProperties(properties: Map[String, String]): Os = ...
```

```scala
val empty = ...
```

#### `scala/coursier/core/BomDependency.scala`

```scala
object BomDependency
```

```scala
  @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    config: Configuration,
    forceOverrideVersions: Boolean
  ): BomDependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    config: Configuration
  ): BomDependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def apply(
    module: Module,
    version: String
  ): BomDependency = ...
```

#### `scala/coursier/core/Definitions.scala`

```scala
final case class Organization(value: String) extends AnyVal
```

```scala
def map(f: String => String): Organization = ...
```

```scala
object Organization
```

```scala
implicit val ordering: Ordering[Organization] = ...
```

```scala
final case class ModuleName(value: String) extends AnyVal
```

```scala
def map(f: String => String): ModuleName = ...
```

```scala
object ModuleName
```

```scala
implicit val ordering: Ordering[ModuleName] = ...
```

```scala
object Module
```

```scala
def apply(organization: Organization, name: ModuleName, attributes: Map[String, String]): Module = ...
```

```scala
final case class Type(value: String) extends AnyVal
```

```scala
def isEmpty: Boolean = ...
```

```scala
def nonEmpty: Boolean = ...
```

```scala
def map(f: String => String): Type = ...
```

```scala
def asExtension: Extension = ...
```

```scala
object Type
```

```scala
implicit val ordering: Ordering[Type] = ...
```

```scala
val jar = ...
```

```scala
val testJar = ...
```

```scala
val bundle = ...
```

```scala
val doc = ...
```

```scala
val source = ...
```

```scala
val javadoc = ...
```

```scala
val javaSource = ...
```

```scala
val ivy = ...
```

```scala
val pom = ...
```

```scala
val empty = ...
```

```scala
val all = ...
```

```scala
object Exotic
```

```scala
val mavenPlugin = ...
```

```scala
val eclipsePlugin = ...
```

```scala
val hk2 = ...
```

```scala
val orbit = ...
```

```scala
val scalaJar = ...
```

```scala
val klib = ...
```

```scala
val aar = ...
```

```scala
final case class Classifier(value: String) extends AnyVal
```

```scala
def isEmpty: Boolean = ...
```

```scala
def nonEmpty: Boolean = ...
```

```scala
def map(f: String => String): Classifier = ...
```

```scala
object Classifier
```

```scala
implicit val ordering: Ordering[Classifier] = ...
```

```scala
val empty = ...
```

```scala
val tests = ...
```

```scala
val javadoc = ...
```

```scala
val sources = ...
```

```scala
final case class Extension(value: String) extends AnyVal
```

```scala
def isEmpty: Boolean = ...
```

```scala
def map(f: String => String): Extension = ...
```

```scala
def asType: Type = ...
```

```scala
object Extension
```

```scala
implicit val ordering: Ordering[Extension] = ...
```

```scala
val jar = ...
```

```scala
val pom = ...
```

```scala
val empty = ...
```

```scala
final case class Configuration(value: String) extends AnyVal
```

```scala
def isEmpty: Boolean = ...
```

```scala
def nonEmpty: Boolean = ...
```

```scala
def -->(target: Configuration): Configuration = ...
```

```scala
def map(f: String => String): Configuration = ...
```

```scala
object Configuration
```

```scala
implicit val ordering: Ordering[Configuration] = ...
```

```scala
val empty = ...
```

```scala
val compile = ...
```

```scala
val runtime = ...
```

```scala
val test = ...
```

```scala
val default = ...
```

```scala
val defaultCompile = ...
```

```scala
val defaultRuntime = ...
```

```scala
val provided = ...
```

```scala
val `import` = ...
```

```scala
val optional = ...
```

```scala
val all = ...
```

```scala
def join(confs: Configuration*): Configuration = ...
```

```scala
object Attributes
```

```scala
val empty = ...
```

```scala
object Project
```

```scala
  @deprecated("Use the override accepting Version-s instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    dependencies: Seq[(Configuration, Dependency)],
    configurations: Map[Configuration, Seq[Configuration]],
    parent: Option[(Module, String)],
    dependencyManagement: Seq[(Configuration, Dependency)],
    properties: Seq[(String, String)],
    profiles: Seq[Profile],
    versions: Option[Versions],
    snapshotVersioning: Option[SnapshotVersioning],
    packagingOpt: Option[Type],
    relocated: Boolean,
    actualVersionOpt: Option[String],
    publications: Seq[(Configuration, Publication)],
    info: Info
  ): Project = ...
```

```scala
  @deprecated("Use the override accepting Version-s instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    dependencies: Seq[(Configuration, Dependency)],
    configurations: Map[Configuration, Seq[Configuration]],
    parent: Option[(Module, String)],
    dependencyManagement: Seq[(Configuration, Dependency)],
    properties: Seq[(String, String)],
    profiles: Seq[Profile],
    versions: Option[Versions],
    snapshotVersioning: Option[SnapshotVersioning],
    packagingOpt: Option[Type],
    relocated: Boolean,
    actualVersionOpt: Option[String],
    publications: Seq[(Configuration, Publication)],
    info: Info,
    overrides: Overrides
  ): Project = ...
```

```scala
object Info
```

```scala
def apply(
    description: String,
    homePage: String,
    licenses: Seq[(String, Option[String])],
    developers: Seq[Info.Developer],
    publication: Option[Versions.DateTime],
    scm: Option[Info.Scm]
  ): Info = ...
```

```scala
val empty = ...
```

```scala
extension: Extension,
```

```scala
extension: Extension,
```

```scala
extension,
```

```scala
object SnapshotVersion
```

```scala
  @deprecated("Use the override accepting a Version instead", "2.1.25")
def apply(
    classifier: Classifier,
    extension: Extension,
    value: String,
    updated: Option[Versions.DateTime]
  ): SnapshotVersion = ...
```

```scala
object SnapshotVersioning
```

```scala
  @deprecated("Use the override accepting Version-s instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    latest: String,
    release: String,
    timestamp: String,
    buildNumber: Option[Int],
    localCopy: Option[Boolean],
    lastUpdated: Option[Versions.DateTime],
    snapshotVersions: Seq[SnapshotVersion]
  ): SnapshotVersioning = ...
```

```scala
object Publication
```

```scala
def apply(name: String, `type`: Type, ext: Extension, classifier: Classifier): Publication = ...
```

```scala
val empty: Publication = ...
```

```scala
trait ArtifactSource
```

```scala
def artifacts(
    dependency: Dependency,
    project: Project,
    overrideClassifiers: Option[Seq[Classifier]]
  ): Seq[(Publication, Artifact)]
```

```scala
object ArtifactSource
```

```scala
trait ModuleBased
```

```scala
def moduleArtifacts(
      dependency: Dependency,
      project: Project
    ): Seq[(VariantPublication, Artifact)]
```

#### `scala/coursier/core/Dependency.scala`

```scala
object Dependency
```

```scala
def apply(
    module: Module,
    versionConstraint: VersionConstraint0,
    variantSelector: VariantSelector,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)],
    bomDependencies: Seq[BomDependency],
    overridesMap: Overrides
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)],
    bomDependencies: Seq[BomDependency],
    overridesMap: Overrides
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0,
    variantSelector: VariantSelector,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)],
    bomDependencies: Seq[BomDependency]
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)],
    bomDependencies: Seq[BomDependency]
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0,
    variantSelector: VariantSelector,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)]
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map,
    boms: Seq[(Module, String)]
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0,
    variantSelector: VariantSelector,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean,
    overrides: DependencyManagement.Map
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0,
    variantSelector: VariantSelector,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    minimizedExclusions: MinimizedExclusions,
    publication: Publication,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    versionConstraint: VersionConstraint0,
    variantSelector: VariantSelector,
    exclusions: Set[(Organization, ModuleName)],
    publication: Publication,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    exclusions: Set[(Organization, ModuleName)],
    publication: Publication,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String
  ): Dependency = ...
```

```scala
def apply(
    module: Module,
    version: VersionConstraint0,
    variantSelector: VariantSelector,
    exclusions: Set[(Organization, ModuleName)],
    attributes: Attributes,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint", "2.1.25")
def apply(
    module: Module,
    version: String,
    configuration: Configuration,
    exclusions: Set[(Organization, ModuleName)],
    attributes: Attributes,
    optional: Boolean,
    transitive: Boolean
  ): Dependency = ...
```

```scala
def mavenPrefix(module: Module, attributes: Attributes): String = ...
```

#### `scala/coursier/core/DependencyManagement.scala`

```scala
object DependencyManagement
```

```scala
type Map = ...
```

```scala
type GenericMap = ...
```

```scala
object Key
```

```scala
def from(dep: Dependency): Key = ...
```

```scala
object Values
```

```scala
val empty = ...
```

```scala
def from(config: Configuration, dep: Dependency): Values = ...
```

```scala
    @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def apply(
      config: Configuration,
      version: String,
      minimizedExclusions: MinimizedExclusions,
      optional: Boolean
    ): Values = ...
```

```scala
def entry(config: Configuration, dep: Dependency): (Key, Values) = ...
```

> Converts a sequence of dependency management entries to a dependency management map
>
> The map having at most one value per key, rather than possibly several in the sequence
>
> This composes the values together, keeping the version of the first one, and adding their
> exclusions if `composeValues` is true (the default). In particular, this respects the order of
> values in the incoming sequence, and makes sure the values in the initial map go before those
> of the sequence.

```scala
def add(
    initialMap: Map,
    entries: Seq[(Key, Values)],
    composeValues: Boolean = true
  ): Map = ...
```

```scala
def addAll(
    initialMap: Map,
    entries: Seq[GenericMap],
    composeValues: Boolean = true
  ): GenericMap = ...
```

```scala
def addDependencies(
    map: Map,
    deps: Seq[(Configuration, Dependency)],
    composeValues: Boolean = true
  ): Map = ...
```

#### `scala/coursier/core/DependencySet.scala`

```scala
object DependencySet
```

```scala
val empty = ...
```

#### `scala/coursier/core/Exclusions.scala`

```scala
object Exclusions
```

```scala
def partition(
    exclusions: Set[(Organization, ModuleName)]
  ): (Boolean, Set[Organization], Set[ModuleName], Set[(Organization, ModuleName)]) = ...
```

```scala
def apply(exclusions: Set[(Organization, ModuleName)]): (Organization, ModuleName) = ...
```

```scala
def minimize(exclusions: Set[(Organization, ModuleName)]): Set[(Organization, ModuleName)] = ...
```

```scala
val allOrganizations = ...
```

```scala
val allNames = ...
```

```scala
val zero = ...
```

```scala
val one = ...
```

```scala
def join(
    x: Set[(Organization, ModuleName)],
    y: Set[(Organization, ModuleName)]
  ): Set[(Organization, ModuleName)] = ...
```

```scala
def meet(
    x: Set[(Organization, ModuleName)],
    y: Set[(Organization, ModuleName)]
  ): Set[(Organization, ModuleName)] = ...
```

#### `scala/coursier/core/Latest.scala`

```scala
@deprecated("Use coursier.version.Latest instead", "2.1.25")
sealed abstract class Latest(val name: String) extends Product with Serializable
```

```scala
@deprecated("Use coursier.version.Latest instead", "2.1.25")
object Latest
```

```scala
case object Integration extends Latest("integration")
```

```scala
case object Release     extends Latest("release")
```

```scala
case object Stable      extends Latest("stable")
```

```scala
def apply(s: String): Option[Latest] = ...
```

#### `scala/coursier/core/MinimizedExclusions.scala`

> This file defines a special-purpose structure for exclusions that has the following
> properties/goals:
> - The exclusion data is always minimized (minimized meaning overlapping rules are removed)
> - The data structure is split into various cases, optimizing common cases for join/meet
> - The hashcode is cached, such that recalculating the hashcode for these exclusions is cached.

```scala
object MinimizedExclusions
```

```scala
val zero = ...
```

```scala
val one = ...
```

```scala
sealed abstract class ExclusionData extends Product with Serializable
```

```scala
def apply(org: Organization, module: ModuleName): Boolean
```

```scala
def join(other: ExclusionData): ExclusionData
```

```scala
def meet(other: ExclusionData): ExclusionData
```

```scala
def partitioned()
```

```scala
def map(f: String => String): ExclusionData
```

```scala
def size(): Int
```

```scala
def subsetOf(other: ExclusionData): Boolean
```

```scala
def toSet(): Set[(Organization, ModuleName)]
```

```scala
def hasProperties: Boolean
```

```scala
case object ExcludeNone extends ExclusionData
```

```scala
override def apply(org: Organization, module: ModuleName): Boolean = ...
```

```scala
override def join(other: ExclusionData): ExclusionData = ...
```

```scala
override def meet(other: ExclusionData): ExclusionData = ...
```

```scala
override def partitioned()
```

```scala
override def map(f: String => String): ExclusionData = ...
```

```scala
override def size(): Int = ...
```

```scala
override def subsetOf(other: ExclusionData): Boolean = ...
```

```scala
override def toSet(): Set[(Organization, ModuleName)] = ...
```

```scala
def hasProperties: Boolean = ...
```

```scala
case object ExcludeAll extends ExclusionData
```

```scala
override def apply(org: Organization, module: ModuleName): Boolean = ...
```

```scala
override def join(other: ExclusionData): ExclusionData = ...
```

```scala
override def meet(other: ExclusionData): ExclusionData = ...
```

```scala
override def partitioned()
```

```scala
override def map(f: String => String): ExclusionData = ...
```

```scala
override def size(): Int = ...
```

```scala
override def subsetOf(other: ExclusionData): Boolean = ...
```

```scala
override def toSet(): Set[(Organization, ModuleName)] = ...
```

```scala
def hasProperties: Boolean = ...
```

```scala
def apply(exclusions: Set[(Organization, ModuleName)]): MinimizedExclusions = ...
```

#### `scala/coursier/core/Orders.scala`

```scala
object Orders
```

```scala
  @deprecated("Will likely be removed at some point in future versions", "2.0.0-RC3")
trait PartialOrdering[T] extends scala.math.PartialOrdering[T]
```

```scala
def lteq(x: T, y: T): Boolean = ...
```

> All configurations that each configuration extends, including the ones it extends transitively

```scala
  @deprecated("Will likely be removed at some point in future versions", "2.0.0-RC3")
def allConfigurations(
    configurations: Map[Configuration, Seq[Configuration]]
  ): Map[Configuration, Set[Configuration]] = ...
```

> Configurations partial order based on configuration mapping `configurations`.
>
> @param configurations:
> for each configuration, the configurations it directly extends.

```scala
  @deprecated("Will likely be removed at some point in future versions", "2.0.0-RC3")
def configurationPartialOrder(
    configurations: Map[Configuration, Seq[Configuration]]
  ): PartialOrdering[Configuration] = ...
```

> Non-optional < optional

```scala
  @deprecated("Will likely be removed at some point in future versions", "2.0.0-RC3")
val optionalPartialOrder: PartialOrdering[Boolean] = ...
```

```scala
val exclusionsPartialOrder: PartialOrdering[Set[(Organization, ModuleName)]] = ...
```

```scala
def minDependenciesUnsafe(
    dependencies: Set[Dependency],
    configs: Map[Configuration, Seq[Configuration]]
  ): Set[Dependency] = ...
```

```scala
def minDependencies(
    dependencies: Set[Dependency],
    configs: ((Module, String)) => Map[Configuration, Seq[Configuration]]
  ): Set[Dependency] = ...
```

#### `scala/coursier/core/Overrides.scala`

```scala
sealed abstract class Overrides extends Product with Serializable
```

```scala
def get(key: DependencyManagement.Key): Option[DependencyManagement.Values]
```

```scala
def contains(key: DependencyManagement.Key): Boolean
```

```scala
def isEmpty: Boolean
```

```scala
def nonEmpty: Boolean = ...
```

```scala
def maps: Seq[DependencyManagement.GenericMap]
```

```scala
def flatten: DependencyManagement.GenericMap = ...
```

```scala
def filter(f: (DependencyManagement.Key, DependencyManagement.Values) => Boolean): Overrides
```

```scala
def map(
    f: (
      DependencyManagement.Key,
      DependencyManagement.Values
    ) => (DependencyManagement.Key, DependencyManagement.Values)
  ): Overrides
```

```scala
def mapMap(
    f: DependencyManagement.GenericMap => Option[DependencyManagement.GenericMap]
  ): Overrides
```

```scala
def hasProperties: Boolean
```

```scala
object Overrides
```

```scala
def empty: Overrides = ...
```

```scala
def apply(map: DependencyManagement.GenericMap): Overrides = ...
```

```scala
def add(overrides: Overrides*): Overrides = ...
```

#### `scala/coursier/core/Parse.scala`

```scala
object Parse
```

```scala
  @deprecated("Use coursier.version.VersionParse.version instead", "2.1.25")
def version(s: String): Option[Version] = ...
```

```scala
  @deprecated("Unused by coursier", "2.1.25")
def ivyLatestSubRevisionInterval(s: String): Option[VersionInterval] = ...
```

```scala
  @deprecated("Use coursier.version.VersionParse.versionInterval instead", "2.1.25")
def versionInterval(s: String): Option[VersionInterval] = ...
```

```scala
  @deprecated("Unused by coursier", "2.1.25")
def multiVersionInterval(s: String): Option[VersionInterval] = ...
```

```scala
  @deprecated("Use coursier.version.VersionParse.versionConstraint instead", "2.1.25")
def versionConstraint(s: String): VersionConstraint = ...
```

```scala
val fallbackConfigRegex = ...
```

```scala
def withFallbackConfig(config: Configuration): Option[(Configuration, Configuration)] = ...
```

#### `scala/coursier/core/Reconciliation.scala`

> Represents a reconciliation strategy given a dependency conflict.

```scala
@deprecated("Use coursier.version.ConstraintReconciliation instead", "2.1.25")
sealed abstract class Reconciliation
```

> Reconcile multiple version candidate.
>
> Returns `None` in case of conflict.

```scala
def apply(versions: Seq[VersionConstraint0]): Option[VersionConstraint0]
```

```scala
def reconcile(versions: Seq[VersionConstraint0]): Option[VersionConstraint0] = ...
```

```scala
def id: String
```

```scala
@deprecated("Use coursier.version.ConstraintReconciliation instead", "2.1.25")
object Reconciliation
```

```scala
case object Default extends Reconciliation
```

```scala
def apply(versions: Seq[VersionConstraint0]): Option[VersionConstraint0] = ...
```

```scala
def id: String = ...
```

```scala
case object Relaxed extends Reconciliation
```

```scala
def apply(versions: Seq[VersionConstraint0]): Option[VersionConstraint0] = ...
```

```scala
def id: String = ...
```

> Strict version reconciliation.
>
> This particular instance behaves the same as [[Default]] when used by
> [[coursier.core.Resolution]]. Actual strict conflict manager is handled by
> `coursier.params.rule.Strict`, which is set up by `coursier.Resolve` when a strict
> reconciliation is added to it.

```scala
case object Strict extends Reconciliation
```

```scala
def apply(versions: Seq[VersionConstraint0]): Option[VersionConstraint0] = ...
```

```scala
def id: String = ...
```

> Semantic versioning version reconciliation.
>
> This particular instance behaves the same as [[Default]] when used by
> [[coursier.core.Resolution]]. Actual semantic versioning checks are handled by
> `coursier.params.rule.Strict` with field `semVer = true`, which is set up by
> `coursier.Resolve` when a SemVer reconciliation is added to it.

```scala
case object SemVer extends Reconciliation
```

```scala
def apply(versions: Seq[VersionConstraint0]): Option[VersionConstraint0] = ...
```

```scala
def id: String = ...
```

```scala
def apply(input: VersionConstraint0): Option[Reconciliation] = ...
```

```scala
def apply(input: String): Option[Reconciliation] = ...
```

#### `scala/coursier/core/Repository.scala`

```scala
trait Repository extends Serializable with ArtifactSource
```

```scala
def repr: String = ...
```

```scala
def find0[F[_]](
    module: Module,
    version: Version0,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (ArtifactSource, Project)] = ...
```

```scala
def find[F[_]](
    module: Module,
    version: String,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (ArtifactSource, Project)]
```

```scala
  @deprecated("Unused by coursier", "2.1.25")
def findMaybeInterval[F[_]](
    module: Module,
    version: VersionConstraint0,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (ArtifactSource, Project)] = ...
```

```scala
  @deprecated("Unused by coursier", "2.1.25")
def findMaybeInterval[F[_]](
    module: Module,
    version: String,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (ArtifactSource, Project)] = ...
```

```scala
def findFromVersionConstraint[F[_]](
    module: Module,
    versionConstraint: VersionConstraint0,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (ArtifactSource, Project)] = ...
```

```scala
def completeOpt[F[_]: Monad](fetch: Repository.Fetch[F]): Option[Repository.Complete[F]] = ...
```

```scala
def versionsCheckHasModule: Boolean = ...
```

```scala
def versions[F[_]](
    module: Module,
    fetch: Repository.Fetch[F]
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (Versions, String)] = ...
```

```scala
def versions[F[_]](
    module: Module,
    fetch: Repository.Fetch[F],
    versionsCheckHasModule: Boolean
  )(implicit
    F: Monad[F]
  ): EitherT[F, String, (Versions, String)] = ...
```

```scala
object Repository
```

```scala
type Fetch[F[_]] = ...
```

```scala
implicit class ArtifactExtensions(val underlying: Artifact) extends AnyVal
```

```scala
def withDefaultChecksums: Artifact = ...
```

```scala
def withDefaultSignature: Artifact = ...
```

```scala
trait Complete[F[_]]
```

```scala
def organization(prefix: String): F[Either[Throwable, Seq[String]]]
```

```scala
def moduleName(organization: Organization, prefix: String): F[Either[Throwable, Seq[String]]]
```

```scala
def versions(
      module: Module,
      prefix: String
    ): F[Either[Throwable, Seq[Version0]]]
```

```scala
def hasModule(module: Module)(implicit F: Monad[F]): F[Boolean] = ...
```

```scala
final def complete(
      input: Complete.Input
    )(implicit
      F: Monad[F]
    ): F[Either[Throwable, Complete.Result]] = ...
```

```scala
final def complete(
      input: String,
      scalaVersion: String,
      scalaBinaryVersion: String
    )(implicit
      F: Monad[F]
    ): F[Either[Throwable, Complete.Result]] = ...
```

```scala
object Complete
```

```scala
sealed abstract class Input extends Product with Serializable
```

```scala
def input: String
```

```scala
def from: Int
```

```scala
object Input
```

```scala
def parse(
      input: String,
      scalaVersion: String,
      scalaBinaryVersion: String
    ): Either[Throwable, Input] = ...
```

```scala
    @data class Result(input: Input, completions: Seq[String])
final class CompletingOrgException(input: String, cause: Throwable = null)
```

```scala
final class CompletingNameException(
      organization: Organization,
      input: String,
      from: Int,
      cause: Throwable = null
      // format: off
    ) extends Exception(
      s"Completing module name '${input.drop(from)}' for organization ${organization.value}",
      cause
    )
```

```scala
final class CompletingVersionException(
      module: Module,
      input: String,
      from: Int,
      cause: Throwable = null
    ) extends Exception(s"Completing version '${input.drop(from)}' for module $module", cause)
```

```scala
final class MalformedInput(input: String)
```

```scala
trait VersionApi extends Repository
```

```scala
def find[F[_]](
      module: Module,
      version: String,
      fetch: Repository.Fetch[F]
    )(implicit
      F: Monad[F]
    ): EitherT[F, String, (ArtifactSource, Project)] = ...
```

#### `scala/coursier/core/Resolution.scala`

```scala
object Resolution
```

```scala
type ModuleVersion = ...
```

```scala
type ModuleVersionConstraint = ...
```

```scala
def profileIsActive0(
    profile: Profile,
    properties: Map[String, String],
    osInfo: Activation.Os,
    jdkVersion: Option[Version0],
    userActivations: Option[Map[String, Boolean]]
  ): Boolean = ...
```

```scala
  @deprecated("Use profileIsActive0 instead", "2.1.25")
def profileIsActive(
    profile: Profile,
    properties: Map[String, String],
    osInfo: Activation.Os,
    jdkVersion: Option[String],
    userActivations: Option[Map[String, Boolean]]
  ): Boolean = ...
```

> Get the active profiles of `project`, using the current properties `properties`, and
> `profileActivations` stating if a profile is active.

```scala
def profiles0(
    project: Project,
    properties: Map[String, String],
    osInfo: Activation.Os,
    jdkVersion: Option[Version0],
    userActivations: Option[Map[String, Boolean]]
  ): Seq[Profile] = ...
```

```scala
  @deprecated("Use profiles0 instead", "2.1.25")
def profiles(
    project: Project,
    properties: Map[String, String],
    osInfo: Activation.Os,
    jdkVersion: Option[String],
    userActivations: Option[Map[String, Boolean]]
  ): Seq[Profile] = ...
```

```scala
def addDependencies(
    deps: Seq[Seq[(Variant, Dependency)]]
  ): Seq[(Variant, Dependency)] = ...
```

```scala
def hasProps(s: String): Boolean = ...
```

```scala
def substituteProps(s: String, properties: Map[String, String]): String = ...
```

```scala
def substituteProps(s: String, properties: Map[String, String], trim: Boolean): String = ...
```

```scala
def withProperties0(
    dependencies: Seq[(Variant, Dependency)],
    properties: Map[String, String]
  ): Seq[(Variant, Dependency)] = ...
```

```scala
  @deprecated("Use withProperties0 instead", "2.1.25")
def withProperties(
    dependencies: Seq[(Configuration, Dependency)],
    properties: Map[String, String]
  ): Seq[(Configuration, Dependency)] = ...
```

> Merge several dependencies, solving version constraints of duplicated modules.
>
> Returns the conflicted dependencies, and the merged others.

```scala
def merge0(
    dependencies: Seq[Dependency],
    forceVersions: Map[Module, VersionConstraint0],
    reconciliation: Option[Module => ConstraintReconciliation],
    preserveOrder: Boolean = false
  ): (Seq[Dependency], Seq[Dependency], Map[Module, VersionConstraint0]) = ...
```

```scala
  @deprecated("", "2.1.25")
def merge(
    dependencies: Seq[Dependency],
    forceVersions: Map[Module, String],
    reconciliation: Option[Module => coursier.core.Reconciliation],
    preserveOrder: Boolean = false
  ): (Seq[Dependency], Seq[Dependency], Map[Module, String]) = ...
```

> Applies `dependencyManagement` to `dependencies`.
>
> Fill empty version / scope / exclusions, for dependencies found in `dependencyManagement`.

```scala
def depsWithDependencyManagement0(
    rawDependencies: Seq[(Variant, Dependency)],
    properties: Map[String, String],
    rawOverridesOpt: Option[Overrides],
    rawDependencyManagement: Overrides,
    forceDepMgmtVersions: Boolean,
    keepVariant: Variant => Boolean
  ): Seq[(Variant, Dependency)] = ...
```

```scala
  @deprecated("Use depsWithDependencyManagement0 instead", "2.1.25")
def depsWithDependencyManagement(
    rawDependencies: Seq[(Configuration, Dependency)],
    properties: Map[String, String],
    rawOverridesOpt: Option[Overrides],
    rawDependencyManagement: Overrides,
    forceDepMgmtVersions: Boolean,
    keepVariant: Variant => Boolean
  ): Seq[(Configuration, Dependency)] = ...
```

```scala
def depsWithDependencyManagement(
    rawDependencies: Seq[(Configuration, Dependency)],
    properties: Map[String, String],
    rawOverridesOpt: Option[DependencyManagement.Map],
    rawDependencyManagement: Seq[(Configuration, Dependency)],
    forceDepMgmtVersions: Boolean
  ): Seq[(Configuration, Dependency)] = ...
```

```scala
def depsWithDependencyManagement(
    dependencies: Seq[(Configuration, Dependency)],
    dependencyManagement: Seq[(Configuration, Dependency)]
  ): Seq[(Configuration, Dependency)] = ...
```

> Filters `dependencies` with `exclusions`.

```scala
def withExclusions0(
    dependencies: Seq[(Variant, Dependency)],
    exclusions: Set[(Organization, ModuleName)]
  ): Seq[(Variant, Dependency)] = ...
```

```scala
  @deprecated("Use withExclusions0 instead", "2.1.25")
def withExclusions(
    dependencies: Seq[(Configuration, Dependency)],
    exclusions: Set[(Organization, ModuleName)]
  ): Seq[(Configuration, Dependency)] = ...
```

```scala
def actualConfiguration(
    config: Configuration,
    configurations: Map[Configuration, Seq[Configuration]]
  ): Configuration = ...
```

```scala
def actualConfiguration(
    config: Configuration,
    configurations: Set[Configuration]
  ): Configuration = ...
```

```scala
def parentConfigurations(
    actualConfig: Configuration,
    configurations: Map[Configuration, Seq[Configuration]]
  ): Set[Configuration] = ...
```

```scala
  @deprecated("Unused by coursier, should be removed in the future", "2.1.25")
def withParentConfigurations(
    config: Configuration,
    configurations: Map[Configuration, Seq[Configuration]]
  ): (Configuration, Set[Configuration]) = ...
```

```scala
def projectProperties(project: Project): Seq[(String, String)] = ...
```

> Default dependency filter used during resolution.
>
> Does not follow optional dependencies.

```scala
def defaultFilter(dep: Dependency): Boolean = ...
```

```scala
val defaultTypes = ...
```

```scala
def overrideScalaModule(sv: VersionConstraint0): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def overrideScalaModule(sv: String): Dependency = ...
```

```scala
def overrideScalaModule(
    sv: VersionConstraint0,
    scalaOrg: Organization
  ): Dependency = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint instead", "2.1.25")
def overrideScalaModule(
    sv: String,
    scalaOrg: Organization
  ): Dependency = ...
```

> Replaces the full suffix _2.12.8 with the given Scala version.

```scala
def overrideFullSuffix(sv: String): Dependency = ...
```

```scala
  @deprecated("Use overrideScalaModule and overrideFullSuffix instead", "2.0.17")
def forceScalaVersion(sv: String): Dependency = ...
```

```scala
def enableDependencyOverridesDefault: Boolean = ...
```

#### `scala/coursier/core/ResolutionProcess.scala`

```scala
sealed abstract class ResolutionProcess extends Product with Serializable
```

```scala
def run0[F[_]](
    fetch: ResolutionProcess.Fetch0[F],
    maxIterations: Int = ResolutionProcess.defaultMaxIterations
  )(implicit
    F: Monad[F]
  ): F[Resolution] = ...
```

```scala
  @deprecated("Use run0 instead", "2.1.25")
def run[F[_]](
    fetch: ResolutionProcess.Fetch[F],
    maxIterations: Int = ResolutionProcess.defaultMaxIterations
  )(implicit
    F: Monad[F]
  ): F[Resolution] = ...
```

```scala
  @tailrec
final def next_[F[_]](
    fetch: ResolutionProcess.Fetch0[F],
    fastForward: Boolean = true
  )(implicit
    F: Monad[F]
  ): F[ResolutionProcess] = ...
```

```scala
  @deprecated("Use next_ instead", "2.1.25")
final def next[F[_]](
    fetch: ResolutionProcess.Fetch[F],
    fastForward: Boolean = true
  )(implicit
    F: Monad[F]
  ): F[ResolutionProcess] = ...
```

```scala
def current: Resolution
```

```scala
object ResolutionProcess
```

```scala
  @deprecated("Use ResolutionProcess.MD0 instead", "2.1.25")
type MD = ...
```

```scala
  @deprecated("Use ResolutionProcess.Fetch0 instead", "2.1.25")
type Fetch[F[_]] = ...
```

```scala
type MD0 = ...
```

```scala
type Fetch0[F[_]] = ...
```

> Try to find `module` among `repositories`.
>
> Look at `repositories` from the left, one-by-one, and stop at first success. Else, return all
> errors, in the same order.
>
> The `version` field of the returned `Project` in case of success may not be equal to the
> provided one, in case the latter is not a specific version (e.g. version interval). Which
> version get chosen depends on the repository implementation.

```scala
def fetchOne[F[_]](
    repositories: Seq[Repository],
    module: Module,
    version: VersionConstraint0,
    fetch: Repository.Fetch[F],
    fetchs: Seq[Repository.Fetch[F]]
  )(implicit
    F: Gather[F]
  ): EitherT[F, Seq[String], (ArtifactSource, Project)] = ...
```

```scala
def fetchOne[F[_]](
    repositories: Seq[Repository],
    module: Module,
    version: String,
    fetch: Repository.Fetch[F],
    fetchs: Seq[Repository.Fetch[F]]
  )(implicit
    F: Gather[F]
  ): EitherT[F, Seq[String], (ArtifactSource, Project)] = ...
```

```scala
def fetch0[F[_]](
    repositories: Seq[Repository],
    fetch: Repository.Fetch[F],
    fetchs: Seq[Repository.Fetch[F]] = Nil
  )(implicit
    F: Gather[F]
  ): Fetch0[F] = ...
```

```scala
  @deprecated("Use fetch0 instead", "2.1.25")
def fetch[F[_]](
    repositories: Seq[Repository],
    fetch: Repository.Fetch[F],
    fetchs: Seq[Repository.Fetch[F]] = Nil
  )(implicit
    F: Gather[F]
  ): Fetch[F] = ...
```

```scala
def defaultMaxIterations: Int = ...
```

```scala
def apply(resolution: Resolution): ResolutionProcess = ...
```

#### `scala/coursier/core/Variant.scala`

```scala
sealed abstract class Variant extends Product with Serializable
```

```scala
def asConfiguration: Option[Configuration0]
```

```scala
def isEmpty: Boolean
```

```scala
object Variant
```

```scala
lazy val emptyConfiguration: Variant = ...
```

#### `scala/coursier/core/VariantSelector.scala`

```scala
sealed abstract class VariantSelector extends Product with Serializable
```

```scala
def asConfiguration: Option[Configuration]
```

```scala
def isEmpty: Boolean
```

```scala
final def nonEmpty: Boolean = ...
```

```scala
def repr: String
```

```scala
object VariantSelector
```

```scala
object AttributesBased
```

```scala
def empty: AttributesBased = ...
```

```scala
lazy val emptyConfiguration: VariantSelector = ...
```

```scala
sealed abstract class VariantMatcher extends Product with Serializable
```

```scala
def matches(value: String): Boolean
```

```scala
def repr: String
```

```scala
object VariantMatcher
```

```scala
case object Api extends VariantMatcher
```

```scala
def matches(inputValue: String): Boolean = ...
```

```scala
def repr: String = ...
```

```scala
case object Runtime extends VariantMatcher
```

```scala
def matches(inputValue: String): Boolean = ...
```

```scala
def repr: String = ...
```

```scala
val Library: VariantMatcher = ...
```

```scala
def fromString(key: String, value: String): (String, VariantMatcher) = ...
```

#### `scala/coursier/core/Version.scala`

```scala
object Version
```

```scala
sealed abstract class Item extends Ordered[Item]
```

```scala
def compare(other: Item): Int = ...
```

```scala
def order: Int
```

```scala
def isEmpty: Boolean = ...
```

```scala
def compareToEmpty: Int = ...
```

```scala
sealed abstract class Numeric extends Item
```

```scala
def repr: String
```

```scala
def next: Numeric
```

```scala
case object Min extends Item
```

```scala
val order = ...
```

```scala
override def compareToEmpty = ...
```

```scala
case object Max extends Item
```

```scala
val order = ...
```

```scala
val empty = ...
```

```scala
object Tokenizer
```

```scala
sealed abstract class Separator
```

```scala
case object Dot        extends Separator
```

```scala
case object Hyphen     extends Separator
```

```scala
case object Underscore extends Separator
```

```scala
case object Plus       extends Separator
```

```scala
case object None       extends Separator
```

```scala
def apply(str: String): (Item, LazyList[(Separator, Item)]) = ...
```

```scala
def isNumeric(item: Item) = ...
```

```scala
def isBuildMetadata(item: Item) = ...
```

```scala
def items(repr: String): Vector[Item] = ...
```

```scala
def listCompare(first0: Vector[Item], second0: Vector[Item]): Int = ...
```

#### `scala/coursier/core/VersionConstraint.scala`

```scala
@deprecated("Use coursier.version.VersionConstraint instead", "2.1.25")
object VersionConstraint
```

```scala
def preferred(version: Version): VersionConstraint = ...
```

```scala
def interval(interval: VersionInterval): VersionConstraint = ...
```

```scala
val all = ...
```

```scala
def merge(constraints: VersionConstraint*): Option[VersionConstraint] = ...
```

```scala
def relaxedMerge(constraints: VersionConstraint*): VersionConstraint = ...
```

#### `scala/coursier/core/VersionInterval.scala`

```scala
@deprecated("Use coursier.version.VersionInterval instead", "2.1.25")
object VersionInterval
```

```scala
val zero = ...
```

#### `scala/coursier/core/Versions.scala`

```scala
object Versions
```

```scala
val empty = ...
```

```scala
  @deprecated("Use the override accepting Version-s instead", "2.1.25")
def apply(
    latest: String,
    release: String,
    available: List[String],
    lastUpdated: Option[Versions.DateTime]
  ): Versions = ...
```

#### `scala/coursier/error/DependencyError.scala`

```scala
abstract class DependencyError(val message: String, cause: Throwable = null)
```

#### `scala/coursier/error/VariantError.scala`

```scala
abstract class VariantError(message: String) extends DependencyError(message)
```

```scala
object VariantError
```

```scala
class NoVariantFound(
    module: Module,
    version: Version,
    attributes: VariantSelector.AttributesBased,
    available: Seq[(Variant.Attributes, Map[String, String])]
  ) extends VariantError(
        s"No variant found in ${module.repr}:${version.asString} for ${attributes.repr} among:" + nl +
          desc(available).mkString(nl)
      )
```

```scala
class FoundTooManyVariants(
    module: Module,
    version: Version,
    attributes: VariantSelector.AttributesBased,
    retained: Seq[(Variant.Attributes, Map[String, String])]
  ) extends VariantError(
        s"Found too many variants in ${module.repr}:${version.asString} for ${attributes.repr}:" + nl +
          desc(retained).mkString(nl)
      )
```

```scala
class CannotFindEquivalentVariants(
    module: Module,
    versionConstraint: VersionConstraint,
    configuration: Configuration
  ) extends VariantError(
        s"Cannot find equivalent variants for configuration ${configuration.value} of ${module.repr}:${versionConstraint.asString}"
      )
```

#### `scala/coursier/graph/Conflict.scala`

```scala
object Conflict
```

```scala
def conflicted(
    resolution: Resolution,
    withExclusions: Boolean = false,
    semVer: Boolean = false
  ): Seq[Conflicted] = ...
```

```scala
def apply(
    resolution: Resolution,
    withExclusions: Boolean = false,
    semVer: Boolean = false
  ): Seq[Conflict] = ...
```

```scala
  @deprecated("Use the override acception a Version and VersionConstraint-s instead", "2.1.25")
def apply(
    module: Module,
    version: String,
    wantedVersion: String,
    wasExcluded: Boolean,
    dependeeModule: Module,
    dependeeVersion: String
  ): Conflict = ...
```

#### `scala/coursier/graph/DependencyTree.scala`

> Simple dependency tree.

```scala
sealed abstract class DependencyTree
```

```scala
def dependency: Dependency
```

> Whether this dependency was excluded by its parent (but landed in the classpath nonetheless
> via other dependencies.

```scala
def excluded: Boolean
```

```scala
def reconciledVersionConstraint: VersionConstraint
```

```scala
  @deprecated("Use reconciledVersion0 instead", "2.1.25")
def reconciledVersion: String = ...
```

> The final version of this dependency.

```scala
def retainedVersion0: Version
```

```scala
  @deprecated("Use retainedVersion0 instead", "2.1.25")
def retainedVersion: String = ...
```

> Dependencies of this node.

```scala
def children: Seq[DependencyTree]
```

```scala
object DependencyTree
```

```scala
def apply(
    resolution: Resolution,
    roots: Seq[Dependency] = null,
    withExclusions: Boolean = false
  ): Seq[DependencyTree] = ...
```

```scala
def one(
    resolution: Resolution,
    root: Dependency,
    withExclusions: Boolean = false
  ): DependencyTree = ...
```

#### `scala/coursier/graph/ModuleTree.scala`

> Simple [[Module]] tree.

```scala
sealed abstract class ModuleTree
```

```scala
def module: Module
```

```scala
def reconciledVersionConstraint: VersionConstraint
```

```scala
  @deprecated("Use reconciledVersion0 instead", "2.1.25")
def reconciledVersion: String = ...
```

> The final version of this dependency.

```scala
def retainedVersion0: Version
```

```scala
  @deprecated("Use reconciledVersion0 instead", "2.1.25")
def retainedVersion: String = ...
```

> The dependencies of this module.

```scala
def children: Seq[ModuleTree]
```

```scala
object ModuleTree
```

```scala
def apply(
    resolution: Resolution,
    roots: Seq[Dependency] = null
  ): Seq[ModuleTree] = ...
```

```scala
def one(
    resolution: Resolution,
    root: Dependency
  ): ModuleTree = ...
```

```scala
def apply(dependencyTrees: Seq[DependencyTree]): Seq[ModuleTree] = ...
```

#### `scala/coursier/graph/ReverseModuleTree.scala`

> Tree allowing to walk the dependency graph from dependency to dependees.

```scala
sealed abstract class ReverseModuleTree
```

```scala
def module: Module
```

> The final version of this dependency.

```scala
def reconciledVersionConstraint: VersionConstraint
```

```scala
  @deprecated("Use retainedVersion0 instead", "2.1.25")
def reconciledVersion: String = ...
```

```scala
def retainedVersion0: Version
```

```scala
  @deprecated("Use retainedVersion0 instead", "2.1.25")
def retainedVersion: String = ...
```

> Module of the parent dependency of to this node.
>
> This node is a dependee. This method corresponds to what we depend on.

```scala
def dependsOnModule: Module
```

> Version of the parent dependency of to this node.
>
> This node is a dependee. This method corresponds to what we depend on.
>
> This is the version this module explicitly depends on.

```scala
def dependsOnVersionConstraint: VersionConstraint
```

```scala
  @deprecated("Use retainedVersion0 instead", "2.1.25")
def dependsOnVersion: String = ...
```

> Final version of the parent dependency of to this node.
>
> This node is a dependee. This method corresponds to what we depend on.
>
> This is the version that was selected during resolution.

```scala
def dependsOnRetainedVersion0: Version
```

```scala
def dependsOnReconciledVersion: String = ...
```

> Whether the parent dependency was excluded by us, but landed anyway in the classpath.
>
> This node is a dependee. This method corresponds to what we depend on.
>
> This says whether this dependency was excluded by us, but landed anyway in the classpath.

```scala
def excludedDependsOn: Boolean
```

> Dependees of this module.

```scala
def dependees: Seq[ReverseModuleTree]
```

```scala
object ReverseModuleTree
```

```scala
def fromModuleTree(roots: Seq[Module], moduleTrees: Seq[ModuleTree]): Seq[ReverseModuleTree] = ...
```

```scala
def fromDependencyTree(
    roots: Seq[Module],
    dependencyTrees: Seq[DependencyTree]
  ): Seq[ReverseModuleTree] = ...
```

```scala
def apply(
    resolution: Resolution,
    roots: Seq[Module] = null,
    withExclusions: Boolean = false
  ): Seq[ReverseModuleTree] = ...
```

#### `scala/coursier/graph/package.scala`

> This package offers various ways of walking the dependency graph of [[Resolution]] s.

```scala
package object graph
```

#### `scala/coursier/ivy/IvyRepository.scala`

```scala
object IvyRepository
```

```scala
def isSnapshot(version: String): Boolean = ...
```

```scala
def parse(
    pattern: String,
    metadataPatternOpt: Option[String] = None,
    changing: Option[Boolean] = None,
    properties: Map[String, String] = Map.empty,
    withChecksums: Boolean = true,
    withSignatures: Boolean = true,
    withArtifacts: Boolean = true,
    // hack for sbt putting infos in properties
    dropInfoAttributes: Boolean = false,
    authentication: Option[Authentication] = None,
    substituteDefault: Boolean = true
  ): Either[String, IvyRepository] = ...
```

```scala
def fromPattern(
    pattern: Pattern,
    metadataPatternOpt: Option[Pattern] = None,
    changing: Option[Boolean] = None,
    withChecksums: Boolean = true,
    withSignatures: Boolean = true,
    withArtifacts: Boolean = true,
    // hack for sbt putting infos in properties
    dropInfoAttributes: Boolean = false,
    authentication: Option[Authentication] = None
  ): IvyRepository = ...
```

#### `scala/coursier/ivy/IvyXml.scala`

```scala
object IvyXml
```

```scala
val attributesNamespace = ...
```

```scala
def mappings(mapping: String): Seq[(Configuration, Configuration)] = ...
```

```scala
def project(node: Node): Either[String, Project] = ...
```

#### `scala/coursier/ivy/Pattern.scala`

```scala
object PropertiesPattern
```

```scala
sealed abstract class ChunkOrProperty extends Product with Serializable
```

```scala
def string: String
```

```scala
object ChunkOrProperty
```

```scala
object Opt
```

```scala
def apply(elem: ChunkOrProperty): Opt = ...
```

```scala
def apply(elem: ChunkOrProperty, elem1: ChunkOrProperty): Opt = ...
```

```scala
def apply(elem: ChunkOrProperty, elem1: ChunkOrProperty, elem2: ChunkOrProperty): Opt = ...
```

```scala
implicit def fromString(s: String): ChunkOrProperty = ...
```

```scala
def parse(pattern: String): Either[String, PropertiesPattern] = ...
```

```scala
object Pattern
```

```scala
sealed abstract class Chunk extends Product with Serializable
```

```scala
def string: String
```

```scala
object Chunk
```

```scala
object Opt
```

```scala
def apply(chunk: Chunk): Opt = ...
```

```scala
def apply(chunk: Chunk, chunk1: Chunk): Opt = ...
```

```scala
def apply(chunk: Chunk, chunk1: Chunk, chunk2: Chunk): Opt = ...
```

```scala
implicit def fromString(s: String): Chunk = ...
```

```scala
val default = ...
```

#### `scala/coursier/maven/GradleModule.scala`

```scala
object GradleModule
```

```scala
final case class StringOrInt(value: String)
```

```scala
object StringOrInt
```

```scala
implicit lazy val codec: JsonValueCodec[StringOrInt] = ...
```

```scala
implicit lazy val codec: JsonValueCodec[GradleModule] = ...
```

```scala
val defaultConfigurations: Map[Configuration, Seq[Configuration]] = ...
```

#### `scala/coursier/maven/MavenAttributes.scala`

```scala
object MavenAttributes
```

```scala
val typeExtensions: Map[Type, Extension] = ...
```

```scala
def typeExtension(`type`: Type): Extension = ...
```

```scala
val typeDefaultClassifiers: Map[Type, Classifier] = ...
```

```scala
def typeDefaultClassifierOpt(`type`: Type): Option[Classifier] = ...
```

```scala
def typeDefaultClassifier(`type`: Type): Classifier = ...
```

```scala
val classifierExtensionDefaultTypes: Map[(Classifier, Extension), Type] = ...
```

```scala
def classifierExtensionDefaultTypeOpt(classifier: Classifier, ext: Extension): Option[Type] = ...
```

#### `scala/coursier/maven/MavenComplete.scala`

```scala
object MavenComplete
```

#### `scala/coursier/maven/MavenRepository.scala`

```scala
object MavenRepository
```

```scala
def defaultConfigurations = ...
```

```scala
def apply(root: String): MavenRepository = ...
```

```scala
def apply(root: String, authentication: Option[Authentication]): MavenRepository = ...
```

#### `scala/coursier/maven/MavenRepositoryInternal.scala`

```scala
extension: Extension
  ): Option[Version] = ...
```

#### `scala/coursier/maven/MavenRepositoryLike.scala`

> A [[Repository]] instance backed by a Maven repository
>
> As such, it has a root URL, and may require some authentication. Methods below allows to read
> and update those.

```scala
trait MavenRepositoryLike extends Repository
```

```scala
def root: String
```

```scala
def authentication: Option[Authentication]
```

```scala
def versionsCheckHasModule: Boolean
```

```scala
def withRoot(root: String): MavenRepositoryLike
```

```scala
def withAuthentication(authentication: Option[Authentication]): MavenRepositoryLike
```

```scala
def withVersionsCheckHasModule(versionsCheckHasModule: Boolean): MavenRepositoryLike
```

```scala
def urlFor(path: Seq[String], isDir: Boolean = false): String
```

```scala
def artifactFor(url: String, changing: Boolean): Artifact
```

```scala
def moduleDirectory(module: Module): String
```

```scala
object MavenRepositoryLike
```

```scala
trait WithModuleSupport extends MavenRepositoryLike with ArtifactSource.ModuleBased
```

```scala
def checkModule: Boolean
```

```scala
def withCheckModule(checkModule: Boolean): MavenRepositoryLike
```

#### `scala/coursier/maven/Pom.scala`

```scala
object Pom
```

> Returns either a property's key-value pair or an error if the elem is not an element.
>
> This method trims all spaces, whereas Maven has an option to preserve them.
>
> @param elem
> a property element
> @return
> the key and the value of the property
> @see
> [[https://issues.apache.org/jira/browse/MNG-5380]]

```scala
def property(elem: Node): Either[String, (String, String)] = ...
```

```scala
def dependency(node: Node): Either[String, (Configuration, Dependency)] = ...
```

```scala
def profile(node: Node): Either[String, Profile] = ...
```

```scala
def packagingOpt(pom: Node): Option[Type] = ...
```

```scala
def project(pom: Node): Either[String, Project] = ...
```

```scala
def versions(node: Node): Either[String, Versions] = ...
```

```scala
def snapshotVersion(node: Node): Either[String, SnapshotVersion] = ...
```

> If `snapshotVersion` is missing, guess it based on `version`, `timestamp` and `buildNumber`,
> as is done in:
> https://github.com/sbt/ivy/blob/2.3.x-sbt/src/java/org/apache/ivy/plugins/resolver/IBiblioResolver.java

```scala
def guessedSnapshotVersion(
    version: String,
    timestamp: String,
    buildNumber: Int
  ): SnapshotVersion = ...
```

```scala
def snapshotVersioning(node: Node): Either[String, SnapshotVersioning] = ...
```

```scala
val extraAttributeSeparator = ...
```

```scala
val extraAttributePrefix = ...
```

```scala
val extraAttributeOrg = ...
```

```scala
val extraAttributeName = ...
```

```scala
val extraAttributeVersion = ...
```

```scala
val extraAttributeBase = ...
```

```scala
val extraAttributeDropPrefix = ...
```

```scala
def addOptionalDependenciesInConfig(
    proj: Project,
    fromConfigs: Set[Configuration],
    optionalConfig: Configuration
  ): Project = ...
```

#### `scala/coursier/maven/PomParser.scala`

```scala
final class PomParser extends SaxHandler
```

```scala
def startElement(tagName: String): Unit = ...
```

```scala
def characters(ch: Array[Char], start: Int, length: Int): Unit = ...
```

```scala
def endElement(tagName: String): Unit = ...
```

```scala
def project: Either[String, Project] = ...
```

```scala
object PomParser
```

#### `scala/coursier/util/Config.scala`

```scala
@deprecated("Unused by coursier", "2.1.25")
object Config
```

```scala
def allDependenciesByConfig0(
    res: Resolution,
    depsByConfig: Map[Configuration, Set[Dependency]],
    configs: Map[Configuration, Set[Configuration]]
  ): Either[DependencyError, Map[Configuration, Set[Dependency]]] = ...
```

```scala
  @deprecated("Use allDependenciesByConfig0 instead", "2.1.25")
def allDependenciesByConfig(
    res: Resolution,
    depsByConfig: Map[Configuration, Set[Dependency]],
    configs: Map[Configuration, Set[Configuration]]
  ): Map[Configuration, Set[Dependency]] = ...
```

```scala
def dependenciesWithConfig(
    res: Resolution,
    depsByConfig: Map[Configuration, Set[Dependency]],
    configs: Map[Configuration, Set[Configuration]]
  ): Set[Dependency] = ...
```

#### `scala/coursier/util/Print.scala`

```scala
object Print
```

```scala
object Colors
```

```scala
def get(colors: Boolean): Colors = ...
```

```scala
  @data class Colors private (red: String, yellow: String, reset: String)
def dependency(dep: Dependency): String = ...
```

```scala
def dependency(dep: Dependency, printExclusions: Boolean): String = ...
```

```scala
def dependenciesUnknownConfigs0(
    deps: Seq[Dependency],
    projects: Map[(Module, VersionConstraint), Project]
  ): String = ...
```

```scala
  @deprecated("Use dependenciesUnknownConfigs0 instead", "2.1.25")
def dependenciesUnknownConfigs(
    deps: Seq[Dependency],
    projects: Map[(Module, String), Project]
  ): String = ...
```

```scala
def dependenciesUnknownConfigs0(
    deps: Seq[Dependency],
    projects: Map[(Module, VersionConstraint), Project],
    printExclusions: Boolean,
    useFinalVersions: Boolean = true,
    reorder: Boolean = false
  ): String = ...
```

```scala
  @deprecated("Use dependenciesUnknownConfigs0 instead", "2.1.25")
def dependenciesUnknownConfigs(
    deps: Seq[Dependency],
    projects: Map[(Module, String), Project],
    printExclusions: Boolean,
    useFinalVersions: Boolean = true,
    reorder: Boolean = false
  ): String = ...
```

```scala
def compatibleVersions(compatibleWith: VersionConstraint, selected: Version): Boolean = ...
```

```scala
  @deprecated("Use the override accepting a VersionConstraint and a Version instead", "2.1.25")
def compatibleVersions(compatibleWith: String, selected: String): Boolean = ...
```

```scala
def dependencyTree(
    resolution: Resolution,
    roots: Seq[Dependency] = null,
    printExclusions: Boolean = false,
    reverse: Boolean = false,
    colors: Boolean = true
  ): String = ...
```

```scala
def conflicts(conflicts: Seq[Conflict]): Seq[String] = ...
```

#### `scala/coursier/util/SaxHandler.scala`

```scala
abstract class SaxHandler
```

```scala
def startElement(tagName: String): Unit // TODO attributes
```

```scala
def characters(ch: Array[Char], start: Int, length: Int): Unit
```

```scala
def endElement(tagName: String): Unit
```

#### `scala/coursier/util/Tree.scala`

```scala
object Tree
```

```scala
def apply[A](roots: IndexedSeq[A])(children: A => Seq[A]) = ...
```

```scala
final class Tree[A](val roots: IndexedSeq[A], val children: A => Seq[A])
```

```scala
def render(show: A => String): String = ...
```

```scala
def customRender(
    assumeTopRoot: Boolean = true,
    extraPrefix: String = "",
    extraSeparator: Option[String] = None
  )(show: A => String): String = ...
```

#### `scala/coursier/util/Xml.scala`

```scala
object Xml
```

> A representation of an XML node/document, with different implementations on JVM and JS

```scala
trait Node
```

```scala
def label: String
```

> Namespace / key / value

```scala
def attributes: Seq[(String, String, String)]
```

```scala
def children: Seq[Node]
```

```scala
def isText: Boolean
```

```scala
def textContent: String
```

```scala
def isElement: Boolean
```

```scala
def attributesFromNamespace(namespace: String): Seq[(String, String)] = ...
```

```scala
lazy val attributesMap = ...
```

```scala
def attribute(name: String): Either[String, String] = ...
```

```scala
object Node
```

```scala
val empty: Node = ...
```

```scala
object Text
```

```scala
def unapply(n: Node): Option[String] = ...
```

```scala
def text(elem: Node, label: String, description: String): Either[String, String] = ...
```

```scala
def parseDateTime(s: String): Option[Versions.DateTime] = ...
```

### `io.get-coursier:coursier-cache_2.13:2.1.25-M3`

Source: https://repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M3/coursier-cache_2.13-2.1.25-M3-sources.jar

#### `coursier/cache/ArchiveCache.scala`

```scala
object ArchiveCache
```

```scala
def apply[F[_]]()(implicit S: Sync[F] = Task.sync): ArchiveCache[F] = ...
```

```scala
def priviledged[F[_]]()(implicit S: Sync[F] = Task.sync): ArchiveCache[F] = ...
```

#### `coursier/cache/ArchiveType.scala`

```scala
sealed abstract class ArchiveType extends Product with Serializable
```

```scala
def singleFile: Boolean = ...
```

```scala
object ArchiveType
```

```scala
sealed abstract class Tar extends ArchiveType
```

```scala
sealed abstract class Compressed extends ArchiveType
```

```scala
override def singleFile: Boolean = ...
```

```scala
def tar: Tar
```

```scala
case object Zip  extends ArchiveType
```

```scala
case object Ar   extends ArchiveType
```

```scala
case object Tar  extends Tar
```

```scala
case object Tgz  extends Tar
```

```scala
case object Tbz2 extends Tar
```

```scala
case object Txz  extends Tar
```

```scala
case object Tzst extends Tar
```

```scala
case object Gzip extends Compressed
```

```scala
def tar = ...
```

```scala
case object Xz extends Compressed
```

```scala
def tar = ...
```

```scala
def parse(input: String): Option[ArchiveType] = ...
```

```scala
def fromMimeType(mimeType: String): Option[ArchiveType] = ...
```

#### `coursier/cache/ArtifactError.scala`

```scala
sealed abstract class ArtifactError(
  val `type`: String,
  val message: String,
  parentOpt: Option[Throwable]
) extends Exception(s"${`type`}: $message", parentOpt.orNull)
```

```scala
def this(`type`: String, message: String) = ...
```

```scala
def describe: String = ...
```

```scala
final def notFound: Boolean = ...
```

```scala
final def forbidden: Boolean = ...
```

```scala
object ArtifactError
```

```scala
final class DownloadError(val reason: String, e: Option[Throwable]) extends ArtifactError(
    "download error",
    reason,
    e
  )
```

```scala
final class NotFound(
    val file: String,
    val permanent: Option[Boolean] = None
  ) extends ArtifactError(
    "not found",
    file
  )
```

```scala
final class Forbidden(
    val file: String
  ) extends ArtifactError(
    "forbidden",
    file
  )
```

```scala
final class Unauthorized(
    val file: String,
    val realm: Option[String]
  ) extends ArtifactError(
    "unauthorized",
    file + realm.fold("")(" (" + _ + ")")
  )
```

```scala
final class ChecksumNotFound(
    val sumType: String,
    val file: String
  ) extends ArtifactError(
    "checksum not found",
    file
  )
```

```scala
final class ChecksumErrors(
    val errors: Seq[(String, String)]
  ) extends ArtifactError(
    "checksum errors",
    errors.map { case (k, v) => s"$k: $v" }.mkString(", ")
  )
```

```scala
final class ChecksumFormatError(
    val sumType: String,
    val file: String
  ) extends ArtifactError(
    "checksum format error",
    file
  )
```

```scala
final class WrongChecksum(
    val sumType: String,
    val got: String,
    val expected: String,
    val file: String,
    val sumFile: String
  ) extends ArtifactError(
    "wrong checksum",
    s"$file (expected $sumType $expected in $sumFile, got $got)"
  )
```

```scala
final class WrongLength(
    val got: Long,
    val expected: Long,
    val file: String
  ) extends ArtifactError(
    "wrong length",
    s"$file (expected $expected B, got $got B)"
  )
```

```scala
final class FileTooOldOrNotFound(
    val file: String
  ) extends ArtifactError(
    "file in cache not found or too old",
    file
  )
```

```scala
final class ForbiddenChangingArtifact(val url: String) extends ArtifactError(
    "changing artifact found",
    url
  )
```

```scala
sealed abstract class Recoverable(
    `type`: String,
    message: String,
    parentOpt: Option[Throwable]
  ) extends ArtifactError(`type`, message, parentOpt)
```

```scala
def this(`type`: String, message: String) = ...
```

```scala
final class Locked(val file: File) extends Recoverable(
    "locked",
    file.toString
  )
```

```scala
  @deprecated("Not thrown by coursier anymore", "2.1.0-RC2")
final class ConcurrentDownload(val url: String) extends Recoverable(
    "concurrent download",
    url
  )
```

#### `coursier/cache/AuthenticatedURLConnection.scala`

```scala
trait AuthenticatedURLConnection extends URLConnection
```

```scala
def authenticate(authentication: Authentication): Unit
```

#### `coursier/cache/CacheChecksum.scala`

```scala
object CacheChecksum
```

```scala
def parseChecksum(content: String): Option[BigInteger] = ...
```

```scala
def parseRawChecksum(content: Array[Byte]): Option[BigInteger] = ...
```

#### `coursier/cache/CacheDefaults.scala`

```scala
object CacheDefaults
```

```scala
lazy val location: File = ...
```

```scala
lazy val archiveCacheLocation: File = ...
```

```scala
lazy val priviledgedArchiveCacheLocation: File = ...
```

```scala
lazy val digestBasedCacheLocation: File = ...
```

```scala
def warnLegacyCacheLocation(): Unit = ...
```

```scala
lazy val concurrentDownloadCount: Int = ...
```

```scala
lazy val pool = ...
```

```scala
def parseDuration(s: String): Either[Throwable, Duration] = ...
```

```scala
lazy val ttl: Option[Duration] = ...
```

```scala
val checksums = ...
```

```scala
def defaultRetryCount = ...
```

```scala
lazy val retryCount = ...
```

```scala
lazy val retryBackoffInitialDelay = ...
```

```scala
lazy val retryBackoffMultiplier = ...
```

```scala
  @deprecated("Use retryCount instead", "2.1.11")
lazy val sslRetryCount = ...
```

```scala
lazy val maxRedirections: Option[Int] = ...
```

```scala
val bufferSize = ...
```

```scala
def credentials: Seq[Credentials] = ...
```

```scala
def credentialsFromConfig(configPath: Path): Seq[Credentials] = ...
```

```scala
val noEnvCachePolicies = ...
```

```scala
def cachePolicies: Seq[CachePolicy] = ...
```

#### `coursier/cache/CacheLocks.scala`

```scala
object CacheLocks
```

> Should be acquired when doing operations changing the file structure of the cache (creating
> new directories, creating / acquiring locks, ...), so that these don't hinder each other.
>
> Should hopefully address some transient errors seen on the CI of ensime-server.

```scala
def withStructureLock[T](cache: File)(f: => T): T = ...
```

```scala
def withStructureLock[T](cache: Path)(f: => T): T = ...
```

```scala
def withLockOr[T](
    cache: File,
    file: File
  )(
    f: => T,
    ifLocked: => Option[T]
  ): T = ...
```

```scala
def withLockOr[T](
    cache: File,
    file: File,
    retry: Retry
  )(
    f: => T,
    ifLocked: => Option[T]
  ): T = ...
```

```scala
def withLockFor[T](
    cache: File,
    file: File
  )(f: => Either[ArtifactError, T]): Either[ArtifactError, T] = ...
```

```scala
def withUrlLock[T](url: String)(f: => T): Option[T] = ...
```

#### `coursier/cache/CachePolicy.scala`

```scala
sealed abstract class CachePolicy extends Product with Serializable
```

```scala
def acceptChanging: CachePolicy.Mixed
```

```scala
def rejectChanging: CachePolicy.NoChanging
```

```scala
def acceptsChangingArtifacts: Boolean
```

```scala
object CachePolicy
```

```scala
sealed abstract class Mixed extends CachePolicy
```

```scala
def acceptChanging: Mixed = ...
```

```scala
def acceptsChangingArtifacts: Boolean = ...
```

> Only pick local files, possibly from the cache. Don't try to download anything.

```scala
case object LocalOnly extends Mixed
```

```scala
def rejectChanging = ...
```

> Only pick local files, possibly from the cache. Don't return changing artifacts (whose last
> check is) older than TTL

```scala
case object LocalOnlyIfValid extends Mixed
```

```scala
def rejectChanging = ...
```

> Only pick local files. If one of these local files corresponds to a changing artifact, check
> for updates, and download these if needed.
>
> If no local file is found, *don't* try download it. Updates are only checked for files already
> in cache.
>
> Follows the TTL parameter (assumes no update is needed if the last one is recent enough).

```scala
case object LocalUpdateChanging extends Mixed
```

```scala
def rejectChanging = ...
```

> Only pick local files, check if any update is available for them, and download these if
> needed.
>
> If no local file is found, *don't* try download it. Updates are only checked for files already
> in cache.
>
> Follows the TTL parameter (assumes no update is needed if the last one is recent enough).
>
> Unlike `LocalUpdateChanging`, all found local files are checked for updates, not just the
> changing ones.

```scala
case object LocalUpdate extends Mixed
```

```scala
def rejectChanging = ...
```

> Pick local files, and download the missing ones.
>
> For changing ones, check for updates, and download those if any.
>
> Follows the TTL parameter (assumes no update is needed if the last one is recent enough).

```scala
case object UpdateChanging extends Mixed
```

```scala
def rejectChanging = ...
```

> Pick local files, download the missing ones, check for updates and download those if any.
>
> Follows the TTL parameter (assumes no update is needed if the last one is recent enough).
>
> Unlike `UpdateChanging`, all found local files are checked for updates, not just the changing
> ones.

```scala
case object Update extends Mixed
```

```scala
def rejectChanging = ...
```

> Pick local files, download the missing ones.
>
> No updates are checked for files already downloaded.

```scala
case object FetchMissing extends Mixed
```

```scala
def rejectChanging = ...
```

> (Re-)download all files.
>
> Erases files already in cache.

```scala
case object ForceDownload extends Mixed
```

```scala
def rejectChanging = ...
```

```scala
sealed abstract class NoChanging extends CachePolicy
```

```scala
def rejectChanging: CachePolicy.NoChanging = ...
```

```scala
def acceptsChangingArtifacts: Boolean = ...
```

```scala
object NoChanging
```

```scala
case object LocalOnly extends NoChanging
```

```scala
def acceptChanging = ...
```

```scala
case object LocalUpdate extends NoChanging
```

```scala
def acceptChanging = ...
```

```scala
case object FetchMissing extends NoChanging
```

```scala
def acceptChanging = ...
```

```scala
case object ForceDownload extends NoChanging
```

```scala
def acceptChanging = ...
```

#### `coursier/cache/CacheUrl.scala`

```scala
object CacheUrl
```

> Returns a `java.net.URL` for `s`, possibly using the custom protocol handlers found under the
> `coursier.cache.protocol` namespace.
>
> E.g. URL `"test://abc.com/foo"`, having protocol `"test"`, can be handled by a
> `URLStreamHandler` named `coursier.cache.protocol.TestHandler` (protocol name gets
> capitalized, and suffixed with `Handler` to get the class name).
>
> @param s
> @param classLoaders:
> class loaders to load custom protocol handlers from
> @return

```scala
def url(s: String, classLoaders: Seq[ClassLoader]): URL = ...
```

```scala
def url(s: String): URL = ...
```

```scala
  @deprecated("Create a ConnectionBuilder() and call connection() on it instead", "2.0.0")
def urlConnection(
    url0: String,
    authentication: Option[Authentication],
    followHttpToHttpsRedirections: Boolean = false,
    followHttpsToHttpRedirections: Boolean = false,
    credentials: Seq[DirectCredentials] = Nil,
    sslSocketFactoryOpt: Option[SSLSocketFactory] = None,
    hostnameVerifierOpt: Option[HostnameVerifier] = None,
    method: String = "GET",
    maxRedirectionsOpt: Option[Int] = Some(20)
  ): URLConnection = ...
```

```scala
def urlConnectionMaybePartial(
    url0: String,
    authentication: Option[Authentication],
    alreadyDownloaded: Long,
    followHttpToHttpsRedirections: Boolean,
    followHttpsToHttpRedirections: Boolean,
    autoCredentials: Seq[DirectCredentials],
    sslSocketFactoryOpt: Option[SSLSocketFactory],
    hostnameVerifierOpt: Option[HostnameVerifier],
    method: String,
    maxRedirectionsOpt: Option[Int]
  ): (URLConnection, Boolean) = ...
```

```scala
def responseCode(conn: URLConnection): Option[Int] = ...
```

```scala
def realm(conn: URLConnection): Option[String] = ...
```

```scala
  @deprecated("Use coursier.proxy.SetupProxy.setup() instead", "2.1.0-M7")
def setupProxyAuth(credentials: Map[(String, String, String), (String, String)]): Unit = ...
```

```scala
  @deprecated("Use coursier.proxy.SetupProxy.setup() instead", "2.1.0-M7")
def setupProxyAuth(): Unit = ...
```

```scala
def disableProxyAuth(): Unit = ...
```

#### `coursier/cache/DigestBasedCache.scala`

```scala
object DigestBasedCache
```

```scala
def apply(): DigestBasedCache[Task] = ...
```

#### `coursier/cache/FileCache.scala`

```scala
object FileCache
```

```scala
def apply[F[_]]()(implicit S: Sync[F] = Task.sync): FileCache[F] = ...
```

#### `coursier/cache/MockCache.scala`

```scala
object MockCache
```

```scala
def create[F[_]: Sync](
    base: Path,
    pool: ExecutorService,
    extraData: Seq[Path] = Nil,
    writeMissing: Boolean = false
  ): MockCache[F] = ...
```

#### `coursier/cache/PlatformCache.scala`

```scala
abstract class PlatformCache[F[_]]
```

> This method computes the task needed to get a file.

```scala
def file(artifact: Artifact): EitherT[F, ArtifactError, File]
```

#### `coursier/cache/PlatformCacheCompanion.scala`

```scala
abstract class PlatformCacheCompanion
```

```scala
lazy val default: Cache[Task] = ...
```

#### `coursier/cache/UnArchiver.scala`

```scala
trait UnArchiver
```

```scala
def extract(archiveType: ArchiveType, archive: File, destDir: File, overwrite: Boolean): Unit
```

```scala
object UnArchiver
```

```scala
trait OpenStream
```

```scala
def inputStream(archiveType: ArchiveType.Compressed, is: InputStream): InputStream
```

```scala
def default(): UnArchiver with OpenStream = ...
```

```scala
def priviledged(): UnArchiver = ...
```

```scala
def priviledgedTestMode(): UnArchiver = ...
```

#### `coursier/cache/internal/ConsoleDim.scala`

```scala
final class ConsoleDim
```

```scala
def width(): Int = ...
```

```scala
def height(): Int = ...
```

```scala
object ConsoleDim
```

```scala
lazy val get: ConsoleDim = ...
```

```scala
def width(): Int = ...
```

```scala
def height(): Int = ...
```

#### `coursier/cache/internal/Downloader.scala`

```scala
object Downloader
```

#### `coursier/cache/internal/FileUtil.scala`

```scala
object FileUtil
```

```scala
def readFullyUnsafe(is: InputStream): Array[Byte] = ...
```

```scala
def readFully(is: => InputStream): Array[Byte] = ...
```

```scala
def withContent(is: InputStream, f: WithContent, bufferSize: Int = 16384): Unit = ...
```

```scala
trait WithContent
```

```scala
def apply(arr: Array[Byte], z: Int): Unit
```

```scala
class UpdateDigest(md: java.security.MessageDigest) extends FileUtil.WithContent
```

```scala
def apply(arr: Array[Byte], z: Int): Unit = ...
```

#### `coursier/cache/internal/Retry.scala`

```scala
final case class Retry(
  count: Int,
  initialDelay: FiniteDuration,
  delayMultiplier: Double
)
```

```scala
def retry[T](f: => T)(catchEx: PartialFunction[Throwable, Unit]): T = ...
```

```scala
def retryOpt[T](f: => Option[T])(catchEx: PartialFunction[Throwable, Unit]): T = ...
```

#### `coursier/cache/internal/SigWinchNativeWindows.java`

```java
@TargetClass(className = "coursier.cache.internal.SigWinch")
@Platforms(Platform.WINDOWS.class)
public final class SigWinchNativeWindows
```

```java
  @Substitute
public static void addHandler(Runnable runnable)
```

#### `coursier/cache/internal/Terminal.scala`

```scala
object Terminal
```

```scala
  @deprecated("Should be made private at some point in future releases", "2.0.0-RC3")
lazy val ttyAvailable: Boolean = ...
```

```scala
  @deprecated("Should be removed at some point in future releases", "2.0.0-RC3")
def consoleDim(s: String): Option[Int] = ...
```

```scala
  @deprecated("Should be removed at some point in future releases", "2.0.0-RC3")
def consoleDimOrThrow(s: String): Int = ...
```

```scala
def consoleDims(): (Int, Int) = ...
```

```scala
implicit class Ansi(val output: Writer) extends AnyVal
```

```scala
def up(n: Int): Unit = ...
```

```scala
def down(n: Int): Unit = ...
```

```scala
def left(n: Int): Unit = ...
```

```scala
def clearLine(n: Int): Unit = ...
```

#### `coursier/cache/internal/ThreadUtil.scala`

```scala
object ThreadUtil
```

```scala
def daemonThreadFactory(): ThreadFactory = ...
```

```scala
def fixedThreadPool(size: Int): ExecutorService = ...
```

```scala
def fixedScheduledThreadPool(size: Int): ScheduledExecutorService = ...
```

```scala
def withFixedThreadPool[T](size: Int)(f: ExecutorService => T): T = ...
```

#### `coursier/cache/internal/TmpConfig.scala`

```scala
@deprecated("Unused by coursier now", "2.1.15")
object TmpConfig
```

```scala
  @deprecated("Use scala.cli.config.Keys.repositoryCredentials instead", "2.1.15")
val credentialsKey: Key[List[DirectCredentials]] = ...
```

#### `coursier/cache/loggers/FallbackRefreshDisplay.scala`

```scala
class FallbackRefreshDisplay(quiet: Boolean = false) extends RefreshDisplay
```

```scala
val refreshInterval: Duration = ...
```

```scala
override def newEntry(out: Writer, url: String, info: RefreshInfo): Unit = ...
```

```scala
override def removeEntry(out: Writer, url: String, info: RefreshInfo): Unit = ...
```

```scala
def update(
    out: Writer,
    done: Seq[(String, RefreshInfo)],
    downloads: Seq[(String, RefreshInfo)],
    changed: Boolean
  ): Unit = ...
```

```scala
override def stop(out: Writer): Unit = ...
```

#### `coursier/cache/loggers/FileTypeRefreshDisplay.scala`

```scala
class FileTypeRefreshDisplay(
  /** Whether to keep details on screen after this display is stopped */
  val keepOnScreen: Boolean,
  beforeOutput: => Unit,
  afterOutput: => Unit
) extends RefreshDisplay
```

```scala
val refreshInterval: Duration = ...
```

```scala
override def sizeHint(n: Int) = ...
```

```scala
override def stop(out: Writer): Unit = ...
```

```scala
def update(
    out: Writer,
    done0: Seq[(String, RefreshInfo)],
    downloads: Seq[(String, RefreshInfo)],
    changed: Boolean
  ): Unit = ...
```

```scala
object FileTypeRefreshDisplay
```

```scala
def create(): FileTypeRefreshDisplay = ...
```

```scala
def create(keepOnScreen: Boolean): FileTypeRefreshDisplay = ...
```

```scala
def create(
    keepOnScreen: Boolean,
    beforeOutput: => Unit,
    afterOutput: => Unit
  ): FileTypeRefreshDisplay = ...
```

#### `coursier/cache/loggers/ProgressBarRefreshDisplay.scala`

```scala
class ProgressBarRefreshDisplay(
  beforeOutput: => Unit,
  afterOutput: => Unit
) extends RefreshDisplay
```

```scala
val refreshInterval: Duration = ...
```

```scala
override def stop(out: Writer): Unit = ...
```

```scala
def update(
    out: Writer,
    done: Seq[(String, RefreshInfo)],
    downloads: Seq[(String, RefreshInfo)],
    changed: Boolean
  ): Unit = ...
```

```scala
object ProgressBarRefreshDisplay
```

```scala
def create(): ProgressBarRefreshDisplay = ...
```

```scala
def create(
    beforeOutput: => Unit,
    afterOutput: => Unit
  ): ProgressBarRefreshDisplay = ...
```

```scala
def byteCount(bytes: Long, si: Boolean = false) = ...
```

#### `coursier/cache/loggers/RefreshDisplay.scala`

```scala
trait RefreshDisplay
```

```scala
def newEntry(out: Writer, url: String, info: RefreshInfo): Unit = ...
```

```scala
def removeEntry(out: Writer, url: String, info: RefreshInfo): Unit = ...
```

```scala
def sizeHint(n: Int): Unit = ...
```

```scala
def update(
    out: Writer,
    done: Seq[(String, RefreshInfo)],
    downloads: Seq[(String, RefreshInfo)],
    changed: Boolean
  ): Unit
```

```scala
def stop(out: Writer): Unit = ...
```

```scala
def refreshInterval: Duration
```

```scala
object RefreshDisplay
```

```scala
def truncated(s: String, width: Int): String = ...
```

#### `coursier/cache/loggers/RefreshInfo.scala`

```scala
sealed abstract class RefreshInfo extends Product with Serializable
```

```scala
def fraction: Option[Double]
```

```scala
def watching: Boolean
```

```scala
def success: Boolean
```

```scala
def withSuccess(success: Boolean): RefreshInfo
```

```scala
  @deprecated("Call the override accepting an argument", "2.1.25")
final def withSuccess(): RefreshInfo = ...
```

```scala
object RefreshInfo
```

#### `coursier/cache/loggers/RefreshLogger.scala`

```scala
object RefreshLogger
```

```scala
def defaultDisplay(
    fallbackMode: Boolean = defaultFallbackMode,
    quiet: Boolean = false
  ): RefreshDisplay = ...
```

```scala
def create(): RefreshLogger = ...
```

```scala
def create(os: OutputStream): RefreshLogger = ...
```

```scala
def create(writer: OutputStreamWriter): RefreshLogger = ...
```

```scala
def create(display: RefreshDisplay): RefreshLogger = ...
```

```scala
def create(os: OutputStream, display: RefreshDisplay): RefreshLogger = ...
```

```scala
def create(os: OutputStream, display: RefreshDisplay, logChanging: Boolean): RefreshLogger = ...
```

```scala
def create(
    os: OutputStream,
    display: RefreshDisplay,
    logChanging: Boolean,
    logPickedVersions: Boolean
  ): RefreshLogger = ...
```

```scala
def create(writer: OutputStreamWriter, display: RefreshDisplay): RefreshLogger = ...
```

```scala
def create(
    writer: OutputStreamWriter,
    display: RefreshDisplay,
    logChanging: Boolean
  ): RefreshLogger = ...
```

```scala
def create(
    writer: OutputStreamWriter,
    display: RefreshDisplay,
    logChanging: Boolean,
    logPickedVersions: Boolean
  ): RefreshLogger = ...
```

```scala
lazy val defaultFallbackMode: Boolean = ...
```

```scala
class RefreshLogger(
  out: Writer,
  display: RefreshDisplay,
  val fallbackMode: Boolean = RefreshLogger.defaultFallbackMode,
  logChanging: Boolean = false,
  logPickedVersions: Boolean = false
) extends CacheLogger
```

```scala
def this(
    out: Writer,
    display: RefreshDisplay
  ) = ...
```

```scala
def this(
    out: Writer,
    display: RefreshDisplay,
    fallbackMode: Boolean
  ) = ...
```

```scala
override def init(sizeHint: Option[Int]): Unit = ...
```

```scala
override def stop(): Unit = ...
```

```scala
override def checkingArtifact(url: String, artifact: Artifact): Unit = ...
```

```scala
override def pickedModuleVersion(module: String, version: String): Unit = ...
```

```scala
override def downloadingArtifact(url: String, artifact: Artifact): Unit = ...
```

```scala
override def downloadLength(
    url: String,
    totalLength: Long,
    alreadyDownloaded: Long,
    watching: Boolean
  ): Unit = ...
```

```scala
override def downloadProgress(url: String, downloaded: Long): Unit = ...
```

```scala
override def downloadedArtifact(url: String, success: Boolean): Unit = ...
```

```scala
override def checkingUpdates(url: String, currentTimeOpt: Option[Long]): Unit = ...
```

```scala
override def checkingUpdatesResult(
    url: String,
    currentTimeOpt: Option[Long],
    remoteTimeOpt: Option[Long]
  ): Unit = ...
```

#### `coursier/cache/loggers/SingleLineRefreshDisplay.scala`

```scala
class SingleLineRefreshDisplay(
  beforeOutput: => Unit,
  afterOutput: => Unit
) extends RefreshDisplay
```

```scala
val refreshInterval: Duration = ...
```

```scala
override def stop(out: Writer): Unit = ...
```

```scala
def update(
    out: Writer,
    done: Seq[(String, RefreshInfo)],
    downloads: Seq[(String, RefreshInfo)],
    changed: Boolean
  ): Unit = ...
```

```scala
object SingleLineRefreshDisplay
```

```scala
def create(): SingleLineRefreshDisplay = ...
```

```scala
def create(
    beforeOutput: => Unit,
    afterOutput: => Unit
  ): SingleLineRefreshDisplay = ...
```

```scala
def byteCount(bytes: Long, si: Boolean = false) = ...
```

#### `coursier/parse/CachePolicyParser.scala`

```scala
object CachePolicyParser
```

```scala
def cachePolicy(input: String): Either[String, CachePolicy] = ...
```

```scala
def cachePolicies(input: String): ValidationNel[String, Seq[CachePolicy]] = ...
```

```scala
def cachePolicies(
    input: String,
    default: Seq[CachePolicy]
  ): ValidationNel[String, Seq[CachePolicy]] = ...
```

#### `coursier/util/PlatformSync.scala`

```scala
trait PlatformSync[F[_]]
```

```scala
def schedule[A](pool: ExecutorService)(f: => A): F[A]
```

#### `coursier/util/PlatformSyncCompanion.scala`

```scala
abstract class PlatformSyncCompanion
```

#### `coursier/util/PlatformTaskCompanion.scala`

```scala
abstract class PlatformTaskCompanion
```

```scala
def schedule[A](pool: ExecutorService)(f: => A): Task[A] = ...
```

```scala
def completeAfter(pool: ScheduledExecutorService, duration: FiniteDuration): Task[Unit] = ...
```

```scala
implicit val sync: Sync[Task] = ...
```

```scala
implicit class PlatformTaskOps[T](private val task: Task[T])
```

```scala
def unsafeRun()(implicit ec: ExecutionContext): T = ...
```

#### `main/java/coursier/paths/CachePath.java`

> Cache paths logic, shared by the cache and bootstrap modules

```java
public class CachePath
```

```java
public static File localFile(String url, File cache, String user, boolean localArtifactsShouldBeCached) throws MalformedURLException
```

```java
public static File temporaryFile(File file)
```

```java
public static Path lockFile(Path path)
```

```java
public static File lockFile(File file)
```

```java
public static File defaultCacheDirectory() throws IOException
```

```java
public static File defaultArchiveCacheDirectory() throws IOException
```

```java
public static File defaultPriviledgedArchiveCacheDirectory() throws IOException
```

```java
public static File defaultDigestBasedCacheDirectory() throws IOException
```

```java
public static <V> V withStructureLock(File cache, Callable<V> callable) throws Exception
```

```java
public static <V> V withStructureLock(Path cache, Callable<V> callable) throws Exception
```

#### `main/java/coursier/paths/CoursierPaths.java`

> Computes Coursier's directories according to the standard
> defined by operating system Coursier is running on.
>
> @implNote If more paths e. g. for configuration or application data is required,
> use {@link #coursierDirectories} and do not roll your own logic.

```java
public final class CoursierPaths
```

```java
public static File cacheDirectory() throws IOException
```

```java
public static File archiveCacheDirectory() throws IOException
```

```java
public static File priviledgedArchiveCacheDirectory() throws IOException
```

```java
public static File digestBasedCacheDirectory() throws IOException
```

```java
public static File jvmCacheDirectory() throws IOException
```

```java
public static ProjectDirectories directoriesInstance(String name)
```

```java
public static File[] configDirectories() throws IOException
```

```java
    @Deprecated
public static File configDirectory() throws IOException
```

```java
public static File defaultConfigDirectory() throws IOException
```

```java
public static File dataLocalDirectory() throws IOException
```

```java
public static File projectCacheDirectory() throws IOException
```

```java
public static Path scalaConfigFile() throws Throwable
```

#### `main/java/coursier/paths/Jep.java`

```java
public class Jep
```

```java
final char[] buffer = ...
```

```java
final StringBuilder out = ...
```

```java
public static class JepException extends Exception
```

```java
public static File location() throws Exception
```

```java
public static File jar(File jepDirectory) throws JepException
```

```java
public static String version(File jepJar) throws JepException
```

```java
public static String pythonHome() throws Exception
```

```java
public static List<Map.Entry<String, String>> pythonProperties() throws Exception
```

#### `main/java/coursier/paths/Mirror.java`

```java
public class Mirror
```

```java
public final static class Types
```

```java
public static final String MAVEN = ...
```

```java
public static final String TREE = ...
```

```java
public static Mirror of(List<String> from, String to, String type)
```

```java
public static File[] defaultConfigFiles() throws IOException
```

```java
  @Deprecated
public static File defaultConfigFile() throws IOException
```

```java
public static File extraConfigFile() throws IOException
```

```java
public static List<Mirror> load() throws MirrorPropertiesException, IOException
```

```java
public static List<Mirror> parse(File file) throws MirrorPropertiesException, IOException
```

```java
public static class MirrorPropertiesException extends Exception
```

```java
public static List<Mirror> parse(Properties props) throws MirrorPropertiesException
```

```java
public List<String> from()
```

```java
public String to()
```

```java
public String type()
```

```java
  @Override
public boolean equals(Object obj)
```

```java
  @Override
public int hashCode()
```

```java
  @Override
public String toString()
```

```java
public String transform(String url)
```

```java
public String matches(String url)
```

```java
public String matches(String url, String defaults)
```

```java
public static String transform(List<Mirror> mirrors, String url)
```

#### `main/java/coursier/paths/Util.java`

```java
public class Util
```

```java
public static Map<String, String> expandProperties(Map<String, String> properties)
```

```java
public static Map<String, String> expandProperties(
        Properties systemProperties,
        Map<String, String> properties)
```

```java
final Map<String, String> resolved = ...
```

```java
final Map<String, String> withProps = ...
```

```java
public static void createDirectories(Path path) throws IOException
```

```java
public static boolean useColorOutput()
```

```java
public static boolean useAnsiOutput()
```

```java
public static boolean useJni()
```

```java
public static boolean useJni(Runnable beforeJni)
```

#### `scala/coursier/cache/Cache.scala`

```scala
abstract class Cache[F[_]] extends PlatformCache[F]
```

> Method to fetch an [[Artifact]].
>
> Note that this method tries all the [[coursier.cache.CachePolicy]] ies of this cache
> straightaway. During resolutions, you should prefer to try all repositories for the first
> policy, then the other policies if needed (in pseudo-code, `for (policy <- policies; repo <-
> repositories) …`, rather than `for (repo <- repositories, policy <- policies) …`). You should
> use the [[fetchs]] method in that case.

```scala
def fetch: Fetch[F]
```

> Sequence of [[Fetch]] able to fetch an [[Artifact]].
>
> Each element correspond to a [[coursier.cache.CachePolicy]] of this [[Cache]]. You may want to
> pass each of them to `coursier.core.ResolutionProcess.fetch0()`.
>
> @return
> a non empty sequence

```scala
def fetchs: Seq[Fetch[F]] = ...
```

```scala
def ec: ExecutionContext
```

```scala
def loggerOpt: Option[CacheLogger] = ...
```

```scala
object Cache extends PlatformCacheCompanion
```

```scala
type Fetch[F[_]] = ...
```

#### `scala/coursier/cache/CacheLogger.scala`

```scala
trait CacheLogger
```

```scala
def foundLocally(url: String): Unit = ...
```

```scala
def checkingArtifact(url: String, artifact: Artifact): Unit = ...
```

```scala
def downloadingArtifact(url: String): Unit = ...
```

```scala
def downloadingArtifact(url: String, artifact: Artifact): Unit = ...
```

```scala
def downloadProgress(url: String, downloaded: Long): Unit = ...
```

```scala
def downloadedArtifact(url: String, success: Boolean): Unit = ...
```

```scala
def checkingUpdates(url: String, currentTimeOpt: Option[Long]): Unit = ...
```

```scala
def checkingUpdatesResult(
    url: String,
    currentTimeOpt: Option[Long],
    remoteTimeOpt: Option[Long]
  ): Unit = ...
```

```scala
def downloadLength(
    url: String,
    totalLength: Long,
    alreadyDownloaded: Long,
    watching: Boolean
  ): Unit = ...
```

```scala
def gettingLength(url: String): Unit = ...
```

```scala
def gettingLengthResult(url: String, length: Option[Long]): Unit = ...
```

```scala
def removedCorruptFile(url: String, reason: Option[String]): Unit = ...
```

```scala
def pickedModuleVersion(module: String, version: String): Unit = ...
```

```scala
def init(sizeHint: Option[Int] = None): Unit = ...
```

```scala
def stop(): Unit = ...
```

```scala
final def use[T](f: => T): T = ...
```

```scala
final def using[T]: CacheLogger.Using[T] = ...
```

```scala
object CacheLogger
```

```scala
final class Using[T](logger: CacheLogger)
```

```scala
def apply[F[_]](task: F[T])(implicit sync: Sync[F]): F[T] = ...
```

```scala
def nop: CacheLogger = ...
```

#### `scala/coursier/cache/internal/MockCacheEscape.scala`

```scala
object MockCacheEscape
```

```scala
def urlAsPath(url: String): String = ...
```

#### `scala/coursier/util/Sync.scala`

```scala
trait Sync[F[_]] extends Gather[F] with PlatformSync[F]
```

```scala
def delay[A](a: => A): F[A]
```

```scala
def handle[A](a: F[A])(f: PartialFunction[Throwable, A]): F[A]
```

```scala
def fromAttempt[A](a: Either[Throwable, A]): F[A]
```

```scala
def attempt[A](f: F[A]): F[Either[Throwable, A]] = ...
```

```scala
object Sync extends PlatformSyncCompanion
```

```scala
def apply[F[_]](implicit sync: Sync[F]): Sync[F] = ...
```

#### `scala/coursier/util/Task.scala`

```scala
final case class Task[+T](value: ExecutionContext => Future[T]) extends AnyVal
```

```scala
def map[U](f: T => U): Task[U] = ...
```

```scala
def flatMap[U](f: T => Task[U]): Task[U] = ...
```

```scala
def handle[U >: T](f: PartialFunction[Throwable, U]): Task[U] = ...
```

```scala
def future()(implicit ec: ExecutionContext): Future[T] = ...
```

```scala
def attempt: Task[Either[Throwable, T]] = ...
```

```scala
def schedule(duration: Duration, es: ScheduledExecutorService): Task[T] = ...
```

```scala
object Task extends PlatformTaskCompanion
```

```scala
def point[A](a: A): Task[A] = ...
```

```scala
def delay[A](a: => A): Task[A] = ...
```

```scala
def never[A]: Task[A] = ...
```

```scala
def fromEither[T](e: Either[Throwable, T]): Task[T] = ...
```

```scala
def fail(e: Throwable): Task[Nothing] = ...
```

```scala
def tailRecM[A, B](a: A)(fn: A => Task[Either[A, B]]): Task[B] = ...
```

```scala
def gather: Gather[Task] = ...
```

```scala
final class WrappedException(cause: Throwable) extends Throwable(cause)
```

#### `scala/coursier/util/TaskSync.scala`

```scala
trait TaskSync extends Sync[Task]
```

```scala
def point[A](a: A) = ...
```

```scala
def bind[A, B](elem: Task[A])(f: A => Task[B]) = ...
```

```scala
override def map[A, B](elem: Task[A])(f: A => B): Task[B] = ...
```

```scala
def gather[A](elems: Seq[Task[A]]) = ...
```

```scala
def delay[A](a: => A) = ...
```

```scala
override def fromAttempt[A](a: Either[Throwable, A]): Task[A] = ...
```

```scala
def handle[A](a: Task[A])(f: PartialFunction[Throwable, A]) = ...
```

### `io.get-coursier:coursier-proxy-setup:2.1.25-M3`

Source: https://repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M3/coursier-proxy-setup-2.1.25-M3-sources.jar

#### `coursier/proxy/SetupProxy.java`

```java
public final class SetupProxy
```

```java
public static void setupTunnelingProp()
```

```java
        @Override
public void startDocument()
```

```java
        @Override
public void startElement(String uri, String localName, String qName, Attributes attributes)
```

```java
        @Override
public void characters(char[] ch, int start, int length)
```

```java
        @Override
public void endElement(String uri, String localName, String qName)
```

```java
public List<Map<String, String>> getProxies()
```

```java
static void setProperty(String key, String value)
```

```java
public static void setProxyProperties(
        String addressValue,
        String usernameValue,
        String passwordValue,
        String nonProxyHostsValue
    ) throws URISyntaxException
```

```java
public static void setProxyProperties(
        String protocolValue,
        String hostValue,
        String portValue,
        String usernameValue,
        String passwordValue,
        String nonProxyHostsValue,
        String propertyPrefix
    )
```

```java
public static void setupPropertiesFrom(File m2Settings, String propertyPrefix) throws ParserConfigurationException, SAXException, IOException
```

```java
public static void setupProperties() throws ParserConfigurationException, SAXException, IOException
```

```java
public static boolean setupAuthenticator(
            String httpProtocol,
            String httpHost,
            String httpPort,
            String httpUser,
            String httpPassword,
            String httpsProtocol,
            String httpsHost,
            String httpsPort,
            String httpsUser,
            String httpsPassword,
            String extraHttpProtocol,
            String extraHttpHost,
            String extraHttpPort,
            String extraHttpUser,
            String extraHttpPassword
    )
```

```java
public static boolean setupAuthenticator()
```

```java
public static boolean setup() throws ParserConfigurationException, SAXException, IOException
```

### `io.get-coursier:dependency_2.13:0.3.2`

Source: https://repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2/dependency_2.13-0.3.2-sources.jar

#### `dependency/CovariantSet.scala`

```scala
object CovariantSet extends IterableFactory[CovariantSet]
```

```scala
def from[A](source: IterableOnce[A]): CovariantSet[A] = ...
```

```scala
def empty[A]: CovariantSet[A] = ...
```

```scala
def newBuilder[A]: Builder[A, CovariantSet[A]] = ...
```

#### `dependency/DependencyLike.scala`

```scala
final case class DependencyLike[+A <: NameAttributes, +E <: NameAttributes](
  module: ModuleLike[A],
  version: String,
  exclude: CovariantSet[ModuleLike[E]],
  userParams: Seq[(String, Option[String])]
)
```

```scala
def applyParams(params: ScalaParameters): Dependency = ...
```

```scala
def organization: String = ...
```

```scala
def name: String = ...
```

```scala
def nameAttributes: A = ...
```

```scala
def attributes: Map[String, String] = ...
```

```scala
lazy val userParamsMap: Map[String, Seq[Option[String]]] = ...
```

```scala
def render: String = ...
```

```scala
override def toString: String = ...
```

```scala
object DependencyLike
```

```scala
def apply[A <: NameAttributes, E <: NameAttributes](
    module: ModuleLike[A],
    version: String,
    exclude: CovariantSet[ModuleLike[E]]
  ): DependencyLike[A, E] = ...
```

```scala
def apply[A <: NameAttributes](
    module: ModuleLike[A],
    version: String
  ): DependencyLike[A, NameAttributes] = ...
```

#### `dependency/ModuleLike.scala`

```scala
final case class ModuleLike[+A <: NameAttributes](
  organization: String,
  name: String,
  nameAttributes: A,
  attributes: Map[String, String]
)
```

```scala
def applyParams(params: ScalaParameters): Module = ...
```

```scala
def render: String = ...
```

```scala
def render(separator: String): String = ...
```

```scala
override def toString: String = ...
```

```scala
object ModuleLike
```

#### `dependency/NameAttributes.scala`

```scala
sealed abstract class NameAttributes extends Product with Serializable
```

```scala
def suffix(params: ScalaParameters): String
```

```scala
def render(name: String, separator: String): String
```

```scala
final def render(name: String): String = ...
```

```scala
final case class ScalaNameAttributes(
  fullCrossVersion: Option[Boolean],
  platform: Option[Boolean]
) extends NameAttributes
```

```scala
def platformSuffix(params: ScalaParameters): String = ...
```

```scala
def versionSuffix(params: ScalaParameters): String = ...
```

```scala
def suffix(params: ScalaParameters): String = ...
```

```scala
def render(name: String, separator: String): String = ...
```

```scala
case object NoAttributes extends NameAttributes
```

```scala
def suffix(params: ScalaParameters): String = ...
```

```scala
def render(name: String, separator: String): String = ...
```

#### `dependency/ScalaParameters.scala`

```scala
final case class ScalaParameters(
  scalaVersion: String,
  scalaBinaryVersion: String,
  platform: Option[String]
)
```

```scala
object ScalaParameters
```

```scala
def apply(
    scalaVersion: String,
    scalaBinaryVersion: String
  ): ScalaParameters = ...
```

```scala
def apply(scalaVersion: String): ScalaParameters = ...
```

#### `dependency/ScalaVersion.scala`

```scala
object ScalaVersion
```

```scala
def binary(scalaVersion: String): String = ...
```

```scala
def jsBinary(scalaJsVersion: String): Option[String] = ...
```

```scala
def nativeBinary(scalaNativeVersion: String): Option[String] = ...
```

#### `dependency/literal/DependencyLiteralMacros.scala`

```scala
class DependencyLiteralMacros(override val c: whitebox.Context) extends ModuleLiteralMacros(c)
```

```scala
def dependency(args: c.Tree*): c.Tree = ...
```

#### `dependency/literal/Extensions.scala`

```scala
trait Extensions
```

```scala
implicit class moduleString(val sc: StringContext)
```

```scala
def mod(args: Any*): ModuleLike[NameAttributes] = ...
```

```scala
implicit class dependencyString(val sc: StringContext)
```

```scala
def dep(args: Any*): DependencyLike[NameAttributes, NameAttributes] = ...
```

#### `dependency/literal/LiteralMacros.scala`

```scala
abstract class LiteralMacros(val c: whitebox.Context)
```

```scala
def mappings(args: Seq[c.Tree]): Mappings = ...
```

```scala
def input(inputs: Seq[String], mappings: Mappings): String = ...
```

#### `dependency/literal/ModuleLiteralMacros.scala`

```scala
class ModuleLiteralMacros(override val c: whitebox.Context) extends LiteralMacros(c)
```

```scala
def module(args: c.Tree*): c.Tree = ...
```

#### `dependency/package.scala`

```scala
package object dependency extends dependency.literal.Extensions
```

```scala
type Module = ...
```

```scala
type Dependency = ...
```

```scala
type ScalaModule = ...
```

```scala
type ScalaDependency = ...
```

```scala
type AnyModule = ...
```

```scala
type AnyDependency = ...
```

```scala
object Module
```

```scala
def apply(
      organization: String,
      name: String,
      attributes: Map[String, String]
    ): Module = ...
```

```scala
def apply(
      organization: String,
      name: String
    ): Module = ...
```

```scala
object Dependency
```

```scala
def apply(
      module: Module,
      version: String,
      exclude: CovariantSet[Module],
      userParams: Seq[(String, Option[String])]
    ): Dependency = ...
```

```scala
def apply(
      module: Module,
      version: String,
      exclude: CovariantSet[Module]
    ): Dependency = ...
```

```scala
def apply(
      module: Module,
      version: String
    ): Dependency = ...
```

```scala
def apply(
      organization: String,
      name: String,
      version: String
    ): Dependency = ...
```

```scala
object ScalaModule
```

```scala
def apply(
      organization: String,
      name: String,
      fullCrossVersion: Boolean,
      platform: Boolean,
      attributes: Map[String, String]
    ): ScalaModule = ...
```

```scala
def apply(
      organization: String,
      name: String,
      fullCrossVersion: Boolean,
      platform: Boolean
    ): ScalaModule = ...
```

```scala
def apply(
      organization: String,
      name: String,
      fullCrossVersion: Boolean
    ): ScalaModule = ...
```

```scala
def apply(
      organization: String,
      name: String
    ): ScalaModule = ...
```

```scala
object ScalaDependency
```

```scala
def apply(
      module: ScalaModule,
      version: String,
      exclude: CovariantSet[AnyModule],
      userParams: Seq[(String, Option[String])]
    ): ScalaDependency = ...
```

```scala
def apply(
      module: ScalaModule,
      version: String,
      exclude: CovariantSet[AnyModule]
    ): ScalaDependency = ...
```

```scala
def apply(
      module: ScalaModule,
      version: String
    ): ScalaDependency = ...
```

```scala
def apply(
      organization: String,
      name: String,
      version: String
    ): ScalaDependency = ...
```

#### `dependency/parser/DependencyParser.scala`

```scala
object DependencyParser
```

```scala
def parse(input: String): Either[String, AnyDependency] = ...
```

```scala
def parse(input: String, acceptInlineConfiguration: Boolean): Either[String, AnyDependency] = ...
```

#### `dependency/parser/ModuleParser.scala`

```scala
object ModuleParser
```

> Parses a module like
> org:name
> possibly with attributes, like
> org:name;attr1=val1;attr2=val2
>
> Two semi-columns after the org part is interpreted as a scala module. E.g. if
> the scala version is 2.13., org::name is equivalent to org:name_2.13.

```scala
def parse(input: String): Either[String, AnyModule] = ...
```

```scala
def parsePrefix(input: String): Either[String, (AnyModule, String)] = ...
```

