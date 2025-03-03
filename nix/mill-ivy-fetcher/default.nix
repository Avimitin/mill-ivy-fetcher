{ python3
, runCommand
}:
let
  self = runCommand "build-mill-ivy-fetcher"
    {
      propagatedBuildInputs = [ python3 ];
      meta.mainProgram = "mill_ivy_fetcher";
    } ''
    mkdir -p "$out/bin"
    cp ${../../mill_ivy_fetcher.py} "$out/bin/mill_ivy_fetcher"
    patchShebangs --host "$out/bin"
  '';
in
self
