{
  description = "Generic devshell setup";

  outputs =
    _:
    let
      jsonToSrc =
        file:
        with builtins;
        let
          srcDefines = fromJSON (readFile file);
        in
        mapAttrs (
          name: value:
          import (fetchTarball {
            inherit (value.src) url sha256;
          })
        ) srcDefines;
      mill-ivy-fetcher-overlay = import ./nix/mill-ivy-fetcher-overlay.nix;
      inputs = jsonToSrc ./flake-lock/generated.json;
    in
    {
      inherit inputs;
      overlays.default = mill-ivy-fetcher-overlay;
    }
    // inputs.flake-utils.eachDefaultSystem (
      system:
      let
        pkgs = inputs.nixpkgs {
          overlays = [
            mill-ivy-fetcher-overlay
            (import ./nix/local-overlay.nix)
          ];
          inherit system;
        };
        treefmtEval = inputs.treefmt-nix.evalModule pkgs {
          projectRootFile = "flake.nix";
          settings.verbose = 1;
          programs.nixfmt.enable = true;
        };
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        legacyPackages = pkgs;
        packages.default = pkgs.mill-ivy-fetcher;
        packages.ci-test = pkgs.callPackage ./.github/integration/chisel.nix { };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            mill
            metals
          ];
        };
      }
    );
}
