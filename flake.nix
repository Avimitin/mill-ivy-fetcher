{
  description = "Generic devshell setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    chisel-nix.url = "github:chipsalliance/chisel-nix";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, chisel-nix }:
    { inherit inputs; } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { overlays = [ (import ./overlay.nix) chisel-nix.overlays.mill-flows ]; inherit system; };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        legacyPackages = pkgs;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python3
            black
            pyright
          ];
        };
      });
}
