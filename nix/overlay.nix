final: prev:
{
  mill-ivy-fetcher = final.callPackage ./mill-ivy-fetcher { };
  ivy-gather = final.callPackage ./mill-ivy-fetcher/ivy-gather.nix { };
  ivy-codegen = final.callPackage ./mill-ivy-fetcher/ivy-codegen.nix { inherit (final) mill-ivy-fetcher; };
  generateIvyCache = { name, ... }@args:
    rec {
      codegenFiles = final.ivy-codegen args;
      cache = final.ivy-gather "${codegenFiles}/${name}-ivys.nix";
    };
}
