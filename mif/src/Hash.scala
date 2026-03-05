package in.avimit.dev.mif

object NixNarHash {
  def run(
      files: Seq[os.Path]
  ): Map[os.Path, String] = {
    val total = files.size
    files.zipWithIndex.map { case (p, idx) =>
      Logger.info(s"[${idx + 1}/${total}] Hashing ${p}")

      val sha256 = ProcessRunner
        .run(
          Seq(
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
        )
        .out
      (p, sha256)
    }.toMap
  }
}
