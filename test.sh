#!/usr/bin/env bash

set -e

mkdir -p tests
pushd tests >/dev/null

export PATH="$(nix build '.#nvfetcher.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#mill.out' --print-out-paths --no-link)/bin:$PATH"

mill --no-server --version >/dev/null
exe=$(realpath ../mill_ivy_fetcher.py)
"$exe" --help >/dev/null

if [[ ! -d "rvdecoderdb/.git" ]]; then
  git clone --depth=1 https://github.com/chipsalliance/rvdecoderdb.git
fi
pushd rvdecoderdb >/dev/null
if [[ -d "out" ]]; then
  rm -rf out
fi
mkdir -p out/.javaHome

javaHome=$(realpath out/.javaHome)
"$exe" fetch --home "$javaHome" --targets "rvdecoderdb.jvm"

nvfetcherCfg="../nvfetcher.toml"
"$exe" dump --coursier-dir "$javaHome/.cache/coursier" --dump-path "$nvfetcherCfg"
nvfetcher -c "$nvfetcherCfg"

if [[ ! -d "$HOME/.cache/coursier" ]]; then
  cp -r "$javaHome/.cache/coursier" "$HOME/.cache/coursier"
fi
popd >/dev/null
popd >/dev/null

python3 ./test.py
