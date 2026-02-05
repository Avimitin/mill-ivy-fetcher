{
  lib,
  callPackage,
  zulu,
}:
let
  supportedVersions = {
    "mill_0_12_7" = {
      versionInfo = {
        version = "0.12.7";
        hash = "sha256-bbx1NtEYtYbCqp8nAl/d6F5jiJFN0IkUsdvLdBcMg+E=";
      };
    };
    "mill_0_12_8" = {
      versionInfo = {
        version = "0.12.8";
        hash = "sha256-l+DaOvk7Tajla9IirLfEIij6thZcKI4Zk7wYLnnsiU8=";
      };
    };
    "mill_0_12_9" = {
      versionInfo = {
        version = "0.12.9";
        hash = "sha256-Ntqzivy8dfsRlBclPNsWOZ4h1Xk7D3UJV7GLVGIEcAU=";
      };
    };
    "mill_0_12_10" = {
      versionInfo = {
        version = "0.12.10";
        hash = "sha256-TESwISFz4Xf/F4kgnaTQbi/uVrc75bearih8mydPqHM=";
      };
    };

    "mill_0_12_14" = {
      versionInfo = {
        version = "0.12.14";
        hash = "sha256-2MyufFcgKH/bxVB83qXNESByAdgbzhyIHqAr36Bb9o0=";
      };
    };

    "mill_1_1_0" = {
      versionInfo = {
        version = "1.1.0";
        hash = "sha256-pq7qLX154mYwDkoX4V7UXtOTZaQ6ucxKUIg3z1nBSYM=";
      };
      fixSystemJre = true;
      jre = zulu;
    };
  };
in
lib.mapAttrs (
  _: override: if override ? versionInfo then callPackage ./mill-build.nix override else override
) (supportedVersions // { allVersions = lib.attrNames supportedVersions; })
