# shellcheck shell=bash
# This file is installed to $out/nix-support/setup-hook by mkMavenRepository
# and is sourced automatically by nixpkgs stdenv whenever the repository
# derivation is listed in (native)buildInputs.
#
# It points Coursier (used by Mill, sbt, scala-cli, ...) at the local Maven
# repository that ships in this store path, so builds resolve every dependency
# from the pre-fetched lock instead of reaching out to the network.
#
# stdenv always sources setup hooks with bash, so BASH_SOURCE is available.

# Resolve the repository root from this file's location:
#   $repo/nix-support/setup-hook  ->  $repo
_mif_maven_repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

# Tell Coursier to resolve from our local Maven repository first, while keeping
# any repositories the consumer already configured. Repositories are separated
# by '|'; see https://get-coursier.io/docs/other-repositories
if [ -n "${COURSIER_REPOSITORIES:-}" ]; then
  export COURSIER_REPOSITORIES="file://${_mif_maven_repo_dir}|${COURSIER_REPOSITORIES}"
else
  export COURSIER_REPOSITORIES="file://${_mif_maven_repo_dir}"
fi

# Mill and Coursier both assume HOME is writable. In a Nix build sandbox HOME is
# commonly unset, missing, or points at an unwritable placeholder, so provide a
# temporary home before any build phases run. Preserve a caller-provided writable
# HOME for dev shells and other non-sandboxed uses.
if [ -z "${HOME:-}" ] || [ ! -d "$HOME" ] || [ ! -w "$HOME" ]; then
  export HOME="${TMPDIR:-/tmp}/home"
  mkdir -p "$HOME"
fi

# Coursier writes every artifact it fetches into its cache. In a Nix build
# sandbox the default cache (~/.cache/coursier under an unwritable HOME) cannot
# be created, so fall back to a writable temporary location. Only set this when
# the consumer has not chosen one explicitly.
if [ -z "${COURSIER_CACHE:-}" ]; then
  export COURSIER_CACHE="${TMPDIR:-/tmp}/coursier"
fi

unset _mif_maven_repo_dir
