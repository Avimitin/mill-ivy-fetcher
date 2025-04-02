{
  lib,
  stdenvNoCC,
  lndir,
  fetchurl,
  configure-mill-env-hook,
}:

nixLock:

let
  sources = (import nixLock) { inherit fetchurl; };
in
stdenvNoCC.mkDerivation {
  name = "build-ivy-cache-env";
  dontUnpack = true;

  propagatedBuildInputs = [
    lndir
    configure-mill-env-hook
  ];

  buildPhase =
    "runHook preBuild\n"
    + lib.concatMapStringsSep "\n" (x: ''
      mkdir -p "$out/cache/${x.installPath}"
      lndir ${x} "$out"/cache/${x.installPath}
    '') (lib.attrValues sources)
    + "\nrunHook postBuild";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"/nix-support
    substitute ${./ivy-gather-setup-hook.sh} "$out"/nix-support/setup-hook \
      --replace-fail "@cacheDir@" "$out/cache" \

    runHook postInstall
  '';

  passthru = { inherit sources; };
}
