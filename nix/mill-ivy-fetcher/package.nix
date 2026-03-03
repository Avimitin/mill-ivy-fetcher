{
  lib,
  stdenv,
  makeWrapper,

  millVersions,
  ivy-gather,
  add-determinism-hook,
}:
let
  ivyCache = ivy-gather ../../lock.nix;
  mill = millVersions.mill_1_1_2;
in
stdenv.mkDerivation {
  name = "mill-ivy-fetcher";

  src =
    with lib.fileset;
    toSource {
      root = ./../..;
      fileset = unions [
        ./../../build.mill
        ./../../mif
      ];
    };

  nativeBuildInputs = [
    makeWrapper
    add-determinism-hook
  ];

  propagatedBuildInputs = [
    mill
  ];

  buildInputs = [ ivyCache ];

  passthru = { inherit ivyCache; };

  buildPhase = ''
    mill -i --offline '__.assembly'
  '';

  installPhase = ''
    mkdir -p $out/share/java

    mv out/mif/assembly.dest/out.jar $out/share/java/mif.jar

    mkdir -p $out/bin
    makeWrapper ${mill.jre}/bin/java $out/bin/mif \
      --add-flags "-jar $out/share/java/mif.jar"
  '';

  meta.mainProgram = "mif";
}
