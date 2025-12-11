#!/usr/bin/env bash

# When bootstrap the lock file, mill always create unwanted "out" directory
# that affect a clean dependency discovery, we have to move the project to
# a clean directory to start over.
CLEAN_DIR=$(mktemp -d)
cp -r ./mif "$CLEAN_DIR"
cp build.mill "$CLEAN_DIR"

nix develop -c mill -i mif.run run -p "$CLEAN_DIR" -o lock.nix

# Run build for offline dependency check
nix build '.#mill-ivy-fetcher' -L --no-link
