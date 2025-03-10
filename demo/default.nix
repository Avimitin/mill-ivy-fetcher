{ lib, stdenvNoCC, mill, jdk21, makeWrapper, generateIvyCache, publishMillJar }:
let
  src = with lib.fileset; toSource {
    root = ./.;
    fileset = unions [
      ./build.mill
      ./foo
    ];
  };

  ivyCache = generateIvyCache {
    name = "foo-deps";
    inherit src;
    hash = "sha256-7GQe62dGnSmTm3apResF3jEnwyvDMpRxjTZTJkby/1E=";
    targets = [ "foo" ];
  };

  fooJar = publishMillJar {
    name = "foo";
    inherit src;

    publishTargets = [
      "foo"
    ];

    buildInputs = ivyCache.cache.ivyDepsList;

    passthru = {
      inherit ivyCache;
    };
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
    ln -s "${fooJar}"/local "$out"/local

    cp out/foo/assembly.dest/out.jar "$out/share/java/foo.jar"
    makeWrapper ${jdk21}/bin/java $out/bin/foo \
      --add-flags "-jar $out/share/java/foo.jar"

    runHook postInstall
  '';

  passthru = {
    inherit ivyCache fooJar;
  };
}
