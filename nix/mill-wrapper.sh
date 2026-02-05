#! @shell@ -e

set -euo pipefail

install_path=$(CDPATH=  cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

readonly MILL_FILE="build.mill"
readonly VERSION_FILE=".mill-jvm-version"
FORCE_SYSTEM_JRE="${FORCE_SYSTEM_JRE:-}"

modified_file=""

patchHeader() {
  tmp=$(mktemp)
  echo "//| mill-jvm-version: system" > "$tmp"
  cat "$MILL_FILE" >> "$tmp"
  mv "$tmp" "$MILL_FILE"
  modified_file="$MILL_FILE"
}

if [[ -n "$FORCE_SYSTEM_JRE" ]]; then
  patchHeader
elif [[ -f "$MILL_FILE" ]]; then
  if [[ ! -f "$VERSION_FILE" ]]; then
    if ! grep -qE "//\| mill-jvm-version:[[:space:]]*[^[:space:]]" "$MILL_FILE"; then
      patchHeader
    fi
  fi
elif [[ ! -f "$VERSION_FILE" ]]; then
  echo "system" > "$VERSION_FILE"
  modified_file="$VERSION_FILE"
fi

if [[ -n "$modified_file" ]]; then
  cat >&2 <<EOF
>> [mill-wrapper] Modified: $modified_file
>> [mill-wrapper] Note: This modification exists because you are using a patched version of mill
>> [mill-wrapper] so that mill can use the system JDK instead of its vendor version.
EOF
fi

export PATH="@system_jre@/bin:$PATH"
export JAVA_HOME="${JAVA_HOME:-@system_jre@}"
export JAVA_OPTS="${JAVA_OPTS:-}"

# head -n 25 to see the pre-built binary self start script
exec -a "$0" "$JAVA_HOME/bin/java" $JAVA_OPTS -cp "$install_path/@mill_bin@" 'mill.launcher.MillLauncherMain' "$@"
