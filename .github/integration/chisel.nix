{ publishMillJar, fetchFromGitHub, git, writeShellApplication, mill-ivy-fetcher, mill }:
publishMillJar rec {
  name = "chisel";

  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "chisel";
    rev = "dd04d997dc8c74e446862040625b46604cba41a4";
    hash = "sha256-gqn1HzfxMUwNPbYiQjTO8KNmGf4ozmWwTBWdZ59GLzg=";
  };

  lockFile = ./chisel-lock.nix;

  publishTargets = [
    "unipublish"
  ];

  nativeBuildInputs = [
    git
  ];

  passthru.bump = writeShellApplication {
    name = "bump-chisel";
    runtimeInputs = [
      mill-ivy-fetcher
      mill
    ];
    text = ''
      mif run -p "${src}" -o .github/integration/chisel-lock.nix
    '';
  };
}
