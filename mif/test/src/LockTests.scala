package in.avimit.dev.mif

import utest._

object LockTests extends TestSuite:
  private val central =
    Lock.repositoryFor(MavenRelayServer.DefaultUpstream) match
      case Right(repository) => repository
      case Left(reason)      => throw new java.lang.AssertionError(reason)

  private val prepareRun =
    LockRun.fromCommand(Seq("mill", "-i", "__.prepareOffline"))
  private val assemblyRun =
    LockRun.fromCommand(Seq("mill", "-i", "foo.assembly"))

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

  val tests = Tests {
    test("run ids are stable across machines and dedupe identical commands") {
      assert(prepareRun.id == "8f34a28c1e61")
      assert(assemblyRun.id == "ef8e57c5498e")
      assert(
        LockRun.idFor(Seq("mill", "-i", "__.prepareOffline")) == prepareRun.id
      )
      assert(LockRun.idFor(Seq("mill -i __.prepareOffline")) != prepareRun.id)
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
      val jar = repoFile("com/example/foo/1.0.0/foo-1.0.0.jar", size = 49512)
      val pom = repoFile("com/example/foo/1.0.0/foo-1.0.0.pom", size = 1207)
      val lock =
        unwrap(Lock.merge(Lock.empty, central, Seq(jar, pom), prepareRun))

      val golden =
        s"""{
           |  "version": 1,
           |  "kind": "mif-maven-lock",
           |  "repositories": [
           |    {
           |      "id": "central",
           |      "type": "maven",
           |      "url": "https://repo1.maven.org/maven2"
           |    }
           |  ],
           |  "runs": [
           |    {
           |      "id": "8f34a28c1e61",
           |      "command": [
           |        "mill",
           |        "-i",
           |        "__.prepareOffline"
           |      ]
           |    }
           |  ],
           |  "files": [
           |    {
           |      "repository": "central",
           |      "mavenPath": "com/example/foo/1.0.0/foo-1.0.0.jar",
           |      "sha256": "${jar.sha256}",
           |      "size": 49512,
           |      "runs": [
           |        "8f34a28c1e61"
           |      ]
           |    },
           |    {
           |      "repository": "central",
           |      "mavenPath": "com/example/foo/1.0.0/foo-1.0.0.pom",
           |      "sha256": "${pom.sha256}",
           |      "size": 1207,
           |      "runs": [
           |        "8f34a28c1e61"
           |      ]
           |    }
           |  ]
           |}
           |""".stripMargin

      val rendered = Lock.render(lock)
      assert(rendered == golden)
    }

    test("render is deterministic under input reordering") {
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")
      val forward =
        unwrap(Lock.merge(Lock.empty, central, Seq(fileA, fileB), prepareRun))
      val backward =
        unwrap(Lock.merge(Lock.empty, central, Seq(fileB, fileA), prepareRun))
      assert(Lock.render(forward) == Lock.render(backward))
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
      val run = LockRun.fromCommand(command)
      val lock = unwrap(
        Lock.merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          run
        )
      )
      val reparsed = unwrap(Lock.parse(Lock.render(lock)))
      assert(reparsed == lock)
      assert(reparsed.runs.head.command == command.toVector)
    }

    test("parse rejects malformed JSON and schema violations") {
      val base = unwrap(
        Lock.merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          prepareRun
        )
      )

      assert(Lock.parse("not json").isLeft)
      assert(Lock.parse("""{"version":1}""").isLeft)

      def renderWith(change: MifLock => MifLock): String =
        Lock.render(change(base))

      val badVersion = Lock.parse(renderWith(_.copy(version = 2)))
      assert(badVersion.left.exists(_.contains("unsupported lock version")))

      val badKind = Lock.parse(renderWith(_.copy(kind = "other-lock")))
      assert(badKind.left.exists(_.contains("unsupported lock kind")))

      val badSha = Lock.parse(
        renderWith(lock =>
          lock.copy(files = lock.files.map(_.copy(sha256 = "abc123")))
        )
      )
      assert(badSha.left.exists(_.contains("invalid sha256")))

      val badPath = Lock.parse(
        renderWith(lock =>
          lock.copy(files = lock.files.map(_.copy(mavenPath = "com/../a.pom")))
        )
      )
      assert(badPath.left.exists(_.contains("invalid maven path")))

      val badRepository = Lock.parse(
        renderWith(lock =>
          lock.copy(files = lock.files.map(_.copy(repository = "missing")))
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

      val duplicatePath = Lock.parse(
        renderWith(lock => lock.copy(files = lock.files ++ lock.files))
      )
      assert(duplicatePath.left.exists(_.contains("duplicate lock entry")))

      val duplicateRun = Lock.parse(
        renderWith(lock => lock.copy(runs = lock.runs ++ lock.runs))
      )
      assert(duplicateRun.left.exists(_.contains("duplicate run id")))
    }

    test("read returns None for a missing lock file") {
      val tempDir = os.temp.dir(prefix = "mif-lock-test_")
      assert(Lock.read(tempDir / "mif.lock.json") == Right(None))
    }

    test("write is atomic and round-trips through read") {
      val tempDir = os.temp.dir(prefix = "mif-lock-test_")
      val lockPath = tempDir / "nested" / "mif.lock.json"
      val lock = unwrap(
        Lock.merge(
          Lock.empty,
          central,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          prepareRun
        )
      )

      assert(Lock.write(lockPath, lock) == Right(()))
      assert(Lock.read(lockPath) == Right(Some(lock)))

      val updated = unwrap(
        Lock.merge(
          lock,
          central,
          Seq(repoFile("com/example/b/1.0.0/b-1.0.0.pom")),
          assemblyRun
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
        unwrap(Lock.merge(Lock.empty, central, Seq(fileA, fileB), prepareRun))
      val second =
        unwrap(Lock.merge(first, central, Seq(fileB, fileC), assemblyRun))

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
      val once = unwrap(Lock.merge(Lock.empty, central, files, prepareRun))
      val twice = unwrap(Lock.merge(once, central, files, prepareRun))
      assert(Lock.render(once) == Lock.render(twice))
    }

    test("merge reports every content conflict and keeps the lock untouched") {
      val fileA = repoFile("com/example/a/1.0.0/a-1.0.0.pom")
      val fileB = repoFile("com/example/b/1.0.0/b-1.0.0.pom")
      val existing =
        unwrap(Lock.merge(Lock.empty, central, Seq(fileA, fileB), prepareRun))

      val mutatedA = fileA.copy(sha256 = Sha256.sri("other".getBytes("UTF-8")))
      val mutatedB = fileB.copy(size = fileB.size + 1)

      val result =
        Lock.merge(existing, central, Seq(mutatedA, mutatedB), assemblyRun)
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
        unwrap(Lock.merge(Lock.empty, central, Seq(fileA), prepareRun))
      // Same url: entry reused, no duplicate repository.
      val reused =
        unwrap(Lock.merge(first, central, Seq(fileB), assemblyRun))
      assert(reused.repositories == first.repositories)

      // Different url wanting the same id: suffixed instead of clobbered.
      val suffixed = unwrap(Lock.merge(first, mirror, Seq(fileB), assemblyRun))
      assert(
        suffixed.repositories.map(_.id) == Vector("central", "central-2")
      )
      val byPath = suffixed.files.map(file => file.mavenPath -> file).toMap
      assert(byPath(fileB.mavenPath).repository == "central-2")
    }
  }
