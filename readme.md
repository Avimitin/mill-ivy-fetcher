# Mill Ivy Fetcher

Mill always lazily evaluate Ivy dependencies, so it is not possible to get a
lock file before starting Mill to actually compile a project. However the needs
for a elaborate information of each dependency is fundamental to make a project
reproducible. This project are some efforts to split a bunch Ivy dependencies
into small pieces.

## Requirements

* mill 0.12.8+

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

Mill doesn't provide any straightforward CLI interface to get Ivy dependencies
tree. The only way to know all the necessary build time dependencies is to run
`mill __.prepareOffline` once. Given that Mill use Coursier library to download
JAR package, we can gather dependency information by searching Coursier cache
directory.

This project provides executable `mif`. It will
recursively search all `.pom` file in Coursier cache and extract necessary
information like project name, version...etc and convert those information to
maven central download URL. Then convert that URL to a nix `fetchurl` expression.

## Recommended Workflow

1. Add this project in your overlay

```nix
# flake.nix
{
  description = "flake.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mill-ivy-fetcher = "github:Avimitin/mill-ivy-fetcher";
  };

  outputs = { self, nixpkgs, flake-utils, mill-ivy-fetcher }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ mill-ivy-fetcher.overlays.mill-flows ]; };
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

2. Use the provided `mif` executable to generate lock file for a project:

```bash
cacheDir=$(mktemp -d)
nix shell '.#mill' '.#mill-ivy-fetcher' -c mif fetch -p path/to/project --cache "$cacheDir"
nix shell '.#mill' '.#mill-ivy-fetcher' -c mif codegen --cache "$cacheDir" -o project-lock.nix
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

4. Or if you want to build an application, try

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

* See [`./.github/integration/chisel.nix`](./.github/integration/chisel.nix) for a detailed explanation.
* See [`./nix/mill-ivy-fetcher-overlay.nix`](./nix/mill-ivy-fetcher-overlay.nix) for a function documents.
