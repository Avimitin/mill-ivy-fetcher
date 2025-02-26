install_ivy_@ivyName@_to_repo() {
  COURSIER_CACHE=${COURSIER_CACHE:-$NIX_BUILD_TOP/.cache/coursier}
  mkdir -p "$COURSIER_CACHE"/v1
  lndir "@out@" "$COURSIER_CACHE"/v1
}

prePatchHooks+=(install_ivy_@ivyName@_to_repo)
