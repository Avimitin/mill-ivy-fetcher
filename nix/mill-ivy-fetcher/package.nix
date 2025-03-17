{ lib
, stdenv
, makeWrapper

, mill
, ivy-gather
, add-determinism
}:
let
  ivyCache = ivy-gather ../../lock.nix;
in
stdenv.mkDerivation {
  name = "mill-ivy-fetcher";

  src = with lib.fileset;
    toSource {
      root = ./../..;
      fileset = unions [
        ./../../build.mill
        ./../../mif
      ];
    };

  nativeBuildInputs = [
    mill
    makeWrapper
  ];

  buildInputs = [ add-determinism ivyCache ];

  passthru = { inherit ivyCache; };

  buildPhase = ''
    mill -i '__.assembly'
  '';

  installPhase = ''
    mkdir -p $out/share/java

    export SOURCE_DATE_EPOCH=1669810380
    add-determinism -j $NIX_BUILD_CORES out/mif/assembly.dest/out.jar

    mv out/mif/assembly.dest/out.jar $out/share/java/mif.jar

    mkdir -p $out/bin
    makeWrapper ${mill.jre}/bin/java $out/bin/mif \
      --add-flags "-jar $out/share/java/mif.jar"
  '';

  meta.mainProgram = "mif";
}
