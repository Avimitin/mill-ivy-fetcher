{
  fetchurl,
  lib,
  runCommand,
  symlinkJoin,
}:

let
  mkMavenRepository =
    {
      lockFile,
      name ? "mif-maven-repository",
      ...
    }@args:
    let
      lock = builtins.fromJSON (builtins.readFile lockFile);
      artifactOverrides = builtins.removeAttrs args [
        "lockFile"
        "name"
      ];

      hasSchema = (lock.version or null) == 2 && (lock.kind or null) == "mif-maven-lock";

      trimTrailingSlash = url: lib.removeSuffix "/" url;

      artifactRunIds =
        artifact:
        let
          artifactRuns = artifact.runs or (throw "MIF artifact does not define runs");
        in
        if artifactRuns == [ ] then throw "MIF artifact has no runs" else artifactRuns;

      artifactRepository =
        artifact:
        let
          runId = builtins.head (artifactRunIds artifact);
        in
        lock.runs.${runId}.repository or (throw "unknown MIF run id '${runId}'");

      artifactRepositoryUrl =
        artifact:
        let
          repository = artifactRepository artifact;
        in
        lock.repositories.${repository} or (throw "unknown MIF repository id '${repository}'");

      fetchArtifact =
        dir: repositoryUrl: fileName: sha256:
        let
          mavenPath = "${dir}/${fileName}";
        in
        runCommand "mif-artifact-${lib.strings.sanitizeDerivationName mavenPath}"
          {
            artifact = fetchurl {
              name = baseNameOf mavenPath;
              url = "${trimTrailingSlash repositoryUrl}/${mavenPath}";
              hash = sha256;
            };
            inherit mavenPath;
            preferLocalBuild = true;
          }
          ''
            install -Dm444 "$artifact" "$out/$mavenPath"
          '';

      mkMavenArtifact =
        dir: artifact:
        let
          repositoryUrl = artifactRepositoryUrl artifact;
          files = artifact.files or (throw "MIF artifact '${dir}' does not define files");
        in
        symlinkJoin {
          name = "mif-maven-artifact-${lib.strings.sanitizeDerivationName dir}";
          paths = lib.mapAttrsToList (fetchArtifact dir repositoryUrl) files;
          passthru = {
            mavenPath = dir;
          };
        };

      defaultArtifacts = lib.mapAttrs mkMavenArtifact lock.artifacts;
      artifacts = defaultArtifacts // artifactOverrides;
    in
    assert lib.assertMsg hasSchema "${toString lockFile} is not a version 2 mif-maven-lock file";
    symlinkJoin {
      inherit name;
      paths = builtins.attrValues artifacts;
      # Install a setup hook so that adding this repository to a derivation's
      # (native)buildInputs is enough to point Coursier at it. stdenv sources
      # $out/nix-support/setup-hook automatically for every input.
      postBuild = ''
        install -Dm 555 ${./maven-repository-hook.sh} $out/nix-support/setup-hook
      '';
      passthru = {
        inherit lockFile artifacts;
        artifactPaths = builtins.attrNames artifacts;
        runCount = builtins.length (builtins.attrNames lock.runs);
      };
    };
in
lib.makeOverridable mkMavenRepository
