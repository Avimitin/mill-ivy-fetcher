# SLF4J NOP 2.0.13 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `7` non-private declaration signatures from `1` source files.

## Coordinates
- Direct dependency: `org.slf4j:slf4j-nop:2.0.13`
- Upstream docs: https://www.slf4j.org/
- Source artifacts included:
  - `org.slf4j:slf4j-nop:2.0.13`

## Common imports

```scala
// Usually no imports: this dependency is activated by the SLF4J service provider on the classpath.
```

## Usage notes

No-operation SLF4J service provider/binding. It normally is not called directly; putting it on the classpath silences SLF4J logging from libraries.

```scala
// build.mill dependency only:
val slf4jNop = mvn"org.slf4j:slf4j-nop:2.0.13"

// Optional direct sanity check, though normal application code should not need it:
val logger = org.slf4j.LoggerFactory.getLogger("mif")
logger.info("discarded by slf4j-nop")
```

## API signatures from upstream source

### `org.slf4j:slf4j-nop:2.0.13`

Source: https://repo1.maven.org/maven2/org/slf4j/slf4j-nop/2.0.13/slf4j-nop-2.0.13-sources.jar

#### `org/slf4j/nop/NOPServiceProvider.java`

```java
public class NOPServiceProvider implements SLF4JServiceProvider
```

> Declare the version of the SLF4J API this implementation is compiled against.
> The value of this field is modified with each major release.

```java
public static String REQUESTED_API_VERSION = ...
```

```java
public ILoggerFactory getLoggerFactory()
```

```java
public IMarkerFactory getMarkerFactory()
```

```java
public MDCAdapter getMDCAdapter()
```

```java
    @Override
public String getRequestedApiVersion()
```

```java
public void initialize()
```

