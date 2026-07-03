# Dependency API Reference

Local API references for the direct dependencies declared around `build.mill` lines 14-22. Each dependency has its own markdown file generated from Maven source artifacts, with usage notes and extracted non-private signatures.

| Dependency | Direct coordinate | File | Extracted signatures | Source files |
| --- | --- | --- | ---: | ---: |
| mainargs | `com.lihaoyi::mainargs:0.5.0` | [`mainargs-0.5.0.md`](./mainargs-0.5.0.md) | 170 | 15 |
| os-lib | `com.lihaoyi::os-lib:0.10.0` | [`os-lib-0.10.0.md`](./os-lib-0.10.0.md) | 514 | 15 |
| upickle | `com.lihaoyi::upickle:3.3.1` | [`upickle-3.3.1.md`](./upickle-3.3.1.md) | 1220 | 70 |
| cask | `com.lihaoyi::cask:0.11.3` | [`cask-0.11.3.md`](./cask-0.11.3.md) | 509 | 26 |
| requests | `com.lihaoyi::requests:0.9.2` | [`requests-0.9.2.md`](./requests-0.9.2.md) | 150 | 7 |
| scalasql | `com.lihaoyi::scalasql:0.3.1` | [`scalasql-0.3.1.md`](./scalasql-0.3.1.md) | 1367 | 80 |
| sqlite-jdbc | `org.xerial:sqlite-jdbc:3.46.1.0` | [`sqlite-jdbc-3.46.1.0.md`](./sqlite-jdbc-3.46.1.0.md) | 1441 | 56 |
| slf4j-nop | `org.slf4j:slf4j-nop:2.0.13` | [`slf4j-nop-2.0.13.md`](./slf4j-nop-2.0.13.md) | 7 | 1 |
| coursier | `io.get-coursier:coursier_2.13:2.1.25-M3` | [`coursier-2.1.25-M3.md`](./coursier-2.1.25-M3.md) | 1412 | 163 |

## Notes

- Scala `::` dependencies are documented with their Scala 3 artifacts, matching this project.
- Façade dependencies such as `upickle`, `scalasql`, and `coursier` include selected transitive source artifacts because their commonly imported public types live there.
- The extractor preserves declarations and adjacent Scaladoc/Javadoc comments, but omits implementation bodies to keep the files usable as API references.
