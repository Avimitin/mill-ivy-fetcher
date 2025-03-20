#!/usr/bin/env bash

if [[ ! -r "build.mill" ]]; then
  echo "not Project root"
  exit 1
fi

export PATH="$(nix build '.#mill' --no-link --print-out-paths)/bin:$PATH"
export PATH="$(nix build '.#mill-ivy-fetcher' --no-link --print-out-paths)/bin:$PATH"

chiselSrc=$(nix build '.#ci-test.src' --no-link --print-out-paths)
chiselDir=$(mktemp -d -t 'chisel_src_XXX')
cp -rT "$chiselSrc" "$chiselDir/chisel"
chmod -R u+w "$chiselDir"
mif run -p "$chiselDir/chisel" -o .github/integration/chisel-lock.nix
