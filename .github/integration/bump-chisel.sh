#!/usr/bin/env bash

if [[ ! -r "build.mill" ]]; then
  echo "not Project root"
  exit 1
fi

if [[ ! -d chisel ]]; then
  git clone --depth=1 https://github.com/chipsalliance/chisel.git
fi

export PATH="$(nix build '.#mill' --no-link --print-out-paths)/bin:$PATH"
export PATH="$(nix build '.#mill-ivy-fetcher' --no-link --print-out-paths)/bin:$PATH"

echo "$PATH"

cacheDir=$(mktemp -d)
mif fetch -p chisel -c "$cacheDir"
mif codegen --cache "$cacheDir" -o .github/integration/chisel-lock.nix
