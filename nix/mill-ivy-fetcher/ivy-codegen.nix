{ lib, stdenvNoCC, mill-ivy-fetcher, nvfetcher, mill, nix, cacert }:

{ name, src, hash, targets ? [ ], extraBuildInputs ? [ ], ... }@extraArgs:

let
  fetchArgs = lib.escapeShellArgs
    (lib.flatten
      (map (x: [ "--targets" x ]) targets));
in
stdenvNoCC.mkDerivation (lib.recursiveUpdate
{
  name = "ivy-codegen-for-${name}";

  inherit src;

  buildInputs = extraBuildInputs;

  nativeBuildInputs = [
    mill-ivy-fetcher
    mill
    cacert

    # required for running nix hash
    nix
  ];

  # Disable TLS verification only when we know the hash and no credentials are
  # needed to access the resource
  SSL_CERT_FILE =
    if
      (
        hash == ""
        || hash == lib.fakeSha256
        || hash == lib.fakeSha512
        || hash == lib.fakeHash
      )
    then
      "${cacert}/etc/ssl/certs/ca-bundle.crt"
    else
      "/no-cert-file.crt";

  buildPhase = ''
    runHook preBuild

    mkdir -p build coursier

    mif fetch --cache coursier ${fetchArgs}
    mif dump --cache coursier --codegen-path build/${name}-mill-lock.nix

    runHook postBuild
  '';


  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp build/${name}-mill-lock.nix "$out"/

    runHook postInstall
  '';

  impureEnvVars = [ "JAVA_OPTS" "JAVA_TOOL_OPTIONS" "https_proxy" ];

  outputHashMode = "nar";
  outputHashAlgo = "sha256";
  outputHash = hash;
}
  (lib.removeAttrs extraArgs [ "name" "src" "hash" "targets" "extraBuildInputs" ]))
