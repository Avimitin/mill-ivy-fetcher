{
  makeSetupHook,
  add-determinism,
  writeScript,
}:
makeSetupHook { name = "add-determinism-hook"; } (
  writeScript "run-add-determinism" ''
    #!@shell@
    addDeterminismToJar() {
      echo "replacing normalized data in JAR"
      export SOURCE_DATE_EPOCH=1669810380
      find "$out" -type f -name '*.jar' \
        -exec ${add-determinism}/bin/add-determinism -j $NIX_BUILD_CORES '{}' ';'
    }
    postFixupHooks+=(addDeterminismToJar)
  ''
)
