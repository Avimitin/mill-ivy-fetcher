{
  description = "Generic devshell setup";

  nixConfig.minimumVersion = "2.28";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, nixpkgs, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { getSystem, ... }:
      let
        mill-ivy-fetcher-overlay = import ./nix/mill-ivy-fetcher-overlay.nix;

        millOverlay = import ./nix/mill-overlay.nix;
      in
      {
        flake = {
          overlays = {
            default = mill-ivy-fetcher-overlay;
            inherit mill-ivy-fetcher-overlay;

            mill-overlay = millOverlay;
          };
        };

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ];

        imports = [
          inputs.treefmt-nix.flakeModule
        ];

        perSystem =
          { system, config, ... }:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
                mill-ivy-fetcher-overlay
                millOverlay
              ];
            };
          in
          {
            _module.args.pkgs = pkgs;

            legacyPackages = pkgs;

            packages = {
              # mif has a lock file in this repo that cannot depend on the downstream mill to build
              default = pkgs.mill-ivy-fetcher;
              inherit (pkgs) mill-ivy-fetcher;

              ci-test = pkgs.callPackage ./.github/integration/chisel.nix { };
            };

            devShells.default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                millVersions.mill_1_1_0
                metals
              ];
            };

            treefmt = {
              projectRootFile = "flake.nix";
              settings.verbose = 1;
              programs.nixfmt.enable = pkgs.lib.meta.availableOn pkgs.stdenv.buildPlatform pkgs.nixfmt.compiler;
              programs.scalafmt.enable = true;
            };
          };
      }
    );
}
