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
            mavenRepository = pkgs.mkMavenRepository {
              lockFile = ./mif.lock.json;
            };
            representativeArtifact = builtins.head (builtins.attrValues mavenRepository.artifacts);
          in
          {
            _module.args.pkgs = pkgs;

            legacyPackages = pkgs;

            packages.default = mifPackage;

            packages.mif = mifPackage;

            packages.mif-maven-repository = mavenRepository;

            packages.mif-jar = mifPackage;

            packages.ci-test = ciTest;

            checks.maven-fetch-environment =
              assert pkgs.lib.assertMsg (
                representativeArtifact.impureEnvVars == pkgs.lib.fetchers.proxyImpureEnvVars
              ) "Maven artifact fetches must inherit Nix's proxy and custom CA environment";
              assert pkgs.lib.assertMsg (
                pkgs.lib.hasInfix "NIX_SSL_CERT_FILE:-" representativeArtifact.buildCommand
                && pkgs.lib.hasInfix "/etc/ssl/certs/ca-bundle.crt" representativeArtifact.buildCommand
              ) "Maven artifact fetches must prefer NIX_SSL_CERT_FILE and fall back to cacert";
              pkgs.runCommand "maven-fetch-environment-check" { } ''
                touch "$out"
              '';

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

            # CI unit tests only need Mill and its bundled JRE. Keep the full
            # mif package, offline Maven repository, Metals, and bubblewrap out
            # of this shell so test startup does not materialize them.
            devShells.ci = pkgs.mkShell {
              nativeBuildInputs = [ pkgs.millVersions.mill_1_1_2 ];
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
