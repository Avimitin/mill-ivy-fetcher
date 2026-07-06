# Mill Ivy Fetcher

Mill always lazily evaluates Ivy dependencies, so it is not possible to get a
lock file before running Mill to compile a project. However, detailed information
about each dependency is fundamental to making a project reproducible. This project
provides tooling to split Ivy dependencies into manageable pieces.

## Requirements

* Nix >= 2.28
* Mill 0.12.7+ or Mill 1.1.0+

## Usage

* Get help information

```bash
mill -i mif.run --help
```

* Prepare offline dependencies

```bash
cacheDir=$(mktemp -d)
mill -i mif.run fetch --project-dir <project> -c "$cacheDir"
```

* Generate Nix expression for runtime and compile dependencies

```bash
# point to same cache dir
mill -i mif.run codegen --cache "$cacheDir" -o lock.nix
```

* Don't care anything and just wanna generate a lock for current project

```bash
mill -i mif.run run -o lock.nix
```

## Maven Relay Snapshot

`mif relay` starts a local Maven-compatible HTTP relay. Build tools can use it
as a Maven mirror. The relay serves files from a project-level local Maven
repository when they already exist, otherwise it fetches them from the upstream
repository and stores them in standard Maven layout.

The relay does **not** write the Nix-facing JSON lock directly. It only maintains
an internal SQLite database under the repository root:

```text
.mif/repository/.mif/repository.sqlite
```

That database is a relay implementation detail. The lock/export workflow is
provided by `mif archive` (see below), which drives the relay for you.

This is part of the Maven repository based redesign. It is intended to replace
the old Coursier-cache scanning flow over time, but the old commands are still
present for now.

Run the relay manually:

```bash
mill -i mif.run relay \
  --port 8081 \
  --repo-dir .mif/repository
```

By default, the relay listens on `127.0.0.1:8081` and fetches missing files from
Maven Central:

```text
https://repo1.maven.org/maven2
```

Point the build tool's Maven mirror to the relay:

```text
http://127.0.0.1:8081/
```

For Mill/Coursier, create a mirror file equivalent to:

```properties
central.from=https://repo1.maven.org/maven2
central.to=http://127.0.0.1:8081
```

The relay stores downloaded files under `.mif/repository` using standard Maven
repository paths such as:

```text
.mif/repository/com/example/foo/1.0.0/foo-1.0.0.pom
.mif/repository/com/example/foo/1.0.0/foo-1.0.0.jar
```



The upstream can be replaced with another Maven-compatible endpoint. This is
useful for testing relay chaining:

```bash
mill -i mif.run relay \
  --port 8082 \
  --repo-dir .mif/repository \
  --upstream http://127.0.0.1:8081
```

If upstream requests must go through an HTTP proxy, pass an explicit proxy URL:

```bash
mill -i mif.run relay \
  --proxy http://127.0.0.1:8080
```

Current limitations:

* Maven Central is the only default upstream.
* Private repository authentication and proxy authentication are not supported yet.
* Cached Maven files are treated as archived content. Mutable metadata such as
  `maven-metadata.xml` and SNAPSHOT metadata has no TTL yet; delete the cached
  file or use a fresh repository directory if you need to refresh it.
* The relay only observes files requested by the build tool. Lazy Mill targets
  that are never evaluated will not be discovered by this layer.

## Archive

`mif archive` records the full Maven file set of a build command into a
project-level JSON lock. It starts the relay on a free port, runs the build
command in a clean environment whose Coursier mirror points Maven Central at
the relay, and then writes every file the relay served into the lock:

```bash
mif archive -p path/to/project -- mill --no-daemon __.prepareOffline
```

Everything after `--` is the build command, executed inside the project
directory. Because the run starts with empty Coursier/Mill caches and a fresh
`HOME`, the build has to request every dependency through the relay, so the
lock is a complete record of what the command needs.

By default the lock is written to `<project-dir>/mif.lock.json` (commit this
file) and the relay repository lives in `<project-dir>/.mif/repository`
(disposable local state; keep it out of git). The lock records which commands
produced it and which files each command requested:

```json
{
  "version": 1,
  "kind": "mif-maven-lock",
  "repositories": [
    { "id": "central", "type": "maven", "url": "https://repo1.maven.org/maven2" }
  ],
  "runs": [
    { "id": "9f8e7d6c5b4a", "command": ["mill", "--no-daemon", "__.prepareOffline"] }
  ],
  "files": [
    {
      "repository": "central",
      "mavenPath": "com/example/foo/1.0.0/foo-1.0.0.jar",
      "sha256": "sha256-DAOEyJEjhkDsWJUAJ4xVSFcQqai/38MDdTuIovpi6MA=",
      "size": 49512,
      "runs": ["9f8e7d6c5b4a"]
    }
  ]
}
```

Archive runs append: run `mif archive` once per build target and the lock
unions the results, so one committed lock can cover a whole project. Entries
are sorted, re-running a recorded command is a no-op, and each file lists the
ids of all runs that requested it. If an already locked path comes back with
different content, archive refuses to update the lock and reports every
mismatched path — either investigate the upstream mutation or rebuild
deliberately with `--fresh` into a clean `--repo-dir`.

On Linux the build command runs inside a bubblewrap sandbox (`bwrap`): the
host filesystem is visible read-only, the real home directory, `/tmp`, and the
environment are masked, and only the project directory and a throwaway
sandbox home are writable. This is what guarantees warm host caches (like
`~/.cache/coursier` or `~/.ivy2/local`) cannot silently satisfy dependencies
outside the relay. If bubblewrap cannot run (for example in a container that
blocks user namespaces), archive fails with instructions; `--sandbox none`
opts into a clean-environment run without filesystem isolation. On macOS,
where bubblewrap does not exist, archive automatically uses the
clean-environment mode and warns.

Archive limitations:

* Only traffic to the mirrored upstream is captured. Mill distribution
  bootstrapping, `.mill-jvm-version` JVM downloads, and repositories other
  than the configured upstream bypass the relay and will be missing from the
  lock. Use a Nix-provided Mill and `mill-jvm-version: system` (as this
  repository does) so the build only needs Maven Central.
* A Mill daemon started outside the sandbox can serve requests with the wrong
  environment. Archive warns when it finds daemon state; pass `--no-daemon`
  (or `-i`) in the build command and run `mill shutdown` first.

## Implementation Details

Mill doesn't provide a straightforward CLI interface to get the full dependency
tree. The old implementation works around this by running Mill targets and then
scanning the Coursier cache directory. This is fragile because the cache layout is
not the real distribution format and because Mill evaluates dependencies lazily.

The new relay direction records Maven repository requests directly. Build tools
already understand Maven repositories and mirrors, so `mif` can archive the files
that were actually requested and later materialize a project-level Maven
repository from the JSON lock.

## Recommended Workflow

1. Add this project to your flake inputs and overlays

```nix
# flake.nix
{
  description = "flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mill-ivy-fetcher.url = "github:Avimitin/mill-ivy-fetcher";
  };

  outputs = { self, nixpkgs, flake-utils, mill-ivy-fetcher }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              mill-ivy-fetcher.overlays.default
              mill-ivy-fetcher.overlays.mill-overlay
            ];
          };
        in
        {
          legacyPackages = pkgs;
          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [
                ammonite
                mill
                mill-ivy-fetcher
              ];
            };
          };
          formatter = pkgs.nixpkgs-fmt;
        }
      )
    // { inherit inputs; };
}
```

2. Use the provided `mif` executable to generate a lock file for a project:

```bash
nix shell '.#mill' '.#mill-ivy-fetcher' -c mif run -p path/to/project -o project-lock.nix
```

3. Add the lock file to `publishMillJar` (optional)

```nix
{ publishMillJar }:
publishMillJar {
  name = "chisel";

  src = ./.;

  lockFile = ./project-lock.nix;

  publishTargets = [
    "foo"
  ];
}
```

4. Or if you want to build an application, try:

```nix
{ stdenv, ivy-gather }:
let
  ivyCache = ivy-gather ./project-lock.nix;
in
stdenv.mkDerivation {
  #...
  buildInputs = [ ivyCache ];
  # ...
}
```

* See [`.github/integration/chisel.nix`](.github/integration/chisel.nix) for a detailed example.
* See [`nix/mill-ivy-fetcher-overlay.nix`](nix/mill-ivy-fetcher-overlay.nix) for function documentation.

## Mill Versions Overlay

The `mill-overlay` provides multiple Mill versions through the `millVersions` attribute set. This allows you to select specific Mill versions for your project.

### Available Versions

The overlay provides the following Mill versions:

- `millVersions.mill_0_12_7` through `millVersions.mill_0_12_14` (Mill 0.12.x series)
- `millVersions.mill_1_1_0` and `millVersions.mill_1_1_2` (Mill 1.1.x series)

Each version includes the appropriate wrapper script and JRE configuration.

### Usage Example

```nix
{ pkgs }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    millVersions.mill_1_1_2  # Use Mill 1.1.2
    metals
  ];
}
```

You can also access all available version names via `millVersions.allVersions`.

### Overriding Mill Version in publishMillJar

To use a specific Mill version with `publishMillJar`, use the `.override` mechanism:

```nix
{ publishMillJar, millVersions }:
let
  publishMillJar' = publishMillJar.override { mill = millVersions.mill_1_1_2; };
in
publishMillJar' {
  name = "my-project";

  src = ./.;

  lockFile = ./project-lock.nix;

  publishTargets = [
    "my-module"
  ];
}
```

This is useful when your project requires a specific Mill version that differs from the default.

## Dev Env Setup

1. Install the Nix package manager (Nix is not NixOS): <https://nixos.org/download/>
2. Enable experimental features `nix-command` and `flakes`: <https://wiki.nixos.org/wiki/Flakes>

```bash
nix develop .
$EDITOR .
```

## Debug Installation

You can set `NIX_DEBUG` to a value greater than `4` to see cache installation logs:

```
publishMillJar {
  # ...
  env.NIX_DEBUG = 4;
  # ...
}
```

## Bump Dependencies for Mif

```bash
./bump.sh
```
