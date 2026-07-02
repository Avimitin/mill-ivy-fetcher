# Coding Guideline

## Error handling

Treat Java and throwing library APIs like unsafe foreign APIs.

The mental model should be similar to writing a C API wrapper in Rust:

- The Java or throwing library API is the unsafe C boundary.
- The Scala code we write is the safe Rust-side API.
- Boundary wrappers convert exceptions into typed values.
- Normal project code composes those typed values instead of throwing.

Rules:

1. Only use `try` / `catch` at a Java or throwing-library boundary that we cannot control.
2. Wrap those calls in small functions that convert failures into `Either` or another explicit type.
3. Functions defined in this project should not throw for expected failures.
4. Project-owned control flow should use `Either`, `Option`, or another type-level representation.
5. Avoid `throw` in our own code. If an error must reach the CLI, return `Left(...)` up to the command boundary and let the top-level command decide how to report it.

Example shape:

```scala
def callJavaApi(): Either[String, Result] =
  try Right(javaLibrary.call())
  catch case NonFatal(e) => Left(e.getMessage)

def projectFunction(): Either[String, Output] =
  callJavaApi().map(convertResult)
```
