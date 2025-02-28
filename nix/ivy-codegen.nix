{ lib, stdenvNoCC, mill-ivy-fetcher, nvfetcher, mill }:

{ name, src, hash, targets ? [ ] }@extraArgs:

let
  fetchArgs = lib.escapeShellArgs
    (lib.flatten
      (map (x: [ "--targets" x ]) targets));
in
stdenvNoCC.mkDerivation (lib.recursiveUpdate
{
  name = "ivy-codegen-for-${name}";

  inherit src;

  nativeBuildInputs = [
    mill-ivy-fetcher
    nvfetcher
    mill
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p coursier build
    mill_ivy_fetcher fetch --work-dir couriser ${fetchArgs}
    mill_ivy_fetcher dump --coursier-dir coursier/cache --dump-path build/nvfetcher.toml
    cd build
    HOME=$PWD nvfetcher

    runHook postBuild
  '';


  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    mv _sources/generated.nix "$out"/${name}-ivys.nix

    runHook postInstall
  '';

  impureEnvVars = [ "JAVA_OPTS" "JAVA_TOOL_OPTIONS" ];

  outputHashMode = "nar";
  outputHashAlgo = "sha256";
  outputHash = hash;
}
  (lib.removeAttrs extraArgs [ "name" "src" "hash" "targets" ]))
