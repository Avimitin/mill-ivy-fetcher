{
  addDeterminismHook,
  bubblewrap,
  lib,
  makeWrapper,
  mkMavenRepository,
  millVersions,
  stdenvNoCC,
  zulu,
}:

let
  # The local Maven repository generated from the lock. It ships a setup hook,
  # so listing it in buildInputs is enough to make Mill/Coursier resolve every
  # dependency from here, fully offline.
  m2 = mkMavenRepository { lockFile = ./mif.lock.json; };

  wrapperPathArgs = lib.optionals stdenvNoCC.hostPlatform.isLinux [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [ bubblewrap ])
  ];
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mif";
  version = "0.3.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./build.mill
      ./mif
    ];
  };

  nativeBuildInputs = [
    addDeterminismHook
    makeWrapper
    millVersions.mill_1_1_2
  ];
  buildInputs = [ m2 ];

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    mill --no-daemon mif.assembly

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 out/mif/assembly.dest/*.jar "$out/lib/mif.jar"
    makeWrapper ${zulu}/bin/java "$out/bin/mif" \
      --add-flags "-jar $out/lib/mif.jar" \
      ${lib.escapeShellArgs wrapperPathArgs}

    runHook postInstall
  '';

  meta = {
    description = "Generate Nix locks from Mill Ivy dependencies";
    homepage = "https://github.com/Avimitin/mill-ivy-fetcher";
    license = lib.licenses.asl20;
    mainProgram = "mif";
    platforms = lib.platforms.unix;
  };
})
