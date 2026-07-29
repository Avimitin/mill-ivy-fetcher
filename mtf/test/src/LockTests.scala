package in.avimit.dev.mtf

import utest._

object LockTests extends TestSuite:
  private val central =
    Lock.repositoryFor(MavenRelayServer.DefaultUpstream) match
      case Right(repository) => repository
      case Left(reason)      => throw new java.lang.AssertionError(reason)

  private val prepareCommand = Seq("mill", "-i", "__.prepareOffline")
  private val assemblyCommand = Seq("mill", "-i", "foo.assembly")
  private val prepareRun =
    LockRun.fromCommand(prepareCommand, "central")
  private val assemblyRun =
    LockRun.fromCommand(assemblyCommand, "central")

  private def repoFile(path: String, size: Long = 42): MavenRepositoryFile =
    MavenRepositoryFile(
      mavenPath = path,
      sha256 = Sha256.sri(path.getBytes("UTF-8")),
      size = size,
      contentType = "application/octet-stream",
      upstreamUrl = None
    )

  private def unwrap[T](result: Either[String, T]): T =
    result match
      case Right(value) => value
      case Left(reason) => throw new java.lang.AssertionError(reason)

  private def artifactHash(dir: String): String =
    Sha256.sri(dir.getBytes("UTF-8"))

  private def merge(
      existing: MtfLock,
      upstream: LockRepository,
      runFiles: Seq[MavenRepositoryFile],
      command: Seq[String]
  ): Either[String, MtfLock] =
    Lock
      .merge(existing, upstream, runFiles, command)
      .flatMap: lock =>
        Lock.withArtifactNarHashes(
          lock,
          Lock
            .missingArtifactNarHashes(lock)
            .map: dir =>
              dir -> artifactHash(dir)
            .toMap
        )

  val tests = Tests {
    test("run ids are stable across machines and dedupe identical commands") {
      assert(prepareRun.id == LockRun.idFor(prepareCommand, "central"))
      assert(assemblyRun.id == LockRun.idFor(assemblyCommand, "central"))
      assert(
        LockRun.idFor(prepareCommand, "central") !=
          LockRun.idFor(prepareCommand, "mirror")
      )
      assert(
        LockRun.idFor(Seq("mill -i __.prepareOffline"), "central") !=
          prepareRun.id
      )
    }

    test("repositoryFor maps central aliases to the well-known id") {
      assert(central.id == "central")
      assert(central.repoType == "maven")
      assert(central.url == "https://repo1.maven.org/maven2")
      assert(
        Lock.repositoryFor("https://repo.maven.apache.org/maven2/") ==
          Right(
            LockRepository(
              "central",
              "maven",
              "https://repo.maven.apache.org/maven2"
            )
          )
      )
      assert(
        Lock.repositoryFor("https://nexus.example.com/maven2") ==
          Right(
            LockRepository(
              "nexus-example-com",
              "maven",
              "https://nexus.example.com/maven2"
            )
          )
      )
      assert(Lock.repositoryFor("file:///tmp/repo").isLeft)
    }

    test("render produces the golden document") {
      val jar = repoFile("com/example/foo/1.0.0/foo-1.0.0.jar")
      val pom = repoFile("com/example/foo/1.0.0/foo-1.0.0.pom")
      val lock =
        unwrap(merge(Lock.empty, central, Seq(jar, pom), prepareCommand))

      val golden =
        s"""{
           |  "version": 3,
           |  "kind": "mtf-maven-lock",
           |  "repositories": {
           |    "central": "https://repo1.maven.org/maven2"
           |  },
           |  "runs": {
           |    "${prepareRun.id}": {
           |      "repository": "central",
           |      "command": [
           |        "mill",
           |        "-i",
           |        "__.prepareOffline"
           |      ]
           |    }
           |  },
           |  "artifacts": {
           |    "com/example/foo/1.0.0": {
           |      "narHash": "${artifactHash("com/example/foo/1.0.0")}",
           |      "runs": [
           |        "${prepareRun.id}"
           |      ],
           |      "files": {
           |        "foo-1.0.0.jar": "${jar.sha256}",
           |        "foo-1.0.0.pom": "${pom.sha256}"
           |      }
           |    }
           |  }
           |}
           |""".stripMargin

      val rendered = Lock.render(lock)
      assert(rendered == golden)
    }

    test("render is deterministic under input reordering") {
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")
      val forward =
        unwrap(
          merge(Lock.empty, central, Seq(fileA, fileB), prepareCommand)
        )
      val backward =
        unwrap(
          merge(Lock.empty, central, Seq(fileB, fileA), prepareCommand)
        )
      assert(Lock.render(forward) == Lock.render(backward))
    }

    test("render keeps every run when files in an artifact differ") {
      val pom = repoFile("com/example/foo/1.0.0/foo-1.0.0.pom")
      val jar = repoFile("com/example/foo/1.0.0/foo-1.0.0.jar")
      val first =
        unwrap(merge(Lock.empty, central, Seq(pom), prepareCommand))
      val second = unwrap(merge(first, central, Seq(jar), assemblyCommand))
      val parsed = unwrap(Lock.parse(Lock.render(second)))
      val expectedRuns = Vector(prepareRun.id, assemblyRun.id).sorted

      assert(parsed.files.map(_.runs).distinct == Vector(expectedRuns))
    }

    test("parse render round-trip preserves hostile command strings") {
      val command = Seq(
        "mill",
        "-D",
        "prop=with \"quotes\" and \\backslashes\\",
        "arg with spaces",
        "#not-a-comment",
        "unicode-テスト",
        ""
      )
      val run = LockRun.fromCommand(command, "central")
      val lock = unwrap(
        merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          command
        )
      )
      val reparsed = unwrap(Lock.parse(Lock.render(lock)))
      assert(reparsed == lock)
      assert(reparsed.runs.head.command == command.toVector)
    }

    test("parse derives artifact repository from run metadata") {
      val sha = repoFile("com/example/a/1.0.0/a-1.0.0.pom").sha256
      val mirrorRun = LockRun.fromCommand(prepareCommand, "mirror")
      val json =
        s"""{
           |  "version": 3,
           |  "kind": "mtf-maven-lock",
           |  "repositories": {
           |    "central": "https://repo1.maven.org/maven2",
           |    "mirror": "https://mirror.example.com/maven2"
           |  },
           |  "runs": {
           |    "${prepareRun.id}": {
           |      "repository": "central",
           |      "command": ["mill", "-i", "__.prepareOffline"]
           |    },
           |    "${mirrorRun.id}": {
           |      "repository": "mirror",
           |      "command": ["mill", "-i", "__.prepareOffline"]
           |    }
           |  },
           |  "artifacts": {
           |    "com/example/a/1.0.0": {
           |      "narHash": "${artifactHash("com/example/a/1.0.0")}",
           |      "runs": ["${mirrorRun.id}"],
           |      "files": {
           |        "a-1.0.0.pom": "${sha}"
           |      }
           |    }
           |  }
           |}
           |""".stripMargin

      val parsed = unwrap(Lock.parse(json))
      assert(parsed.files.size == 1)
      assert(parsed.files.head.repository == "mirror")
      assert(parsed.files.head.runs == Vector(mirrorRun.id))
    }

    test("parse reports how to migrate a version 2 lock") {
      val sha = repoFile("com/example/a/1.0.0/a-1.0.0.pom").sha256
      val json =
        s"""{
           |  "version": 2,
           |  "kind": "mtf-maven-lock",
           |  "repositories": {
           |    "central": "https://repo1.maven.org/maven2"
           |  },
           |  "runs": {
           |    "${prepareRun.id}": {
           |      "repository": "central",
           |      "command": ["mill", "-i", "__.prepareOffline"]
           |    }
           |  },
           |  "artifacts": {
           |    "com/example/a/1.0.0": {
           |      "runs": ["${prepareRun.id}"],
           |      "files": {
           |        "a-1.0.0.pom": "${sha}"
           |      }
           |    }
           |  }
           |}
           |""".stripMargin

      val result = Lock.parse(json)
      assert(result.left.exists(_.contains("unsupported lock version 2")))
      assert(
        result.left.exists(_.contains("complete archive command sequence"))
      )
      assert(
        result.left.exists(_.contains("--fresh on the first command only"))
      )
    }

    test("parse rejects malformed JSON and schema violations") {
      val base = unwrap(
        merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          prepareCommand
        )
      )

      assert(Lock.parse("not json").isLeft)
      assert(Lock.parse("""{"version":1}""").isLeft)

      def renderWith(change: MtfLock => MtfLock): String =
        Lock.render(change(base))

      val badVersion = Lock.parse(renderWith(_.copy(version = 1)))
      assert(badVersion.left.exists(_.contains("unsupported lock version")))

      val badKind = Lock.parse(renderWith(_.copy(kind = "other-lock")))
      assert(badKind.left.exists(_.contains("unsupported lock kind")))

      val badSha = Lock.parse(
        renderWith(lock =>
          lock.copy(files = lock.files.map(_.copy(sha256 = "abc123")))
        )
      )
      assert(badSha.left.exists(_.contains("invalid sha256")))

      val badNarHash = Lock.parse(
        renderWith(lock =>
          lock.copy(artifactNarHashes =
            lock.artifactNarHashes.view.mapValues(_ => "abc123").toMap
          )
        )
      )
      assert(badNarHash.left.exists(_.contains("invalid narHash")))

      val badPath = Lock.parse(
        renderWith(lock =>
          lock.copy(
            files = lock.files.map(_.copy(mavenPath = "com/../a.pom")),
            artifactNarHashes = Map("com/.." -> artifactHash("com/.."))
          )
        )
      )
      assert(badPath.left.exists(_.contains("invalid maven path")))

      val badRepository = Lock.parse(
        renderWith(lock =>
          lock.copy(runs = lock.runs.map(_.copy(repository = "missing")))
        )
      )
      assert(badRepository.left.exists(_.contains("unknown repository")))

      val badRunRef = Lock.parse(
        renderWith(lock =>
          lock.copy(files =
            lock.files.map(_.copy(runs = Vector("000000000000")))
          )
        )
      )
      assert(badRunRef.left.exists(_.contains("unknown run ids")))

      val badRun = Lock.parse(
        renderWith(lock =>
          lock.copy(runs = lock.runs.map(_.copy(id = "not-a-run")))
        )
      )
      assert(badRun.left.exists(_.contains("12 character hex identifier")))
    }

    test("read returns None for a missing lock file") {
      val tempDir = os.temp.dir(prefix = "mtf-lock-test_")
      assert(Lock.read(tempDir / "mtf.lock.json") == Right(None))
    }

    test("write is atomic and round-trips through read") {
      val tempDir = os.temp.dir(prefix = "mtf-lock-test_")
      val lockPath = tempDir / "nested" / "mtf.lock.json"
      val lock = unwrap(
        merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          prepareCommand
        )
      )

      assert(Lock.write(lockPath, lock) == Right(()))
      assert(Lock.read(lockPath) == Right(Some(lock)))

      val updated = unwrap(
        merge(
          lock,
          central,
          Seq(repoFile("com/example/b/1.0.0/b-1.0.0.pom")),
          assemblyCommand
        )
      )
      assert(Lock.write(lockPath, updated) == Right(()))
      assert(Lock.read(lockPath) == Right(Some(updated)))

      val residue = os.list(lockPath / os.up).filter(_.last.endsWith(".tmp"))
      assert(residue.isEmpty)
    }

    test("merge appends while preserving files absent from the run") {
      // Fresh-clone scenario: the lock already tracks A and B from a
      // teammate's run; a local run only exercises B and C.
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")
      val fileC = repoFile("com/example/c/1.0.0/c-1.0.0.pom")

      val first =
        unwrap(
          merge(Lock.empty, central, Seq(fileA, fileB), prepareCommand)
        )
      val second =
        unwrap(merge(first, central, Seq(fileB, fileC), assemblyCommand))

      assert(
        second.files.map(_.mavenPath) == Vector(
          fileA.mavenPath,
          fileB.mavenPath,
          fileC.mavenPath
        )
      )
      assert(second.runs.map(_.id) == Vector(prepareRun.id, assemblyRun.id))

      val byPath = second.files.map(file => file.mavenPath -> file).toMap
      assert(byPath(fileA.mavenPath).runs == Vector(prepareRun.id))
      assert(
        byPath(fileB.mavenPath).runs ==
          Vector(prepareRun.id, assemblyRun.id).sorted
      )
      assert(byPath(fileC.mavenPath).runs == Vector(assemblyRun.id))
    }

    test("merge of the same run twice is a no-op") {
      val files = Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom"))
      val once = unwrap(merge(Lock.empty, central, files, prepareCommand))
      val twice = unwrap(merge(once, central, files, prepareCommand))
      assert(Lock.render(once) == Lock.render(twice))
    }

    test("merge reuses narHash until an artifact's contents change") {
      val pom = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val jar = repoFile("com/example/a/1.0.0/a-1.0.0.jar")
      val artifactDir = "com/example/a/1.0.0"
      val first = unwrap(merge(Lock.empty, central, Seq(pom), prepareCommand))

      val metadataOnly = unwrap(
        Lock.merge(first, central, Seq(pom), assemblyCommand)
      )
      assert(metadataOnly.artifactNarHashes == first.artifactNarHashes)
      assert(Lock.missingArtifactNarHashes(metadataOnly).isEmpty)

      val expanded = unwrap(
        Lock.merge(first, central, Seq(pom, jar), assemblyCommand)
      )
      assert(!expanded.artifactNarHashes.contains(artifactDir))
      assert(Lock.missingArtifactNarHashes(expanded) == Vector(artifactDir))
    }

    test("merge reports every content conflict and keeps the lock untouched") {
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")
      val existing =
        unwrap(
          merge(Lock.empty, central, Seq(fileA, fileB), prepareCommand)
        )

      val mutatedA = fileA.copy(sha256 = Sha256.sri("other".getBytes("UTF-8")))
      val mutatedB =
        fileB.copy(sha256 = Sha256.sri("other-b".getBytes("UTF-8")))

      val result =
        merge(existing, central, Seq(mutatedA, mutatedB), assemblyCommand)
      result match
        case Right(_) => assert(false)
        case Left(reason) =>
          assert(reason.contains("2 path(s)"))
          assert(reason.contains(fileA.mavenPath))
          assert(reason.contains(fileB.mavenPath))
          assert(reason.contains("--fresh"))
    }

    test("merge reuses repository ids by url and suffixes collisions") {
      val mirror =
        LockRepository("central", "maven", "https://mirror.example.com/maven2")
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")

      val first =
        unwrap(merge(Lock.empty, central, Seq(fileA), prepareCommand))
      // Same url: entry reused, no duplicate repository.
      val reused =
        unwrap(merge(first, central, Seq(fileB), assemblyCommand))
      assert(reused.repositories == first.repositories)

      // Different url wanting the same id: suffixed instead of clobbered.
      val suffixed =
        unwrap(merge(first, mirror, Seq(fileB), assemblyCommand))
      assert(
        suffixed.repositories.map(_.id) == Vector("central", "central-2")
      )
      val byPath = suffixed.files.map(file => file.mavenPath -> file).toMap
      assert(byPath(fileB.mavenPath).repository == "central-2")
    }
  }
