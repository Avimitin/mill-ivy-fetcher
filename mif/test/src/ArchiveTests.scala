package in.avimit.dev.mif

import utest._

object ArchiveTests extends TestSuite:
  private val upstream = MavenRelayServer.DefaultUpstream
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
    test("updateLock creates a lock from one run") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val lockPath = tempDir / "mif.lock.json"
      val files = Seq(
        repoFile("com/example/a/1.0.0/a-1.0.0.pom"),
        repoFile("com/example/a/1.0.0/a-1.0.0.jar")
      )

      val summary = unwrap(
        ArchiveRunner.updateLock(
          lockPath = lockPath,
          runFiles = files,
          upstream = upstream,
          run = prepareRun,
          fresh = false
        )
      )
      assert(summary == LockUpdateSummary(2, 2, 1))

      val lock = unwrap(Lock.read(lockPath)).get
      assert(lock.repositories.map(_.id) == Vector("central"))
      assert(lock.runs == Vector(prepareRun))
      assert(lock.files.forall(_.runs == Vector(prepareRun.id)))
    }

    test("updateLock appends a second command into the same lock") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val lockPath = tempDir / "mif.lock.json"
      val shared = repoFile("com/example/shared/1.0.0/shared-1.0.0.jar")

      val first = unwrap(
        ArchiveRunner.updateLock(
          lockPath,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom"), shared),
          upstream,
          prepareRun,
          fresh = false
        )
      )
      assert(first == LockUpdateSummary(2, 2, 1))

      val second = unwrap(
        ArchiveRunner.updateLock(
          lockPath,
          Seq(repoFile("com/example/b/1.0.0/b-1.0.0.pom"), shared),
          upstream,
          assemblyRun,
          fresh = false
        )
      )
      assert(second == LockUpdateSummary(3, 1, 2))

      val lock = unwrap(Lock.read(lockPath)).get
      val byPath = lock.files.map(file => file.mavenPath -> file).toMap
      assert(
        byPath(shared.mavenPath).runs ==
          Vector(prepareRun.id, assemblyRun.id).sorted
      )
    }

    test("updateLock records the run even when it adds no new files") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val lockPath = tempDir / "mif.lock.json"
      val files = Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom"))

      unwrap(
        ArchiveRunner.updateLock(lockPath, files, upstream, prepareRun, false)
      )
      val summary = unwrap(
        ArchiveRunner.updateLock(lockPath, files, upstream, assemblyRun, false)
      )
      assert(summary == LockUpdateSummary(1, 0, 2))

      val lock = unwrap(Lock.read(lockPath)).get
      assert(
        lock.runs.map(_.id).sorted == Vector(prepareRun, assemblyRun)
          .map(_.id)
          .sorted
      )
      assert(
        lock.files.head.runs == Vector(prepareRun.id, assemblyRun.id).sorted
      )
    }

    test("updateLock refuses conflicts and leaves the lock byte-identical") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val lockPath = tempDir / "mif.lock.json"
      val file = repoFile("com/example/a/1.0.0/a-1.0.0.pom")

      unwrap(
        ArchiveRunner.updateLock(
          lockPath,
          Seq(file),
          upstream,
          prepareRun,
          false
        )
      )
      val before = os.read(lockPath)

      val mutated = file.copy(sha256 = Sha256.sri("other".getBytes("UTF-8")))
      val result = ArchiveRunner.updateLock(
        lockPath,
        Seq(mutated),
        upstream,
        assemblyRun,
        fresh = false
      )
      assert(result.left.exists(_.contains("artifact content changed")))
      assert(os.read(lockPath) == before)
    }

    test("updateLock with fresh rebuilds the lock from this run only") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val lockPath = tempDir / "mif.lock.json"

      unwrap(
        ArchiveRunner.updateLock(
          lockPath,
          Seq(repoFile("com/example/a/1.0.0/a-1.0.0.pom")),
          upstream,
          prepareRun,
          fresh = false
        )
      )
      val summary = unwrap(
        ArchiveRunner.updateLock(
          lockPath,
          Seq(repoFile("com/example/b/1.0.0/b-1.0.0.pom")),
          upstream,
          assemblyRun,
          fresh = true
        )
      )
      assert(summary == LockUpdateSummary(1, 1, 1))

      val lock = unwrap(Lock.read(lockPath)).get
      assert(
        lock.files.map(_.mavenPath) == Vector("com/example/b/1.0.0/b-1.0.0.pom")
      )
      assert(lock.runs == Vector(assemblyRun))
    }

    test("lookupFiles resolves accessed paths through the repository store") {
      val tempDir = os.temp.dir(prefix = "mif-archive-test_")
      val repoDir = tempDir / "repository"
      val recorded = repoFile("com/example/a/1.0.0/a-1.0.0.pom")

      val store = MavenRepositoryStore.open(repoDir) match
        case Right(store) => store
        case Left(reason) => throw new java.lang.AssertionError(reason)
      try assert(store.record(recorded) == Right(()))
      finally store.close()

      assert(
        ArchiveRunner.lookupFiles(repoDir, Seq(recorded.mavenPath)) ==
          Right(Vector(recorded))
      )

      val missing = ArchiveRunner.lookupFiles(
        repoDir,
        Seq(recorded.mavenPath, "com/example/gone/1.0.0/gone-1.0.0.pom")
      )
      assert(
        missing.left.exists(_.contains("missing from the repository database"))
      )
    }
  }
