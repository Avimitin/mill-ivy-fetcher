#!/usr/bin/env bash

nix run "nixpkgs#nvfetcher" -- -o ./flake-lock && rm ./flake-lock/generated.nix
