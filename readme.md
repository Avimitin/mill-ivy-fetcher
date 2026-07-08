# Mill Ivy Fetcher

Mill Ivy Fetcher (`mif`) records the Maven artifacts requested by a Mill build
and turns them into a Nix-consumable lock file. The lock can then be converted
into a local Maven repository derivation, allowing Mill/Coursier builds to run in
a Nix sandbox without network access.

This repository includes a Chisel integration test (`.#ci-test`) that publishes
Chisel locally from a locked Maven repository, proving that `mif` can capture a
large real-world Mill build and replay it offline through Nix.

The workflow is:

1. Run `mif archive` around one or more Mill targets.
2. Commit the generated `mif.lock.json`.
3. Use `mkMavenRepository` in Nix to materialize the locked Maven repository.
4. Put that repository in a derivation's inputs so Coursier resolves from the
   Nix store instead of the network.

## Requirements

- Nix >= 2.28
- Flakes with `nix-command` enabled
- Mill 0.12.7+ or Mill 1.1.0+
- Linux: `bubblewrap` is required for the default archive sandbox

This repository's default dev shell includes `mif`, Mill, and Metals. On Linux,
the packaged `mif` wrapper also puts `bubblewrap` on `PATH` for archive
sandboxing:

```bash
nix develop
mif --help
```

You can also run the packaged CLI directly:

```bash
nix run .#mif -- --help
```

## Quick start for Mill projects

Generate a lock from a Mill project by archiving the targets that force dependency
resolution. For typical Mill projects, run both commands:

```bash
mif archive -p path/to/project -- mill --no-daemon __.prepareOffline
mif archive -p path/to/project -- mill --no-daemon __.scalaCompilerClasspath
```

`__.prepareOffline` records most dependencies, but it does not force every Scala
compiler classpath to be resolved. In particular, Scala 3 compiler artifacts
referenced by `build.mill` can be missed unless `__.scalaCompilerClasspath` is
evaluated explicitly.

`mif archive` appends to the same lock by default, so the final
`path/to/project/mif.lock.json` contains the union of both runs. Commit that lock
file. The relay repository under `path/to/project/.mif/repository` is disposable
local state and should normally stay out of git.

If you are developing this repository and want to run the assembled jar directly,
the equivalent commands are:

```bash
java -jar ./out/mif/assembly.dest/out.jar archive -- mill --no-daemon __.prepareOffline
java -jar ./out/mif/assembly.dest/out.jar archive -- mill --no-daemon __.scalaCompilerClasspath
```

## Using a lock from Nix

The overlay exposes `mkMavenRepository`, which reads `mif.lock.json`, fetches all
locked files with fixed-output `fetchurl` derivations, and joins them into a
standard Maven repository layout.

```nix
{ pkgs, ... }:

let
  m2 = pkgs.mkMavenRepository {
    lockFile = ./mif.lock.json;
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
  m2 = pkgs.mkMavenRepository { lockFile = ./mif.lock.json; };
in
m2.override {
  "software/amazon/awssdk/aws-sdk-java-pom/2.33.4" = myAwsSdkPom;
}
```

## CLI reference

### `mif archive`

`mif archive` starts a local Maven relay on a free port, creates a clean build
environment whose Coursier mirror points Maven Central at that relay, runs the
command after `--`, and writes every file served by the relay into a JSON lock.

```bash
mif archive [options] -- mill --no-daemon __.prepareOffline
```

Important options:

- `-p, --project-dir <path>`: project directory. Defaults to the current working
  directory.
- `--lock <path>`: JSON lock file to create or append. Defaults to
  `<project-dir>/mif.lock.json`.
- `-r, --repo-dir <path>`: local relay repository. Defaults to
  `<project-dir>/.mif/repository`.
- `-u, --upstream <url>`: Maven-compatible upstream. Defaults to Maven Central.
- `--fresh`: rebuild the lock from this run only instead of appending.
- `--sandbox <bwrap|none>`: choose the archive sandbox mode.
- `--keep-workdir`: keep the temporary sandbox home for debugging.
- `--proxy <url>`: HTTP proxy for upstream relay requests.

Everything after `--` is executed inside the project directory. Currently `mif
archive` supports Mill commands and warns when the command may reuse a Mill daemon
from outside the archive environment.

A lock has this shape:

```json
{
  "version": 2,
  "kind": "mif-maven-lock",
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
      "runs": ["ee52a000ca94"],
      "files": {
        "foo-1.0.0.jar": "sha256-DAOEyJEjhkDsWJUAJ4xVSFcQqai/38MDdTuIovpi6MA="
      }
    }
  }
}
```

Archive runs append: run `mif archive` once per target and the lock unions the
results. Entries are sorted, re-running a command against the same repository is
a no-op, and each artifact records the run ids that requested it. If an already
locked path comes back with different content, archive refuses to update the lock
and reports the mismatched paths; investigate the upstream mutation or rebuild
deliberately with `--fresh` into a clean `--repo-dir`.

### `mif relay`

`mif relay` starts the Maven-compatible relay manually. This is mainly useful for
inspecting or debugging repository traffic; normal lock generation should use
`mif archive`, which starts and stops the relay for you.

```bash
mif relay --port 8081 --repo-dir .mif/repository
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

The relay stores downloaded files under `.mif/repository` using standard Maven
repository paths, and maintains an internal SQLite database at:

```text
.mif/repository/.mif/repository.sqlite
```

The database is a relay implementation detail. It is not the Nix-facing lock.

`mif relay` can use another Maven-compatible upstream or an HTTP proxy:

```bash
mif relay \
  --port 8082 \
  --repo-dir .mif/repository \
  --upstream http://127.0.0.1:8081

mif relay --proxy http://127.0.0.1:8080
```

### `mif version`

```bash
mif version
```

Prints the packaged MIF version.

## Flake outputs

This flake exposes:

- `packages.default` / `packages.mif`: the wrapped `mif` executable.
- `packages.mif-jar`: compatibility alias for the same package.
- `packages.mif-maven-repository`: the Maven repository generated from this
  repository's own `mif.lock.json`.
- `overlays.default`: adds `mkMavenRepository`, `millVersions`, and
  `addDeterminismHook` to nixpkgs.
- `devShells.default`: development shell with `mif`, Mill, Metals, and
  `bubblewrap` on Linux.

Build the packaged CLI:

```bash
nix build .#mif
./result/bin/mif --help
```

Run it from the dev shell:

```bash
nix develop -c mif --help
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
  inputs.mill-ivy-fetcher.url = "github:Avimitin/mill-ivy-fetcher";

  outputs =
    { nixpkgs, mill-ivy-fetcher, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ mill-ivy-fetcher.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.millVersions.mill_1_1_2
          mill-ivy-fetcher.packages.${system}.mif
        ];
      };
    };
}
```

If you need the `mif` package from this flake in another flake, prefer referring
to `mill-ivy-fetcher.packages.${system}.mif` directly.

## Sandboxing and limitations

- `mif archive` captures only requests to the configured upstream. By default it
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
nix build .#mif
nix develop -c mif --help
mill --no-daemon mif.test
```
