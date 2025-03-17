install_ivy_cache() {
  COURSIER_CACHE=${COURSIER_CACHE:-$NIX_BUILD_TOP/.cache/coursier}
  cp -vr "@cacheDir@" "$COURSIER_CACHE/"
  chmod -R u+w -- "$COURSIER_CACHE"
}

postUnpackHooks+=(install_ivy_cache)
