{
  publishMillJar,
  fetchFromGitHub,
  git,
  writeShellApplication,
  mill-ivy-fetcher,
  mill,
}:
publishMillJar rec {
  name = "chisel";

  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "chisel";
    rev = "5e0ae3f46327c9ff15898f13ea8b94bbad90f653";
    hash = "sha256-TU3AlrbWcps6zYbfLD677jfZ/UcBO1M9FcG1nb98Nhk=";
  };

  lockFile = ./chisel-lock.nix;

  publishTargets = [
    "unipublish"
  ];

  nativeBuildInputs = [
    git
  ];

  env.NIX_DEBUG = 4;

  preBuild = ''
    # Fix mill JVM version detection, use JVM version of the system
    sed -i '1i //| mill-jvm-version: system' build.mill
  '';

  passthru.bump = writeShellApplication {
    name = "bump-chisel";
    runtimeInputs = [
      mill-ivy-fetcher
      mill
    ];
    text = ''
      mif run -p "${src}" -o .github/integration/chisel-lock.nix "$@"
    '';
  };
}
