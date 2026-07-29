{
  description = "Mvn Trace Forge: capture Maven repository traffic as reproducible Nix locks";

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
        mtfOverlay = import ./nix/mtf-overlay.nix;
      in
      {
        flake = {
          overlays = {
            default = mtfOverlay;
            mtf-overlay = mtfOverlay;
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
                mtfOverlay
              ];
            };
            mtfPackage = pkgs.callPackage ./package.nix { };
            ciTest = pkgs.callPackage ./.github/integration/chisel.nix { mtf = mtfPackage; };
            mavenRepository = pkgs.mkMavenRepository {
              lockFile = ./mtf.lock.json;
            };
            representativeArtifact = builtins.head (builtins.attrValues mavenRepository.artifacts);
          in
          {
            _module.args.pkgs = pkgs;

            legacyPackages = pkgs;

            packages.default = mtfPackage;

            packages.mtf = mtfPackage;

            packages.mtf-maven-repository = mavenRepository;

            packages.mtf-jar = mtfPackage;

            packages.ci-test = ciTest;

            checks.maven-fetch-environment =
              assert pkgs.lib.assertMsg (
                representativeArtifact.impureEnvVars == pkgs.lib.fetchers.proxyImpureEnvVars
              ) "Maven artifact fetches must inherit Nix fetcher's impure environment";
              assert pkgs.lib.assertMsg (
                representativeArtifact.SSL_CERT_FILE == "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              ) "Maven artifact fetches must use the pinned CA bundle";
              assert pkgs.lib.assertMsg (
                !pkgs.lib.hasInfix "--insecure" representativeArtifact.buildCommand
              ) "Maven artifact fetches must keep TLS verification enabled";
              pkgs.runCommand "maven-fetch-environment-check" { } ''
                touch "$out"
              '';

            devShells.default = pkgs.mkShell {
              nativeBuildInputs = [
                mtfPackage
                pkgs.millVersions.mill_1_1_2
                pkgs.metals
              ]
              # `mtf archive` sandboxes build commands with bubblewrap;
              # bubblewrap is Linux-only.
              ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.bubblewrap ];
            };

            # CI unit tests only need Mill and its bundled JRE. Keep the full
            # mtf package, offline Maven repository, Metals, and bubblewrap out
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
