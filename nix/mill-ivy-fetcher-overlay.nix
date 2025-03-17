final: prev:
{
  mill-ivy-fetcher = final.callPackage ./mill-ivy-fetcher/package.nix { };

  /**
    Each Ivy dependencies will contains one or more files: the publish JAR file
    and the POM specification file. All those files are download separately to
    make nix-prefetch-file happy. This function can help group files to Ivy
    recognizable dependencies layout by reading the generated nix lock file.
    Returning a derivation containing the ivy cache.


    # Inputs

    `nvfetcherNixSourcePath`
    : 1\. Function argument

    # Type

    ```
    ivy-gather :: path -> set
    ```

    # Examples
    :::{.example}
    ## `ivy-gather` usage example

    ```nix
    ivy-gather ./codegenFiles/project-ivys.nix
    => <derivation>
    ```

    :::
  */
  ivy-gather = final.callPackage ./mill-ivy-fetcher/ivy-gather.nix { };

  /**
    ivy-codegen could help generate nix expression for downloading all
    dependencies a project needed from maven.

    # Inputs

    `args`
    : 1\. Function argument

    # Type

    ```
    ivy-codegen :: set -> <derivation>
    ```

    # Examples
    :::{.example}
    ## `ivy-codegen` usage example

    ```nix
    ivy-codegen {
      name = "project-name";
      src = path/to/project;
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      extraBuildInputs = [];
    }
    => <derivation>
    ```

    :::
  */
  ivy-codegen = final.callPackage ./mill-ivy-fetcher/ivy-codegen.nix { inherit (final) mill-ivy-fetcher; };

  /**
    generateIvyCache is a helper function to eliminate the need to know how
    ivy-gather and ivy-codegen works together.

    # Inputs

    `args`
    : 1\. Function argument, same as ivy-codegen

    # Type

    ```
    generateIvyCache :: set -> set
    ```

    # Examples
    :::{.example}
    ## `generateIvyCache` usage example

    ```nix
    generateIvyCache {
      name = "project-name";
      src = path/to/project;
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      extraBuildInputs = [];
    }
    => {
      codegenFiles = <derivation-for-lock-file>;
      cache = <derivation-to-ivy-cache>;
    }
    ```

    :::
  */
  generateIvyCache = { name, ... }@args:
    rec {
      codegenFiles = final.ivy-codegen args;
      cache = final.ivy-gather "${codegenFiles}/${name}-mill-lock.nix";
    };

  /**
    mill-ivy-env-shell-hook call all the setupHook and do extra post

    # Type

    ```
    mill-ivy-env-shell-hook :: string
    ```

    # Examples
    :::{.example}
    ## `mill-ivy-env-shell-hook` usage example

    ```nix
    { stdenv, mill-ivy-env-shell-hook }:
    stdenv.mkDerivation {
      name = "my-mill-project";

      shellHook = ''
        ${mill-ivy-env-shell-hook}

        # extra commands
        mill -i mill.bsp.BSP/install
      '';
    }
    ```

    Then:

    ```bash
    $ nix develop '.#my-mill-project'
    ```

    :::
  */
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

  /**
    publishMillJar is a helper function to run `.publishLocal` for a mill module.
    Returning the ivy repo as result.

    # Inputs

    `args`
    : 1\. Function argument

    # Type

    ```
    publishMillJar :: set -> <derivation>
    ```

    # Examples
    :::{.example}
    ## `publishMillJar` usage example

    ```nix
    { lib, runCommand, mill, generateIvyCache, publishMillJar }:
    let
      src = with lib.fileset; toSource {
        root = ./.;
        fileset = unions [
          ./build.mill
          ./foo
        ];
      };

      ivyCache = generateIvyCache {
        name = "foo-deps";
        inherit src;
        hash = "sha256-7GQe62dGnSmTm3apResF3jEnwyvDMpRxjTZTJkby/1E=";
        targets = [ "foo" ];
      };
    in
    publishMillJar {
      name = "foo";
      inherit src;

      publishTargets = [
        "foo"
      ];

      buildInputs = [ ivyCache ];

      passthru = {
        inherit ivyCache;
      };
    }
    ```

    :::
  */
  publishMillJar = final.callPackage ./mill-ivy-fetcher/publish-mill-jar.nix { };

  configure-mill-env-hook = final.callPackage ./mill-ivy-fetcher/configure-mill-env.nix { };
}
