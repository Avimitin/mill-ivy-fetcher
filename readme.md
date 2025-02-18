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
./mill_ivy_fetcher.py fetch --home $(mktemp -d)
```

* Fetch mill dependencies with extra Java options

```bash
./mill_ivy_fetcher.py fetch --java-opts="-Dhttp.proxyHost=127.0.0.1" -j="-Dhttp.proxyPort=1234"
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

1. Use this project in overlay

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

2. Use the `fetch` subcommand to fetch clean dependencies directory
3. Use the `dump` subcommand to generate nvfetcher key file
4. Use "nvfetcher" tools to convert key file to Nix expression
5. *Optional* Use the default shipped expression to group those ivy dependencies into small pieces:

```nix
# ...
{ mill-ivy-fetcher, ... }:
let
  dep-builder = mill-ivy-fetcher.dep-builder-script { };
in
dep-builder path/to/_sources/generated.nix
# ...
```

This will return a attribute set in following patterns:

```nix
rec {
  ivyDeps = {
    apache-33-pom = <setup-hook>;
    scala-compiler = <setup-hook>;
    # ...
  };
  ivyDepsList = attrValues ivyDeps;
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
