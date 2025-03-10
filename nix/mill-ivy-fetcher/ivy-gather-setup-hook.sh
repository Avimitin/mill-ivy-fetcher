install_ivy_@ivyName@_to_repo() {
  COURSIER_CACHE=${COURSIER_CACHE:-$NIX_BUILD_TOP/.cache/coursier}
  mkdir -p "$COURSIER_CACHE"
  lndir "@cacheDir@" "$COURSIER_CACHE"
}

postUnpackHooks+=(install_ivy_@ivyName@_to_repo)
