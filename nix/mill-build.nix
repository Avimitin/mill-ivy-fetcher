{
  autoPatchelfHook,
  fetchurl,
  jre,
  lib,
  makeWrapper,
  stdenvNoCC,
  zlib,
  runtimeShell,
  wrapperScript ? ./mill-wrapper.sh,
  versionInfo,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mill";
  inherit (versionInfo) version;

  src =
    let
      suffix = lib.optionalString (versionInfo ? artifact-suffix) versionInfo.artifact-suffix;
      filename =
        with lib.versions;
        with lib.strings;
        let
          v = finalAttrs.version;
        in
        if (major v) == "1" || ((majorMinor v) == "0.12" && (toInt (patch v)) >= 14) then
          "mill-dist${suffix}-${finalAttrs.version}.exe"
        else
          "mill-dist-${finalAttrs.version}.jar";
      url =
        if versionInfo ? alt-url then
          versionInfo.alt-url
        else
          "https://repo1.maven.org/maven2/com/lihaoyi/mill-dist${suffix}/${finalAttrs.version}/${filename}";
    in
    fetchurl {
      inherit url;
      inherit (versionInfo) hash;
    };

  buildInputs = [ zlib ];
  nativeBuildInputs = [
    makeWrapper
  ]
  ++ lib.optional stdenvNoCC.hostPlatform.isLinux autoPatchelfHook;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  # this is mostly downloading a pre-built artifact
  preferLocal = true;

  passthru = { inherit jre; };

  installPhase = ''
    runHook preInstall

    install -Dm 555 $src $out/bin/.mill-bin

    substitute ${wrapperScript} $out/bin/mill \
      --replace-fail '@shell@' '${runtimeShell}' \
      --replace-fail '@system_jre@' '${jre}' \
      --replace-fail '@mill_bin@' '.mill-bin'
    chmod --reference=$out/bin/.mill-bin $out/bin/mill

    runHook postInstall
  '';

  meta = {
    homepage = "https://com-lihaoyi.github.io/mill/";
    license = lib.licenses.mit;
    description = "Build tool for Scala, Java and more";
    mainProgram = "mill";
    longDescription = ''
      Mill is a build tool borrowing ideas from modern tools like Bazel, to let you build
      your projects in a way that's simple, fast, and predictable. Mill has built in
      support for the Scala programming language, and can serve as a replacement for
      SBT, but can also be extended to support any other language or platform via
      modules (written in Java or Scala) or through an external subprocesses.
    '';
    maintainers = with lib.maintainers; [
      zenithal
    ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
