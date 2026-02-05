#! @shell@ -e

set -euo pipefail

# Securely determine the absolute path of the script directory
install_path=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Set up environment variables
export PATH="@system_jre@/bin:$PATH"
export JAVA_HOME="${JAVA_HOME:-@system_jre@}"
export JAVA_OPTS="${JAVA_OPTS:-}"
export MILL_EXECUTABLE_PATH="$0"

MILL_BIN="$install_path/@mill_bin@"
BSP_JSON=".bsp/mill-bsp.json"

# Construct the mill command arguments
# JAVA_OPTS is intentionally unquoted to allow for multiple space-separated options
mill_cmd=("$JAVA_HOME/bin/java" $JAVA_OPTS -cp "$MILL_BIN" mill.runner.client.MillClientMain)

# Check if the user is running the BSP install command
has_bsp_install=false
for arg in "$@"; do
    if [[ "$arg" == "mill.bsp.BSP/install" ]]; then
        has_bsp_install=true
        break
    fi
done

if [[ "$has_bsp_install" == false ]]; then
    # Normal execution: replace the current process with mill to preserve signals and PID
    exec -a "$0" "${mill_cmd[@]}" "$@"
else
    # BSP install: run mill as a subprocess
    "${mill_cmd[@]}" "$@" || exit $?

    # Patch the generated BSP configuration to point to this wrapper
    if [[ -f "$BSP_JSON" ]]; then
        wrapper_path=$(realpath "$0")
        # Use a temporary file for atomic writing
        tmp_json=$(mktemp)
        # Replace the internal mill binary path with the wrapper path
        sed "s|\"[^\"]*@mill_bin@\"|\"$wrapper_path\"|g" "$BSP_JSON" > "$tmp_json"
        mv "$tmp_json" "$BSP_JSON"
        echo "[mill-bsp-wrapper] Patched $BSP_JSON to use wrapper: $wrapper_path" >&2
    fi
fi
