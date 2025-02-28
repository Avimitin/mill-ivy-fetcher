{ lib, stdenvNoCC, mill, jdk21, callPackage, makeWrapper }:
let
  mill-ivy-fetcher = (callPackage ../package.nix { inherit callPackage; });
  src = with lib.fileset; toSource {
    root = ./.;
    fileset = unions [
      ./build.mill
      ./foo
    ];
  };

  ivyCache = mill-ivy-fetcher.generateIvyCache {
    name = "foo-deps";
    inherit src;
    hash = "sha256-p2Aip+zlhr6LyYFJ8IOsqzv3aNkvS8u1VssD3Zr/34o=";
  };
in
stdenvNoCC.mkDerivation {
  name = "foo";
  inherit src;

  nativeBuildInputs = [ mill makeWrapper ];

  buildInputs = ivyCache.cache.ivyDepsList;

  buildPhase = ''
    runHook preBuild

    mill -i '__.assembly'

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/java" "$out/bin"

    cp out/foo/assembly.dest/out.jar "$out/share/java/foo.jar"
    makeWrapper ${jdk21}/bin/java $out/bin/foo \
      --add-flags "-jar $out/share/java/foo.jar"

    runHook postInstall
  '';

  passthru = {
    inherit ivyCache;
  };
}
