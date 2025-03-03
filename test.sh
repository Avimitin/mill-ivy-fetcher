#!/usr/bin/env bash

set -e

export PATH="$(nix build '.#jdk21.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#nvfetcher.out' --print-out-paths --no-link)/bin:$PATH"
export PATH="$(nix build '.#mill.out' --print-out-paths --no-link)/bin:$PATH"

(
  echo "Running unit tests"
  export JAVA_TOOL_OPTIONS="-Duser.home=$(realpath ./assets) $JAVA_TOOL_OPTIONS"
  export MILL_HOME="$(realpath ./assets)"
  python3 ./test.py
)


echo "Running integration tests"
nix build '.#test-foo' -L
