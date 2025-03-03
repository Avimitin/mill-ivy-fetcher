{
  description = "Generic devshell setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    chisel-nix.url = "github:chipsalliance/chisel-nix/new-mill-flow";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, chisel-nix }:
    { inherit inputs; } // flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = import ./nix/overlay.nix;
        pkgs = import nixpkgs { overlays = [ (import ./nix/local-overlay.nix) chisel-nix.overlays.mill-flows overlay ]; inherit system; };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        legacyPackages = pkgs;
        packages.default = pkgs.mill-ivy-fetcher;
        packages.test-foo = pkgs.callPackage ./demo/default.nix { };
        overlays.default = overlay;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            black
            pyright
          ];
        };
      });
}
