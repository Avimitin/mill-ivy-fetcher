package in.avimit.dev.mif

object NixNarHash {
  def run(
      files: Seq[os.Path]
  ): Map[os.Path, String] = {
    files
      .map(p => {
        Logger.info(s"Hashing ${p}")

        val sha256 = os
          .proc(
            "nix",
            "--extra-experimental-features",
            "nix-command",
            "hash",
            "path",
            "--sri",
            "--algo",
            "sha256",
            "--mode",
            "nar",
            p.toString
          )
          .call()
          .out
          .trim()
        (p, sha256)
      })
      .toMap
  }
}
