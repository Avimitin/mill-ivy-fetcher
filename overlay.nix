final: prev: {
  mill = let jre = final.jdk21; in
    (prev.mill.override { inherit jre; }).overrideAttrs {
      # Fixed the buggy sorting issue in target resolve
      version = "unstable-0.12.5-173-15dded";
      src = final.fetchurl {
        url = "https://github.com/com-lihaoyi/mill/releases/download/0.12.5/0.12.5-173-15dded-assembly";
        hash = "sha256-xP59tONOu0CG5Gce4ru+st5KUH7Wcd10d/pQdELjSJM=";
      };
      passthru = { inherit jre; };
    };
}
