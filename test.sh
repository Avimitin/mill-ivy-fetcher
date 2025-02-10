#!/usr/bin/env bash

set -e

mkdir -p tests
cd tests

export PATH="$(nix build '.#nvfetcher.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#mill.out' --print-out-paths --no-link)/bin:$PATH"

mill --version >/dev/null
exe=$(realpath ../mill_ivy_fetcher.py)
"$exe" --help >/dev/null

if [[ ! -d "chisel/.git" ]]; then
  git clone --depth=1 https://github.com/chipsalliance/chisel.git
fi
pushd chisel >/dev/null
if [[ -d "out" ]]; then
  rm -rf out
fi
mkdir -p out/.javaHome

javaHome=$(realpath out/.javaHome)
"$exe" fetch --home "$javaHome" --targets "unipublish"

nvfetchKey=$(realpath ../nvfetcher.toml)
"$exe" dump --coursier-dir "$javaHome/.cache/coursier" --dump-path "$nvfetcherKey"
nvfetcher -k "$nvfetcherKey"

if [[ ! -d "$HOME/.cache/coursier" ]]; then
  cp -r "$javaHome/.cache/coursier" "$HOME/.cache/coursier"
fi
python3 ./test.py
