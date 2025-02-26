#!/usr/bin/env bash

set -e

export PATH="$(nix build '.#jdk21.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#nvfetcher.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#mill.out' --print-out-paths --no-link)/bin:$PATH"

(
  echo "Running unit tests"
  export JAVA_TOOL_OPTIONS="-Duser.home=$(realpath ./assets)"
  export MILL_HOME="$(realpath ./assets)"
  python3 ./test.py
)


echo "Running integration tests"
exe=$(realpath ./mill_ivy_fetcher.py)
"$exe" --help >/dev/null

pushd tests >/dev/null
if [[ -d "out" ]]; then
  rm -rf out
fi
mkdir -p out/.coursier

coursierDir=$(realpath out/.coursier)
"$exe" fetch --work-dir "$coursierDir" --targets "foo"

mkdir -p deps
nvfetcherCfg="deps/nvfetcher.toml"
"$exe" dump --coursier-dir "$coursierDir/cache" --dump-path "$nvfetcherCfg"
cd deps
nvfetcher

popd >/dev/null

nix build '.#test-foo'
