install_ivy_cache() {
  COURSIER_CACHE=${COURSIER_CACHE:-$NIX_BUILD_TOP/.cache/coursier}

  local cpFlags=(--recursive)
  local logLvl=${NIX_DEBUG:-0}
  if (( $logLvl > 3 )); then
    cpFlags+=(--verbose)
  fi

  echo "Installing Ivy cache"

  cp ${cpFlags[*]} "@cacheDir@" "$COURSIER_CACHE/"

  # Ensure the cache is writable when using nix develop
  chmod -R u+w -- "$COURSIER_CACHE"
}

postUnpackHooks+=(install_ivy_cache)
