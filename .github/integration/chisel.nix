{ publishMillJar, fetchFromGitHub, git }:
publishMillJar {
  name = "chisel";

  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "chisel";
    rev = "cf353ccfcc754e797d9a2d8858fea8d4cbaac961";
    hash = "sha256-btUKSaB5EYKGaOWVIw8Rr4vKTcbKRx4My8WIkL+aXy0=";
  };

  lockFile = ./chisel-lock.nix;

  publishTargets = [
    "unipublish"
  ];

  nativeBuildInputs = [
    git
  ];
}
