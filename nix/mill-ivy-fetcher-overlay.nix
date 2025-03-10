final: prev:
{
  mill-ivy-fetcher = final.callPackage ./mill-ivy-fetcher/package.nix { };
  ivy-gather = final.callPackage ./mill-ivy-fetcher/ivy-gather.nix { };
  ivy-codegen = final.callPackage ./mill-ivy-fetcher/ivy-codegen.nix { inherit (final) mill-ivy-fetcher; };
  generateIvyCache = { name, ... }@args:
    rec {
      codegenFiles = final.ivy-codegen args;
      cache = final.ivy-gather "${codegenFiles}/${name}-ivys.nix";
    };

  # Usage:
  #
  # ```nix
  # { stdenv, mill-ivy-env-shell-hook }:
  # stdenv.mkDerivation {
  #   name = "my-mill-project";
  #
  #   shellHook = ''
  #     ${mill-ivy-env-shell-hook}
  #
  #     # extra commands
  #     # ......
  #   '';
  # }
  # ```
  #
  # Then:
  #
  # ```bash
  # $ nix develop '.#my-mill-project'
  # ```
  mill-ivy-env-shell-hook = ''
    if [[ ! -d ".git" || ! -f "build.mill" ]]; then
      echo "Not in mill project root, exit" >&2
      exit 1
    fi

    mkdir -p out
    NIX_BUILD_TOP="$(realpath out)"

    runHook preUnpack
    runHook postUnpack
  '';
}
