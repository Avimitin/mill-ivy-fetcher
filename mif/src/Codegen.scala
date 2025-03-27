package in.avimit.dev.mif

import coursier._
import coursier.cache.FileCache

case class CodegenParams(
    cacheDir: os.Path,
    codegenPath: os.Path
)

class Codegen(param: CodegenParams) {
  import param.*

  def getAllDependencies() = {
    os.walk(cacheDir)
      .filter(p => p.ext == "pom")
      .map(p => {
        val modulePath = p / os.up
        os.walk(modulePath)
          .filter(p => !(p.ext == "pom" || p.ext == "jar"))
          .foreach(os.remove)
        modulePath
      })
      .distinct
  }

  // TODO: upstream sha256 first, then TOFU
  def hash(
      files: Seq[os.Path]
  ): Map[os.Path, String] = {
    NixNarHash.run(files)
  }

  def pathToDeps(p: os.Path) = {
    val it = p.segments.toSeq.reverse
      .takeWhile(_ != "maven2")
    it match
      case version :: modName :: orgSlice =>
        (orgSlice.reverse.mkString("."), modName, version)
      case _ => throw new Exception("Invalid classpath")
  }

  def codegen(hashResult: Map[os.Path, String]) = {
    val expr = hashResult.toSeq
      .sortBy((p, _) => p)
      .map { case (depPath, sha256) =>
        val (org, mod, ver) = pathToDeps(depPath)

        val nixName = org + "_" + mod + "-" + ver

        val pathInfo = os
          .walk(depPath)
          .map(p => {
            val installPath = p.segments
              .dropWhile(_ != "https")
              .mkString("/")
            (installPath, installPath.replace("https/", "https://"))
          });

        require(pathInfo.nonEmpty)

        val installPath = os.RelPath(pathInfo.head._1)
        // Wrap url as Nix expr
        val urlElems = pathInfo.map((_, url) => s"\"${url}\"").mkString(" ")

        s"""
        |  "${nixName}" = fetchMaven {
        |    name = "${nixName}";
        |    urls = [ ${urlElems} ];
        |    hash = "${sha256}";
        |    installPath = "${installPath / os.up}";
        |  };
        |""".stripMargin
      }

    os.write.over(
      codegenPath,
      s"""|{ fetchurl }:
          |let
          |  fetchMaven = { name, urls, hash, installPath }: with builtins;
          |    let
          |      firstUrl = head urls;
          |      otherUrls = filter (elem: elem != firstUrl) urls;
          |    in
          |    fetchurl {
          |      inherit name hash;
          |      passthru = { inherit installPath; };
          |      url = firstUrl;
          |      recursiveHash = true;
          |      downloadToTemp = true;
          |      postFetch = ''
          |        mkdir -p "$$out"
          |        cp -v "$$downloadedFile" "$$out/$${baseNameOf firstUrl}"
          |      '' + concatStringsSep "\\n"
          |        (map
          |          (elem:
          |            let filename = baseNameOf elem; in ''
          |              downloadedFile=$$TMPDIR/$${filename}
          |              tryDownload $${elem}
          |              cp -v "$$TMPDIR/$${filename}" "$$out/"
          |            '')
          |          otherUrls);
          |    };
          |in
          |{
          |${expr.mkString}
          |}
          |""".stripMargin
    )
  }

  def run() = {
    val deps = getAllDependencies()

    if deps.isEmpty then
      Logger.fatal(
        s"No pom file found in ${cacheDir}"
      )

    val hashes = hash(deps)
    codegen(hashes)
  }
}
