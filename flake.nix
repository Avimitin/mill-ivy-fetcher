{
  description = "Generic devshell setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils }:
    let
      mill-ivy-fetcher-overlay = import ./nix/mill-ivy-fetcher-overlay.nix;
    in
    {
      inherit inputs;
      overlays.default = mill-ivy-fetcher-overlay;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [
            (import ./nix/local-overlay.nix)
            mill-ivy-fetcher-overlay
          ];
          inherit system;
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        legacyPackages = pkgs;
        packages.default = pkgs.mill-ivy-fetcher;
        packages.lock = pkgs.callPackage ./lock.nix { };
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            mill
            metals
          ];
        };
      });
}
