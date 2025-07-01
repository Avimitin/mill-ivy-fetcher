final: prev:
let
  jre = final.jre;

  supportedVersions = {
    "mill_0_12_7" = {
      version = "0.12.7";
      hash = "sha256-bbx1NtEYtYbCqp8nAl/d6F5jiJFN0IkUsdvLdBcMg+E=";
    };
    "mill_0_12_8" = {
      version = "0.12.8";
      hash = "sha256-l+DaOvk7Tajla9IirLfEIij6thZcKI4Zk7wYLnnsiU8=";
    };
    "mill_0_12_9" = {
      version = "0.12.9";
      hash = "sha256-Ntqzivy8dfsRlBclPNsWOZ4h1Xk7D3UJV7GLVGIEcAU=";
    };
    "mill_0_12_10" = {
      version = "0.12.10";
      hash = "sha256-TESwISFz4Xf/F4kgnaTQbi/uVrc75bearih8mydPqHM=";
    };
    "mill_0_12_14" = {
      version = "0.12.14";
      hash = "sha256-2MyufFcgKH/bxVB83qXNESByAdgbzhyIHqAr36Bb9o0=";
    };
  };
in
prev.lib.mapAttrs (
  _: info:
  let
    inherit (info) version hash;
  in
  (prev.mill.override { inherit jre; }).overrideAttrs rec {
    inherit version;
    src = final.fetchurl {
      url = if (builtins.compareVersions version "0.12.12" >= 0) then
        "https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/${version}/mill-dist-${version}.exe"
      else
        "https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/${version}/mill-dist-${version}-assembly.jar";
      inherit hash;
    };
    passthru = { inherit jre; };
  }
) supportedVersions
