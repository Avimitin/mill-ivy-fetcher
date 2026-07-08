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
        millOverlay = import ./nix/mill-overlay.nix;
      in
      {
        flake = {
          overlays = {
            default = millOverlay;
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
                millOverlay
              ];
            };
            mifPackage = pkgs.callPackage ./package.nix { };
            ciTest = pkgs.callPackage ./.github/integration/chisel.nix { mif = mifPackage; };
          in
          {
            _module.args.pkgs = pkgs;

            legacyPackages = pkgs;

            packages.default = mifPackage;

            packages.mif = mifPackage;

            packages.mif-maven-repository = pkgs.mkMavenRepository {
              lockFile = ./mif.lock.json;
            };

            packages.mif-jar = mifPackage;

            packages.ci-test = ciTest;

            devShells.default = pkgs.mkShell {
              nativeBuildInputs = [
                mifPackage
                pkgs.millVersions.mill_1_1_2
                pkgs.metals
              ]
              # `mif archive` sandboxes build commands with bubblewrap;
              # bubblewrap is Linux-only.
              ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.bubblewrap ];
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
