{
  addDeterminismHook,
  bubblewrap,
  lib,
  makeWrapper,
  mkMavenRepository,
  millVersions,
  nix,
  stdenvNoCC,
  zulu,
}:

let
  # The local Maven repository generated from the lock. It ships a setup hook,
  # so listing it in buildInputs is enough to make Mill/Coursier resolve every
  # dependency from here, fully offline.
  m2 = mkMavenRepository { lockFile = ./mtf.lock.json; };

  runtimePath = [ nix ] ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [ bubblewrap ];
  wrapperPathArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath runtimePath)
  ];
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mtf";
  version = "0.3.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./build.mill
      ./mtf
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

    mill --no-daemon mtf.assembly

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 out/mtf/assembly.dest/*.jar "$out/lib/mtf.jar"
    makeWrapper ${zulu}/bin/java "$out/bin/mtf" \
      --add-flags "-jar $out/lib/mtf.jar" \
      ${lib.escapeShellArgs wrapperPathArgs}

    runHook postInstall
  '';

  meta = {
    description = "Capture Maven repository traffic as reproducible Nix locks";
    homepage = "https://github.com/Avimitin/mvn-trace-forge";
    license = lib.licenses.asl20;
    mainProgram = "mtf";
    platforms = lib.platforms.unix;
  };
})
