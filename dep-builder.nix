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

      configurePhase = ''
        runHook preConfigure

        mkdir -p "$out"/.cache/coursier

        runHook postConfigure
      '';

      buildPhase = "runHook preBuild\n"
        + lib.concatMapStringsSep "\n"
        (x: ''
          mkdir -p "$out/.cache/coursier/${x.install_path}"
          ln -s ${x.src} "$out"/.cache/coursier/${x.install_path}/$(stripHash ${x.src})
        '')
        ivySources
        + "\nrunHook postBuild";

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"/nix-support
        tee "$out/nix-support/setup-hook" <<EOF
        install_ivy_${ivyName}_to_repo() {
          mkdir -p "\$NIX_MILL_HOME/.cache/coursier"
          lndir "$out/.cache/coursier" "\$NIX_MILL_HOME"/.cache/coursier
        }

        prePatchHooks+=(install_ivy_${ivyName}_to_repo)
        EOF

        runHook postInstall
      '';
    };
in
{ ivyDeps = lib.mapAttrs ivyDepBuilder uniqSources; }

