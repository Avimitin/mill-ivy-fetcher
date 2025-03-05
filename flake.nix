{
  description = "Generic devshell setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    chisel-nix.url = "github:chipsalliance/chisel-nix/new-mill-flow";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, chisel-nix }:
    let
      overlay = import ./nix/overlay.nix;
    in
    {
      inherit inputs;
      overlays.default = overlay;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { overlays = [ (import ./nix/local-overlay.nix) chisel-nix.overlays.mill-flows overlay ]; inherit system; };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        legacyPackages = pkgs;
        packages.default = pkgs.mill-ivy-fetcher;
        packages.test-foo = pkgs.callPackage ./demo/default.nix { };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            black
            pyright
          ];
        };
      });
}
