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

        def extract(p: os.Path) = {
          val installPath = p.segments.dropWhile(_ != "https").mkString("/")
          val url = installPath.replace("https/", "https://")
          val filename = p.last
          (os.RelPath(installPath), url, filename)
        }

        val (installPath, pomUrl, pomFilename) =
          os.walk(depPath).filter(_.ext == "pom").map(extract).head
        def generateDownloadScript(indent: Int) = os
          .walk(depPath)
          .filter(p => !(p.ext == "pom"))
          .map(extract)
          .map { case (_, url, filename) =>
            s"""
              |downloadedFile=$$TMPDIR/${filename}
              |tryDownload "${url}"
              |cp -v "$$TMPDIR/${filename}" "$$out/"
              |""".stripMargin.indent(indent)
          }
          .mkString("\n")

        s"""
        |  "${nixName}" = fetchurl {
        |    name = "${nixName}";
        |    hash = "${sha256}";
        |    url = "${pomUrl}";
        |    recursiveHash = true;
        |    downloadToTemp = true;
        |    postFetch = ''
        |      mkdir -p "$$out"
        |      cp -v "$$downloadedFile" "$$out/${pomFilename}"
        |      ${generateDownloadScript("      ".length())}
        |    '';
        |    passthru.installPath = "${installPath / os.up}";
        |  };
        |""".stripMargin
      }

    os.write.over(
      codegenPath,
      s"""|{ fetchurl }: {
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
