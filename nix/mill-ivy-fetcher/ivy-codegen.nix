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

    nvfetcher
    # required by nvfetcher, to run nix-prefetch-url
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

  # nvfetcher will run nix hash to generate hash
  NIX_CONFIG = ''
    experimental-features = nix-command
  '';

  buildPhase = ''
    runHook preBuild

    mkdir -p coursier build
    mill_ivy_fetcher fetch --work-dir coursier ${fetchArgs}
    mill_ivy_fetcher dump --coursier-dir coursier/cache --dump-path build/nvfetcher.toml

    cd build
    # nvfetcher will write database lock to $HOME/.local/nvfetcher, but HOME is set to
    # /homeless-shelter to protect chroot.
    # https://github.com/berberman/nvfetcher/blob/master/src/NvFetcher/Utils.hs#L39
    XDG_DATA_HOME=$NIX_BUILD_TOP \
      nvfetcher

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
  (lib.removeAttrs extraArgs [ "name" "src" "hash" "targets" "extraBuildInputs" ]))
