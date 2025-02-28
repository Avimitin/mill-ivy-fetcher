# Mill Ivy Fetcher

Mill always lazily evaluate Ivy dependencies, so it is not possible to get a
lock file before starting Mill to actually compile a project. However the needs
for a elaborate information of each dependency is fundamental to make a project
reproducible. This project are some efforts to split a bunch Ivy dependencies
into small pieces.

## Requirements

* Python 3.13

## Usage

* Get help information

```bash
./mill_ivy_fetcher.py -h
```

* Print generated nvfetcher information

```bash
./mill_ivy_fetcher.py dump
```

* Use specific coursier directory to generate nvfetcher information

```bash
./mill_ivy_fetcher.py dump -c path/to/coursier/dir
```

* Dump nvfetcher contents to a file instead of printing

```bash
./mill_ivy_fetcher.py dump -d ./nvfetcher.toml
```

* Fetch mill dependencies

```bash
./mill_ivy_fetcher.py fetch
```

* Fetch mill dependencies for specified targets

```bash
./mill_ivy_fetcher.py fetch --targets unipublish --targets panamaom
```

* Fetch mill dependencies to specified directory

```bash
./mill_ivy_fetcher.py fetch --work-dir $(mktemp -d)
```

## Implementation Details

Mill doesn't provide any straightforward CLI interface to get Ivy dependencies
tree. The only way to know all the necessary build time dependencies is to run
`mill __.prepareOffline` once. Given that Mill use Coursier library to download
JAR package, we can gather dependency information by searching Coursier cache
directory.

This project provides a single text script `./mill_ivy_fetcher.py`. It will
recursively search all `.pom` file in Coursier cache and extract necessary
information like project name, version...etc and convert those information to
nvfetcher key file. Then users can use the nvfetcher key file to generate Nix
expression for each JAR package.

## Recommended Workflow

1. Add this project in your overlay

```nix
final: prev: {
  mill-ivy-fetcher =
    let
      src = final.fetchFromGitHub {
        owner = "Avimitin";
        repo = "mill-ivy-fetcher";
        rev = "<latest commit in this repository>";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
    in
    final.callPackage "${src}/package.nix" { inherit (final) callPackage; };
}
```

2. Use the provided `generateIvyCache` helper to build dependencies for a project:

```nix
{ mill-ivy-fetcher, ...}:
let
  ivyCache = mill-ivy-fetcher.generateIvyCache {
    name = "<project>-deps";
    src = path/to/project;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
# ...
```

This will return a attribute set in following patterns:

```nix
rec {
  cache = rec {
    ivyDeps = {
      apache-33-pom = <setup-hook>;
      scala-compiler = <setup-hook>;
      # ...
    };
    ivyDepsList = attrValues ivyDeps;
  };
  codegenFiles = <derivation>;
}
```

Then you can just put those derivations to your mill project buildInputs:

```nix
# ...
stdenv.mkDerivation {
    # ...
    buildInputs = [ ... ] + ivyDepsList;
}
# ...
```

See [`./demo`](./demo) for a detailed explanation.
