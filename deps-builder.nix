{ lib, stdenvNoCC, lndir, fetchgit, fetchurl, fetchFromGitHub, dockerTools, configure-mill-home-hook }:
nvfetcherNixSrcPath:
let
  sources = (import nvfetcherNixSrcPath) { inherit fetchgit fetchurl fetchFromGitHub dockerTools; };
  uniqSources = lib.groupBy (x: x.pkgname) (lib.attrValues sources);
  ivyDepBuilder = ivyName: ivySources: stdenvNoCC.mkDerivation
    {
      name = "convert-ivy-${ivyName}-to-sources";
      passthru = { inherit ivySources; };
      dontUnpack = true;

      propagatedBuildInputs = [ lndir configure-mill-home-hook ];

      buildPhase = "runHook preBuild\n"
        + lib.concatMapStringsSep "\n"
        (x: ''
          mkdir -p "$out/${x.install_path}"
          ln -s ${x.src} "$out"/${x.install_path}/$(stripHash ${x.src})
        '')
        ivySources
        + "\nrunHook postBuild";

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"/nix-support
        tee "$out/nix-support/setup-hook" <<EOF
        install_ivy_${ivyName}_to_repo() {
          COURSIER_CACHE=''${COURSIER_CACHE:-$NIX_MILL_HOME/.cache/coursier}
          mkdir -p "\$COURSIER_CACHE"/v1
          lndir "$out" "\$COURSIER_CACHE"/v1
        }

        prePatchHooks+=(install_ivy_${ivyName}_to_repo)
        EOF

        runHook postInstall
      '';
    };
in
rec {
  ivyDeps = lib.mapAttrs ivyDepBuilder uniqSources;
  ivyDepsList = lib.attrValues ivyDeps;
}

