{ python3
, runCommand
, callPackage
}:
let
  self = runCommand "build-mill-ivy-fetcher"
    {
      propagatedBuildInputs = [ python3 ];
      meta.mainProgram = "mill_ivy_fetcher";
      passthru = {
        ivy-gather = callPackage ./nix/ivy-gather.nix { };
        ivy-codegen = callPackage ./nix/ivy-codegen.nix { mill-ivy-fetcher = self; };

        generateIvyCache = { name, src, hash, targets ? [ ] }:
          rec {
            codegenFiles = self.ivy-codegen { inherit name src hash targets; };
            cache = self.ivy-gather "${codegenFiles}/${name}-ivys.nix";
          };
      };
    } ''
    mkdir -p "$out/bin"
    cp ${./mill_ivy_fetcher.py} "$out/bin/mill_ivy_fetcher"
    patchShebangs --host "$out/bin"
  '';
in
self
