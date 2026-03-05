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

## Implementation Details

Mill doesn't provide a straightforward CLI interface to get the Ivy dependencies
tree. The only way to know all the necessary build-time dependencies is to run
`mill __.prepareOffline`. Given that Mill uses the Coursier library to download
JAR packages, we can gather dependency information by searching the Coursier cache
directory.

This project provides the executable `mif`. It will recursively search all `.pom`
files in the Coursier cache, extract necessary information like project name,
version, etc., and convert that information to Maven Central download URLs. Then
it converts those URLs to Nix `fetchurl` expressions.

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
