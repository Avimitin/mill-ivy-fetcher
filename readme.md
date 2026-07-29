# Mvn Trace Forge

> **Record once. Review what was fetched. Rebuild Scala projects offline with
> Nix.**

`mtf` observes the Maven downloads made by a real build and writes their exact
repository paths and SHA-256 hashes to `mtf.lock.json`. This **local lock** is a
small, reviewable record of the build's remote inputs: commit it instead of
vendoring JARs or maintaining a shared dependency cache. Nix can then fetch the
locked files, materialize a standard `file://` Maven repository in the Nix store,
and replay the build without network access.

Supported build systems:

- [Mill](https://mill-build.org/mill/index.html) — multi-module Scala builds,
  including build-definition and compiler classpaths.
- [Scala CLI](https://scala-cli.virtuslab.org/) — main and test dependency
  capture through a daemon-free compilation.

Projects using or continuously tested with MTF:

- [Mvn Trace Forge](https://github.com/Avimitin/mvn-trace-forge) — builds its
  own package from the committed `mtf.lock.json`, making the project a
  self-hosting Mill example.
- [Zaozi](https://github.com/xinpian-tech/zaozi) — imports MTF in its Nix flake,
  maintains a generated Mill dependency lock, and builds its Scala 3 hardware
  design framework offline.
- [Chisel](https://github.com/chipsalliance/chisel) — pull-request and weekly
  integration tests capture a large real-world Mill dependency graph and
  publish Chisel from the resulting offline repository.

---

Mvn Trace Forge (`mtf`) records the Maven artifacts requested by a Scala build
and turns them into a Nix-consumable lock file. The lock can then be converted
into a local Maven repository derivation, allowing Mill or Scala CLI builds that
use Coursier to run in a Nix sandbox without network access.

This repository includes a Chisel integration test (`.#ci-test`) that publishes
Chisel locally from a locked Maven repository, proving that `mtf` can capture a
large real-world Mill build and replay it offline through Nix.

The workflow is:

1. Run `mtf archive` around one or more build commands.
2. Commit the generated `mtf.lock.json`.
3. Use `mkMavenRepository` in Nix to materialize the locked Maven repository.
4. Put that repository in a derivation's inputs so Coursier resolves from the
   Nix store instead of the network.

## Requirements

- Nix >= 2.28
- Flakes with `nix-command` enabled
- Mill 0.12.7+ or Mill 1.1.0+ for Mill projects
- Scala CLI for Scala CLI projects
- Linux: `bubblewrap` is required for the default archive sandbox

This repository's default dev shell includes `mtf`, Mill, and Metals. On Linux,
the packaged `mtf` wrapper also puts `bubblewrap` on `PATH` for archive
sandboxing:

```bash
nix develop
mtf --help
```

You can also run the packaged CLI directly:

```bash
nix run .#mtf -- --help
```

## Quick start for Mill projects

Generate a lock from a Mill project by archiving the targets that force dependency
resolution. For typical Mill projects, run both commands:

```bash
mtf archive -p path/to/project -- mill --no-daemon __.prepareOffline
mtf archive -p path/to/project -- mill --no-daemon __.scalaCompilerClasspath
```

`__.prepareOffline` records most dependencies, but it does not force every Scala
compiler classpath to be resolved. In particular, Scala 3 compiler artifacts
referenced by `build.mill` can be missed unless `__.scalaCompilerClasspath` is
evaluated explicitly.

`mtf archive` appends to the same lock by default, so the final
`path/to/project/mtf.lock.json` contains the union of both runs. Commit that lock
file. The relay repository under `path/to/project/.mtf/repository` is disposable
local state and should normally stay out of git.

If you are developing this repository and want to run the assembled jar directly,
the equivalent commands are:

```bash
java -jar ./out/mtf/assembly.dest/out.jar archive -- mill --no-daemon __.prepareOffline
java -jar ./out/mtf/assembly.dest/out.jar archive -- mill --no-daemon __.scalaCompilerClasspath
```

## Quick start for Scala CLI projects

Remove generated compilation state, then compile both the main and test scopes
through the archive:

```bash
scala-cli clean path/to/project
mtf archive -p path/to/project -- scala-cli compile --test --server=false .
```

Scala CLI does not provide a dedicated dependency-fetch command, so compiling
both scopes is the closest equivalent. `--server=false` avoids resolving the
large Bloop build-server dependency graph and makes this a daemon-free one-shot
capture. Use the same flag when replaying the build because it changes the
required artifacts. MTF warns when it is omitted but does not block the command.

Like Mill, Scala CLI can use additional repositories or download a selected JVM
outside Maven Central. Those downloads are not captured; use a Nix-provided JDK
and keep dependency repositories within the configured MTF upstream.

## Using a lock from Nix

The overlay exposes `mkMavenRepository`, which reads `mtf.lock.json`, fetches each
locked Maven artifact as one recursive fixed-output derivation, and joins them
into a standard Maven repository layout. This keeps the cache reusable at Maven
dependency granularity without creating a separate Nix derivation for every
JAR, POM, and checksum file.

```nix
{ pkgs, ... }:

let
  m2 = pkgs.mkMavenRepository {
    lockFile = ./mtf.lock.json;
  };
in
pkgs.stdenv.mkDerivation {
  pname = "my-mill-project";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    pkgs.millVersions.mill_1_1_2
  ];

  buildInputs = [
    m2
  ];

  buildPhase = ''
    mill --no-daemon __.compile
  '';
}
```

The repository derivation installs a setup hook at
`$out/nix-support/setup-hook`. nixpkgs `stdenv` sources it automatically when the
repository appears in `buildInputs` or `nativeBuildInputs`.

The hook sets:

- `COURSIER_REPOSITORIES`: prepends `file://$out` so Coursier resolves from the
  locked local repository first. If the variable was unset, this makes the build
  resolve exclusively from the lock.
- `HOME`: sets a writable temporary home at `${TMPDIR:-/tmp}/home` when the
  current `HOME` is unset, missing, or unwritable.
- `COURSIER_CACHE`: sets a writable temporary cache at `${TMPDIR:-/tmp}/coursier`
  only when the consumer has not already set one.

The generated repository contains normal Maven paths, for example:

```text
$out/com/lihaoyi/os-lib_3/0.10.0/os-lib_3-0.10.0.jar
$out/com/lihaoyi/os-lib_3/0.10.0/os-lib_3-0.10.0.pom
```

Artifact directories can be overridden when you need to replace a locked artifact
with another derivation that already provides the same Maven repository path:

```nix
let
  m2 = pkgs.mkMavenRepository { lockFile = ./mtf.lock.json; };
in
m2.override {
  "software/amazon/awssdk/aws-sdk-java-pom/2.33.4" = myAwsSdkPom;
}
```

## CLI reference

### `mtf archive`

`mtf archive` starts a local Maven relay on a free port, creates a clean build
environment whose Coursier mirror points Maven Central at that relay, runs the
command after `--`, and writes every file served by the relay into a JSON lock.

```bash
mtf archive [options] -- <mill|scala-cli> <arguments>
```

If a build needs selected variables from the invoking environment, export them
explicitly. The option is repeatable:

```bash
mtf archive --export-env BUILD_PROFILE --export-env MILL_OPTS -- \
  mill --no-daemon __.prepareOffline
```

Important options:

- `-p, --project-dir <path>`: project directory. Defaults to the current working
  directory.
- `--lock <path>`: JSON lock file to create or append. Defaults to
  `<project-dir>/mtf.lock.json`.
- `-r, --repo-dir <path>`: local relay repository. Defaults to
  `<project-dir>/.mtf/repository`.
- `-u, --upstream <url>`: Maven-compatible upstream. Defaults to Maven Central.
- `--fresh`: rebuild the lock from this run only instead of appending.
- `--sandbox <bwrap|none>`: choose the archive sandbox mode.
- `--export-env <name>`: re-export the current value of a host environment
  variable to the build command. Repeat for multiple variables; unset variables
  produce a warning.
- `--keep-workdir`: keep the temporary sandbox home for debugging.
- `--proxy <url>`: HTTP proxy for upstream relay requests.

Everything after `--` is executed inside the project directory. `mtf archive`
supports Mill and Scala CLI commands. It warns about daemon or build-server use
and persisted compilation state that should be cleaned before capture.

A lock has this shape:

```json
{
  "version": 3,
  "kind": "mtf-maven-lock",
  "repositories": {
    "central": "https://repo1.maven.org/maven2"
  },
  "runs": {
    "ee52a000ca94": {
      "repository": "central",
      "command": ["mill", "--no-daemon", "__.prepareOffline"]
    }
  },
  "artifacts": {
    "com/example/foo/1.0.0": {
      "narHash": "sha256-9kgpv3fh7yGNCmQlq8WZ7noBDsiUt2TuwTQa8i3pYpA=",
      "runs": ["ee52a000ca94"],
      "files": {
        "foo-1.0.0.jar": "sha256-DAOEyJEjhkDsWJUAJ4xVSFcQqai/38MDdTuIovpi6MA="
      }
    }
  }
}
```

Archive runs append: run `mtf archive` once per target and the lock unions the
results. MTF uses `nix hash path` to record the recursive NAR hash of every
artifact directory. Entries are sorted, re-running a command against the same
repository is a no-op, and each artifact records the run ids that requested it.
If an already locked path comes back with different content, archive refuses to
update the lock and reports the mismatched paths; investigate the upstream
mutation or rebuild deliberately with `--fresh` into a clean `--repo-dir`.

Schema version 3 introduced artifact NAR hashes. Regenerate older locks by
rerunning the complete archive command sequence. Use `--fresh` on the first
invocation only, then append every subsequent target without it before using
the lock with the current `mkMavenRepository`.

The relay still captures files individually. Maven clients request a JAR, POM,
checksum, parent POM, or BOM as independent HTTP paths, and while the build is
running the relay cannot know whether another file for the same coordinate will
be requested. After the command and relay stop, MTF groups the captured files by
their containing Maven coordinate directory and computes that directory's NAR
hash. In this context, an “artifact” is the fixed-output fetch unit represented
by one Maven repository directory; it does not imply that the relay observed a
single dependency-resolution event.

### `mtf relay`

`mtf relay` starts the Maven-compatible relay manually. This is mainly useful for
inspecting or debugging repository traffic; normal lock generation should use
`mtf archive`, which starts and stops the relay for you.

```bash
mtf relay --port 8081 --repo-dir .mtf/repository
```

By default the relay listens on `127.0.0.1:8081` and fetches missing files from
Maven Central:

```text
https://repo1.maven.org/maven2
```

For Mill/Coursier, point a mirror file at the relay:

```properties
central.from=https://repo1.maven.org/maven2
central.to=http://127.0.0.1:8081
```

The relay stores downloaded files under `.mtf/repository` using standard Maven
repository paths, and maintains an internal SQLite database at:

```text
.mtf/repository/.mtf/repository.sqlite
```

The database is a relay implementation detail. It is not the Nix-facing lock.

`mtf relay` can use another Maven-compatible upstream or an HTTP proxy:

```bash
mtf relay \
  --port 8082 \
  --repo-dir .mtf/repository \
  --upstream http://127.0.0.1:8081

mtf relay --proxy http://127.0.0.1:8080
```

### `mtf version`

```bash
mtf version
```

Prints the packaged MTF version.

## Flake outputs

This flake exposes:

- `packages.default` / `packages.mtf`: the wrapped `mtf` executable.
- `packages.mtf-jar`: compatibility alias for the same package.
- `packages.mtf-maven-repository`: the Maven repository generated from this
  repository's own `mtf.lock.json`.
- `overlays.default`: adds `mkMavenRepository`, `millVersions`, and
  `addDeterminismHook` to nixpkgs.
- `devShells.default`: development shell with `mtf`, Mill, Metals, and
  `bubblewrap` on Linux.

Build the packaged CLI:

```bash
nix build .#mtf
./result/bin/mtf --help
```

Run it from the dev shell:

```bash
nix develop -c mtf --help
```

## Mill versions overlay

The overlay exposes multiple Mill versions through `pkgs.millVersions`:

- `pkgs.millVersions.mill_0_12_7` through `pkgs.millVersions.mill_0_12_14`
- `pkgs.millVersions.mill_1_1_0`
- `pkgs.millVersions.mill_1_1_2`
- `pkgs.millVersions.allVersions`

Example flake usage:

```nix
{
  inputs.mvn-trace-forge.url = "github:Avimitin/mvn-trace-forge";

  outputs =
    { nixpkgs, mvn-trace-forge, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ mvn-trace-forge.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.millVersions.mill_1_1_2
          mvn-trace-forge.packages.${system}.mtf
        ];
      };
    };
}
```

If you need the `mtf` package from this flake in another flake, prefer referring
to `mvn-trace-forge.packages.${system}.mtf` directly.

## Sandboxing and limitations

- `mtf archive` captures only requests to the configured upstream. By default it
  mirrors Maven Central and its common alias, but repositories other than the
  configured upstream bypass the relay and will be missing from the lock.
- Mill distribution bootstrapping and `.mill-jvm-version` JVM downloads do not go
  through Maven Central. Use a Nix-provided Mill and `//| mill-jvm-version:
  system` in `build.mill` so the build only needs Maven artifacts.
- Private repository authentication and proxy authentication are not supported
  yet.
- Mutable Maven metadata such as `maven-metadata.xml` and SNAPSHOT metadata has
  no TTL. Delete the cached file or use a fresh `--repo-dir` if you need to
  refresh it.
- The relay observes only files requested by the build command. Lazy Mill targets
  that are never evaluated will not be discovered.
- Scala CLI JVM downloads selected by `--jvm` or `using jvm` do not use Maven
  repositories and are not captured. Prefer a Nix-provided system JDK for offline
  builds.
- A Mill daemon started outside the sandbox can serve requests with the wrong
  environment. Run `mill shutdown` first and pass `--no-daemon` or `-i` in the
  archived Mill command.
- On Linux, the default archive sandbox uses `bubblewrap`: host files are visible
  read-only, the real home directory, `/tmp`, and environment are masked, and
  only the project directory and a temporary home are writable. If bubblewrap
  cannot run, use `--sandbox none` to opt into a clean-environment run without
  filesystem isolation.
- On macOS, `bubblewrap` is unavailable, so archive automatically uses the
  clean-environment mode and warns.

## Development

Install Nix and enable flakes, then enter the development shell:

```bash
nix develop
$EDITOR .
```

Useful commands:

```bash
nix fmt
nix build .#mtf
nix develop -c mtf --help
mill --no-daemon mtf.test
```
