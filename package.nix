{ python3
, runCommand
}:
runCommand "build-mill-ivy-fetcher" { nativeBuildInputs = [ python3 ]; meta.mainProgram = "mill_ivy_fetcher"; } ''
  mkdir -p "$out/bin"
  cp ${./mill_ivy_fetcher.py} "$out/bin/mill_ivy_fetcher"
  patchShebangs --host "$out/bin"
''
