package in.avimit.dev.mif

import utest._

object ArtifactNarHashTests extends TestSuite:
  private val run = LockRun.fromCommand(
    Seq("mill", "--no-daemon", "__.prepareOffline"),
    "central"
  )

  private def lockedFile(path: String): LockedFile =
    LockedFile(
      repository = "central",
      mavenPath = path,
      sha256 = Sha256.sri(path.getBytes("UTF-8")),
      runs = Vector(run.id)
    )

  private def lock(files: Vector[LockedFile]): MifLock =
    MifLock(
      version = Lock.Version,
      kind = Lock.Kind,
      repositories = Vector(
        LockRepository(
          "central",
          "maven",
          MavenRelayServer.DefaultUpstream
        )
      ),
      runs = Vector(run),
      files = files
    )

  private def unwrap[T](result: Either[String, T]): T =
    result match
      case Right(value) => value
      case Left(reason) => throw new java.lang.AssertionError(reason)

  private def writeRepositoryFile(
      repoDir: os.Path,
      path: String,
      content: String
  ): Unit =
    val destination = repoDir / os.RelPath(path)
    os.makeDir.all(destination / os.up)
    os.write(destination, content)

  private def nixHash(path: os.Path): String =
    os.proc(
      "nix",
      "hash",
      "path",
      "--mode",
      "nar",
      "--algo",
      "sha256",
      "--format",
      "sri",
      path
    ).call()
      .out
      .trim()

  val tests = Tests {
    test("hashMissing produces the NAR of each exact Maven subtree") {
      val tempDir = os.temp.dir(prefix = "mif-nar-hash-test_")
      val repoDir = tempDir / "repository"
      val jarPath = "com/example/a/1.0.0/a-1.0.0.jar"
      val pomPath = "com/example/a/1.0.0/a-1.0.0.pom"
      val otherPath = "com/example/b/2.0.0/b-2.0.0.pom"
      writeRepositoryFile(repoDir, jarPath, "jar")
      writeRepositoryFile(repoDir, pomPath, "pom")
      writeRepositoryFile(repoDir, otherPath, "other")

      val hashes = unwrap(
        ArtifactNarHash.hashMissing(
          repoDir,
          lock(
            Vector(
              lockedFile(jarPath),
              lockedFile(pomPath),
              lockedFile(otherPath)
            )
          )
        )
      )

      val expectedA = tempDir / "expected-a"
      writeRepositoryFile(expectedA, jarPath, "jar")
      writeRepositoryFile(expectedA, pomPath, "pom")
      val expectedB = tempDir / "expected-b"
      writeRepositoryFile(expectedB, otherPath, "other")

      assert(hashes("com/example/a/1.0.0") == nixHash(expectedA))
      assert(hashes("com/example/b/2.0.0") == nixHash(expectedB))
      assert(
        os.list(repoDir / MavenRepositoryStore.MetadataDirectoryName)
          .forall(!_.last.startsWith(".nar-hash-"))
      )
    }

    test("hashMissing skips finalized artifacts") {
      val tempDir = os.temp.dir(prefix = "mif-nar-hash-test_")
      val repoDir = tempDir / "repository"
      val path = "com/example/a/1.0.0/a-1.0.0.pom"
      val pending = lock(Vector(lockedFile(path)))
      val finalized = unwrap(
        Lock.withArtifactNarHashes(
          pending,
          Map("com/example/a/1.0.0" -> Sha256.sri("nar".getBytes("UTF-8")))
        )
      )

      assert(
        ArtifactNarHash.hashMissing(repoDir, finalized) == Right(Map.empty)
      )
    }

    test("hashMissing reports a locked file absent from the relay cache") {
      val tempDir = os.temp.dir(prefix = "mif-nar-hash-test_")
      val repoDir = tempDir / "repository"
      val path = "com/example/a/1.0.0/a-1.0.0.pom"

      val result = ArtifactNarHash.hashMissing(
        repoDir,
        lock(Vector(lockedFile(path)))
      )
      assert(result.left.exists(_.contains(path)))
      assert(result.left.exists(_.contains("missing")))
    }
  }
