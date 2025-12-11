final: prev: {
  mill =
    let
      jre = final.zulu;
      wrapper = final.writeText "millw" ''
        #!/usr/bin/env bash

        set -euo pipefail

        readonly MILL_FILE="build.mill"
        readonly VERSION_FILE=".mill-jvm-version"

        modified_file=""

        if [[ -f "$MILL_FILE" ]]; then
          if [[ ! -f "$VERSION_FILE" ]]; then
            if ! grep -qE "//\| mill-jvm-version:[[:space:]]*[^[:space:]]" "$MILL_FILE"; then
              # 1.3 Prepend header securely using a temp file
              tmp=$(mktemp)
              echo "//| mill-jvm-version: system" > "$tmp"
              cat "$MILL_FILE" >> "$tmp"
              mv "$tmp" "$MILL_FILE"
              modified_file="$MILL_FILE"
            fi
          fi
        else
            if [[ ! -f "$VERSION_FILE" ]]; then
                echo "system" > "$VERSION_FILE"
                modified_file="$VERSION_FILE"
            fi
        fi

        if [[ -n "$modified_file" ]]; then
          cat >&2 <<EOF
        >> [mill-wrapper] Modified: $modified_file
        >> [mill-wrapper] Note: This modification exists because you are using a patched version of mill
        >> [mill-wrapper] so that mill can use the system JDK instead of its vendor version.
        EOF
        fi

        export JAVA_HOME="''${JAVA_HOME:-@system_jre@}"
        exec @mill_unwrap@ "$@"
      '';
    in
    (prev.mill.override { inherit jre; }).overrideAttrs rec {
      # Fixed the buggy sorting issue in target resolve
      version = "1.1.0-RC3";
      src = final.fetchurl {
        url = "https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/${version}/mill-dist-${version}.exe";
        hash = "sha256-TmAN19M80CiiQHSTe4BrPkeicEwVNCYl5XgOfPXQwIY=";
      };
      installPhase = ''
        runHook preInstall

        install -Dm 555 $src $out/bin/.mill-wrapped

        export system_jre=${jre}
        export mill_unwrap=$out/bin/.mill-wrapped
        substituteAll ${wrapper} $out/bin/mill
        chmod u+x $out/bin/mill

        runHook postInstall
      '';
      passthru = { inherit jre; };
    };

  mill-ivy-fetcher = final.callPackage ./mill-ivy-fetcher/package.nix { };
}
