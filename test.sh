#!/usr/bin/env bash

set -e

export PATH="$(nix build '.#nvfetcher.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#mill.out' --print-out-paths --no-link)/bin:$PATH"

exe=$(realpath ./mill_ivy_fetcher.py)
"$exe" --help >/dev/null

pushd tests >/dev/null
if [[ -d "out" ]]; then
  rm -rf out
fi
mkdir -p out/.javaHome

javaHome=$(realpath out/.javaHome)
"$exe" fetch --home "$javaHome" --targets "foo"

mkdir -p deps
nvfetcherCfg="deps/nvfetcher.toml"
"$exe" dump --coursier-dir "$javaHome/.cache/coursier" --dump-path "$nvfetcherCfg"
cd deps
nvfetcher

if [[ ! -d "$HOME/.cache/coursier" ]]; then
  cp -r "$javaHome/.cache/coursier" "$HOME/.cache/coursier"
fi
popd >/dev/null

python3 ./test.py
