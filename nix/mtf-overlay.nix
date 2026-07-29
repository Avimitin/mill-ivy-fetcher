final: prev: {
  millVersions = final.callPackage ./mill-versions.nix { };

  mkMavenRepository = final.callPackage ./mvn-trace-forge/maven-repository.nix { };

  addDeterminismHook = final.callPackage ./mvn-trace-forge/add-determinism-hook.nix { };
}
