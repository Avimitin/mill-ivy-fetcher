final: prev: {
  millVersions = final.callPackage ./mill-versions.nix { };

  mkMavenRepository = final.callPackage ./mill-ivy-fetcher/maven-repository.nix { };

  addDeterminismHook = final.callPackage ./mill-ivy-fetcher/add-determinism-hook.nix { };
}
