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

1. Use the `fetch` subcommand to fetch clean dependencies directory
2. Use the `dump` subcommand to generate nvfetcher key file
3. Use "nvfetcher" tools to convert key file to Nix expression
