{ lib
, stdenvNoCC
, lndir
, fetchgit
, fetchurl
, fetchFromGitHub
, dockerTools
, configure-mill-env-hook
}:

nvfetcherNixSrcPath:

let
  sources = (import nvfetcherNixSrcPath) { inherit fetchgit fetchurl fetchFromGitHub dockerTools; };
  uniqSources = lib.groupBy (x: x.pkgname) (lib.attrValues sources);
  ivyDepBuilder = ivyName: ivySources: stdenvNoCC.mkDerivation
    {
      name = "convert-ivy-${ivyName}-to-sources";
      passthru = { inherit ivySources; };
      dontUnpack = true;

      propagatedBuildInputs = [ lndir configure-mill-env-hook ];

      buildPhase = "runHook preBuild\n"
        + lib.concatMapStringsSep "\n"
        (x: ''
          mkdir -p "$out/cache/${x.install_path}"
          ln -s ${x.src} "$out"/cache/${x.install_path}/$(stripHash ${x.src})
        '')
        ivySources
        + "\nrunHook postBuild";

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"/nix-support
        substitute ${./ivy-gather-setup-hook.sh} "$out"/nix-support/setup-hook \
          --replace-fail "@cacheDir@" "$out/cache" \
          --replace-fail "@ivyName@" "${ivyName}"

        runHook postInstall
      '';
    };
in
rec {
  ivyDeps = lib.mapAttrs ivyDepBuilder uniqSources;
  ivyDepsList = lib.attrValues ivyDeps;
}

