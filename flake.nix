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
      inputs = jsonToSrc ./flake-lock/generated.json;
    in
    {
      inherit inputs;
    }
    // inputs.flake-utils.eachDefaultSystem (
      system:
      let
        pkgs = inputs.nixpkgs {
          overlays = [
            (import ./nix/local-overlay.nix)
          ];
          inherit system;
        };
        treefmtEval = inputs.treefmt-nix.evalModule pkgs {
          projectRootFile = "flake.nix";
          settings.verbose = 1;
          programs.nixfmt.enable = true;
        };

        mifPackages = pkgs.callPackage ./nix/packages.nix { };
      in
      {
        formatter = treefmtEval.config.build.wrapper;
        legacyPackages = pkgs;
        packages =
          let
            callPackage = pkgs.lib.callPackageWith (pkgs // mifPackages);
          in
          mifPackages
          // {
            ci-test = callPackage ./.github/integration/chisel.nix { };
          };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            mill
            metals
          ];
        };
      }
    );
}
