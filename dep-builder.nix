{ lib, stdenvNoCC, lndir, fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
let
  sources = (import ./generated.nix) { inherit fetchgit fetchurl fetchFromGitHub dockerTools; };
  uniqSources = lib.groupBy (x: x.pkgname) (lib.attrValues sources);
  ivyDepBuilder = ivyName: ivySources: stdenvNoCC.mkDerivation
    {
      name = "convert-ivy-${ivyName}-to-sources";
      passthru = { inherit ivySources; };
      dontUnpack = true;

      propagatedBuildInputs = [ lndir ];

      configurePhase = ''
        runHook preConfigure

        mkdir -p "$out"/.cache/coursier

        runHook postConfigure
      '';

      buildPhase = "runHook preBuild\n"
        + lib.concatMapStringsSep "\n" (x: ''ln -s ${x.src} "$out"/.cache/coursier/${x.install_path}'') ivySources
        + "\nrunHook postBuild";

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"/nix-support
        tee "$out/nix-support/setup-hook" <<EOF
        install_ivy_${ivyName}_to_repo() {
          lndir "$out/.cache/coursier" "$NIX_MILL_HOME"/.cache/coursier
        }

        prePatchHooks+=(install_ivy_${ivyName}_to_repo)
        EOF

        runHook postInstall
      '';
    };
in
{ ivyDeps = lib.mapAttrs ivyDepBuilder uniqSources; }

