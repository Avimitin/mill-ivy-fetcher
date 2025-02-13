{ lib, stdenvNoCC, mill, jdk21, callPackage, makeWrapper }:
let
  deps = (callPackage ./deps/_sources { }).ivyDeps;
in
stdenvNoCC.mkDerivation {
  name = "foo-deps";

  src = with lib.fileset; toSource {
    root = ./.;
    fileset = unions [
      ./build.mill
      ./foo
    ];
  };

  nativeBuildInputs = [ mill makeWrapper ];

  buildInputs = lib.attrValues deps;

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
    millDeps = deps;
  };
}
