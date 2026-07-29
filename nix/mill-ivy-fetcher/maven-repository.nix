{
  cacert,
  curl,
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

      hasSchema = (lock.version or null) == 3 && (lock.kind or null) == "mif-maven-lock";

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

      fetchMavenArtifact =
        dir: artifact:
        let
          repositoryUrl = artifactRepositoryUrl artifact;
          files = artifact.files or (throw "MIF artifact '${dir}' does not define files");
          narHash = artifact.narHash or (throw "MIF artifact '${dir}' does not define narHash");
          curlWrapper = lib.escapeShellArgs [
            (lib.getExe curl)
            "--fail"
            "--location"
            "--retry"
            "3"
            "--retry-all-errors"
            "--silent"
            "--show-error"
          ];
          downloadFiles = lib.concatMapStringsSep "\n" (
            fileName:
            let
              mavenPath = "${dir}/${fileName}";
              url = "${trimTrailingSlash repositoryUrl}/${mavenPath}";
            in
            ''
              fileName=${lib.escapeShellArg fileName}
              ${curlWrapper} \
                --output "$out/$mavenDir/$fileName" \
                ${lib.escapeShellArg url}
              chmod 0444 "$out/$mavenDir/$fileName"
            ''
          ) (builtins.attrNames files);
        in
        # Download the whole Maven coordinate in one fixed-output derivation.
        # Nix verifies the recursive NAR hash; the per-file hashes remain in the
        # lock for review and diagnostics.
        runCommand "mif-maven-artifact-${lib.strings.sanitizeDerivationName dir}"
          {
            impureEnvVars = lib.fetchers.proxyImpureEnvVars;
            SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
            outputHash = narHash;
            outputHashAlgo = "sha256";
            outputHashMode = "recursive";
            preferLocalBuild = false;
            passthru.mavenPath = dir;
          }
          ''
            mavenDir=${lib.escapeShellArg dir}
            install -d -m755 "$out/$mavenDir"
            ${downloadFiles}
          '';

      defaultArtifacts = lib.mapAttrs fetchMavenArtifact lock.artifacts;
      artifacts = defaultArtifacts // artifactOverrides;
    in
    assert lib.assertMsg hasSchema "${toString lockFile} is not a version 3 mif-maven-lock file";
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
