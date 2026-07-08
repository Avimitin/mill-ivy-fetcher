{
  addDeterminismHook,
  coreutils,
  fetchFromGitHub,
  git,
  gnused,
  lib,
  mif,
  millVersions,
  mkMavenRepository,
  stdenvNoCC,
  writeShellApplication,
}:

let
  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "chisel";
    rev = "5e0ae3f46327c9ff15898f13ea8b94bbad90f653";
    hash = "sha256-TU3AlrbWcps6zYbfLD677jfZ/UcBO1M9FcG1nb98Nhk=";
  };

  # The local Maven repository generated from the Chisel integration lock. It
  # ships a setup hook, so listing it in buildInputs is enough to make
  # Mill/Coursier resolve every dependency from here, fully offline.
  m2 = mkMavenRepository { lockFile = ./chisel-lock.json; };
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "chisel-integration";
  version = "5e0ae3f46327c9ff15898f13ea8b94bbad90f653";

  inherit src;

  nativeBuildInputs = [
    addDeterminismHook
    git
    millVersions.mill_1_1_2
  ];
  buildInputs = [ m2 ];

  dontConfigure = true;

  preBuild = ''
    # Fix Mill JVM version detection; use the JVM from our packaged Mill.
    sed -i '1i //| mill-jvm-version: system' build.mill
  '';

  buildPhase = ''
    runHook preBuild

    mill --no-daemon unipublish.publishLocal --localIvyRepo "$NIX_BUILD_TOP/local-m2"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -a "$NIX_BUILD_TOP/local-m2" "$out/local"

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    # Chisel's generated Scaladoc JARs are not reproducible yet.
    # https://github.com/chipsalliance/chisel/issues/4666
    find "$out/local" -wholename '*/docs/*.jar' -type f -delete

    runHook postFixup
  '';

  dontPatchELF = true;
  dontShrink = true;

  passthru = {
    inherit m2;

    bump = writeShellApplication {
      name = "bump-chisel";
      runtimeInputs = [
        coreutils
        gnused
        mif
        millVersions.mill_1_1_2
      ];
      text = ''
        workdir="$(mktemp -d)"
        cleanup() {
          rm -rf "$workdir"
        }
        trap cleanup EXIT

        cp -R --no-preserve=mode,ownership "${src}/." "$workdir/"
        sed -i '1i //| mill-jvm-version: system' "$workdir/build.mill"

        mif archive \
          -p "$workdir" \
          --lock .github/integration/chisel-lock.json \
          --fresh \
          -- mill --no-daemon __.prepareOffline

        mif archive \
          -p "$workdir" \
          --lock .github/integration/chisel-lock.json \
          -- mill --no-daemon __.scalaCompilerClasspath
      '';
    };
  };

  meta = {
    description = "Chisel integration test for mill-ivy-fetcher offline packaging";
    homepage = "https://github.com/chipsalliance/chisel";
    license = lib.licenses.asl20;
    platforms = lib.platforms.unix;
  };
})
