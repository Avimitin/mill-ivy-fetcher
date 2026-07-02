package in.avimit.dev.mif

import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.ServerSocket
import java.net.Socket
import java.net.SocketException
import java.nio.charset.StandardCharsets
import java.util.concurrent.atomic.AtomicBoolean
import utest._

object RelayTests extends TestSuite:
  private val sampleSegments = Seq(
    "com",
    "example",
    "foo",
    "1.0.0",
    "foo-1.0.0.pom"
  )
  private val sampleMavenPath = "com/example/foo/1.0.0/foo-1.0.0.pom"

  private def withLocalUpstream[T](
      mavenPath: String,
      content: Array[Byte]
  )(runTest: String => T): T =
    val server = ServerSocket(0)
    val running = AtomicBoolean(true)
    val thread =
      Thread(() => serveRequests(server, running, mavenPath, content))
    thread.setDaemon(true)
    thread.start()

    try runTest(s"http://127.0.0.1:${server.getLocalPort}/")
    finally
      running.set(false)
      server.close()
      thread.join(1000)

  private def serveRequests(
      server: ServerSocket,
      running: AtomicBoolean,
      mavenPath: String,
      content: Array[Byte]
  ): Unit =
    while running.get do
      try handleRequest(server.accept(), mavenPath, content)
      catch case _: SocketException if !running.get => ()

  private def handleRequest(
      socket: Socket,
      mavenPath: String,
      content: Array[Byte]
  ): Unit =
    try
      val input = BufferedReader(
        InputStreamReader(socket.getInputStream, StandardCharsets.ISO_8859_1)
      )
      val requestLine = input.readLine()
      var headerLine = input.readLine()
      while headerLine != null && headerLine.nonEmpty do
        headerLine = input.readLine()

      val parts = Option(requestLine).getOrElse("GET / HTTP/1.1").split(" ")
      val method = parts.lift(0).getOrElse("GET")
      val path = parts.lift(1).getOrElse("/")
      val found = path == s"/${mavenPath}"
      val body =
        if found then content else "missing".getBytes(StandardCharsets.UTF_8)
      val status = if found then "200 OK" else "404 Not Found"
      val output = socket.getOutputStream

      writeAscii(output, s"HTTP/1.1 ${status}\r\n")
      writeAscii(output, "Content-Type: application/xml\r\n")
      writeAscii(output, s"Content-Length: ${body.length}\r\n")
      writeAscii(output, "Connection: close\r\n")
      writeAscii(output, "\r\n")
      if method != "HEAD" then output.write(body)
      output.flush()
    finally socket.close()

  private def writeAscii(output: java.io.OutputStream, text: String): Unit =
    output.write(text.getBytes(StandardCharsets.ISO_8859_1))

  private def newService(config: MavenRelayConfig): MavenRelayService =
    MavenRelayService.fromConfig(config) match
      case Right(service) => service
      case Left(reason)   => throw new java.lang.AssertionError(reason)

  private def openStore(repoDir: os.Path): MavenRepositoryStore =
    MavenRepositoryStore.open(repoDir) match
      case Right(store) => store
      case Left(reason) => throw new java.lang.AssertionError(reason)

  private def repositorySnapshot(repoDir: os.Path): Seq[MavenRepositoryFile] =
    val store = openStore(repoDir)
    try
      store.snapshot() match
        case Right(files) => files
        case Left(reason) => throw new java.lang.AssertionError(reason)
    finally store.close()

  private def freePort(): Int =
    val socket = ServerSocket(0)
    try socket.getLocalPort
    finally socket.close()

  private def headerValues(
      response: requests.Response,
      name: String
  ): Seq[String] =
    response.headers.toSeq
      .collect:
        case (headerName, values) if headerName.equalsIgnoreCase(name) =>
          values
      .flatten

  private def relayBodyBytes(body: RelayBody): Array[Byte] =
    body match
      case RelayBody.Empty        => Array.emptyByteArray
      case RelayBody.Bytes(bytes) => bytes
      case RelayBody.File(path)   => os.read.bytes(path)

  val tests = Tests {
    test("MavenPath accepts repository-relative Maven paths") {
      assert(MavenPath.fromSegments(sampleSegments) == Right(sampleMavenPath))
    }

    test("MavenPath rejects unsafe path segments") {
      assert(MavenPath.fromSegments(Seq.empty).isLeft)
      assert(MavenPath.fromSegments(Seq("com", "..", "foo.pom")).isLeft)
      assert(MavenPath.fromSegments(Seq("com/example", "foo.pom")).isLeft)
      assert(MavenPath.fromSegments(Seq("com", "", "foo.pom")).isLeft)
      assert(MavenPath.fromSegments(Seq("com", "foo\nbar.pom")).isLeft)
    }

    test("upstream validation rejects unsafe or ambiguous base URLs") {
      assert(
        MavenUpstream
          .validate("https://repo1.maven.org/maven2")
          .map(_.toString) == Right("https://repo1.maven.org/maven2/")
      )
      assert(MavenUpstream.validate("file:///tmp/repository").isLeft)
      assert(
        MavenUpstream
          .validate("https://user:password@example.com/maven2")
          .isLeft
      )
      assert(
        MavenUpstream.validate("https://example.com/maven2?token=secret").isLeft
      )
    }

    test("proxy validation accepts only explicit HTTP proxy URLs") {
      assert(
        MavenProxy
          .validate("http://127.0.0.1:8080")
          .map(_.toString) == Right("http://127.0.0.1:8080")
      )
      assert(MavenProxy.validate("https://127.0.0.1:8080").isLeft)
      assert(MavenProxy.validate("http://user:password@127.0.0.1:8080").isLeft)
      assert(MavenProxy.validate("http://127.0.0.1").isLeft)
      assert(MavenProxy.validate("http://127.0.0.1:8080/proxy").isLeft)
    }

    test("repository store records files") {
      val tempDir = os.temp.dir(prefix = "mif-repository-store-test_")
      val repoDir = tempDir / "repository"
      val store1 = openStore(repoDir)
      val store2 = openStore(repoDir)

      try
        val fileA = MavenRepositoryFile(
          mavenPath = "com/example/a/1.0.0/a-1.0.0.pom",
          sha256 = "sha256-a",
          size = 1,
          contentType = "application/xml",
          upstreamUrl = Some("https://repo.example/a")
        )
        val fileB = MavenRepositoryFile(
          mavenPath = "com/example/b/1.0.0/b-1.0.0.pom",
          sha256 = "sha256-b",
          size = 2,
          contentType = "application/xml",
          upstreamUrl = Some("https://repo.example/b")
        )

        assert(store1.record(fileA) == Right(()))
        assert(store2.record(fileB) == Right(()))
        assert(store1.find(fileA.mavenPath) == Right(Some(fileA)))
        assert(
          store1.find("com/example/missing/1.0.0/missing.pom") == Right(None)
        )
      finally
        store1.close()
        store2.close()

      val files = repositorySnapshot(repoDir)
      assert(
        files.map(_.mavenPath) == Seq(
          "com/example/a/1.0.0/a-1.0.0.pom",
          "com/example/b/1.0.0/b-1.0.0.pom"
        )
      )

      assert(files.forall(_.sha256.startsWith("sha256-")))
      assert(
        files.map(_.upstreamUrl) == Seq(
          Some("https://repo.example/a"),
          Some("https://repo.example/b")
        )
      )
    }

    test("route decorator rejects unsupported artifact methods") {
      Logger.withLevel(LogLevel.Quiet) {
        val tempDir = os.temp.dir(prefix = "mif-relay-test_")
        val config = MavenRelayConfig(
          repoDir = tempDir / "repository",
          upstreamBaseUrl = MavenRelayServer.DefaultUpstream,
          connectTimeoutSeconds = 1,
          requestTimeoutSeconds = 1
        )
        val handle =
          MavenRelayServer.start("127.0.0.1", freePort(), config) match
            case Right(handle) => handle
            case Left(reason)  => throw new java.lang.AssertionError(reason)

        try
          val response = requests.post(
            s"${handle.baseUrl}${sampleMavenPath}",
            check = false
          )
          assert(response.statusCode == 405)
          assert(headerValues(response, "Allow") == Seq("GET, HEAD"))
        finally handle.close()
      }
    }

    test("GET ignores untracked local artifact and fetches upstream") {
      Logger.withLevel(LogLevel.Quiet) {
        val localContent = "<project>local-only</project>"
          .getBytes(StandardCharsets.UTF_8)
        val upstreamContent = "<project>upstream</project>"
          .getBytes(StandardCharsets.UTF_8)

        withLocalUpstream(sampleMavenPath, upstreamContent) { upstreamBaseUrl =>
          val tempDir = os.temp.dir(prefix = "mif-relay-test_")
          val repoDir = tempDir / "repository"
          val artifact = repoDir / os.RelPath(sampleMavenPath)

          os.makeDir.all(artifact / os.up)
          os.write(artifact, localContent)

          val service = newService(
            MavenRelayConfig(
              repoDir = repoDir,
              upstreamBaseUrl = upstreamBaseUrl,
              connectTimeoutSeconds = 1,
              requestTimeoutSeconds = 1
            )
          )

          try
            val response = service.handle("GET", sampleSegments)
            assert(response.statusCode == 200)
            assert(relayBodyBytes(response.body).sameElements(upstreamContent))
            assert(os.read.bytes(artifact).sameElements(upstreamContent))

            val files = repositorySnapshot(repoDir)
            assert(files.size == 1)
            assert(files.head.mavenPath == sampleMavenPath)
            assert(files.head.sha256.startsWith("sha256-"))
            assert(files.head.size == upstreamContent.length.toLong)
            assert(files.head.contentType == "application/xml")
            assert(
              files.head.upstreamUrl == Some(
                s"${upstreamBaseUrl}${sampleMavenPath}"
              )
            )
          finally service.close()
        }
      }
    }

    test("GET fetches missing artifact from upstream and records it") {
      Logger.withLevel(LogLevel.Quiet) {
        val content =
          "<project>upstream</project>".getBytes(StandardCharsets.UTF_8)
        withLocalUpstream(sampleMavenPath, content) { upstreamBaseUrl =>
          val tempDir = os.temp.dir(prefix = "mif-relay-test_")
          val repoDir = tempDir / "repository"
          val service = newService(
            MavenRelayConfig(
              repoDir = repoDir,
              upstreamBaseUrl = upstreamBaseUrl,
              connectTimeoutSeconds = 1,
              requestTimeoutSeconds = 1
            )
          )

          try
            val upstreamHead = service.handle("HEAD", sampleSegments)
            assert(upstreamHead.statusCode == 200)
            assert(upstreamHead.body == RelayBody.Empty)
            assert(
              upstreamHead.headers.contains(
                "Content-Length" -> content.length.toString
              )
            )

            val response = service.handle("GET", sampleSegments)
            assert(response.statusCode == 200)
            assert(relayBodyBytes(response.body).sameElements(content))
            assert(
              os.read
                .bytes(repoDir / os.RelPath(sampleMavenPath))
                .sameElements(content)
            )

            val files = repositorySnapshot(repoDir)
            assert(files.size == 1)
            assert(files.head.mavenPath == sampleMavenPath)
            assert(files.head.size == content.length.toLong)
            assert(
              files.head.upstreamUrl == Some(
                s"${upstreamBaseUrl}${sampleMavenPath}"
              )
            )

            val cachedHead = service.handle("HEAD", sampleSegments)
            assert(cachedHead.statusCode == 200)
            assert(cachedHead.body == RelayBody.Empty)
            assert(
              cachedHead.headers.contains(
                "Content-Length" -> content.length.toString
              )
            )
          finally service.close()
        }
      }
    }

    test("GET and HEAD delete cached artifacts that differ from the database") {
      Logger.withLevel(LogLevel.Quiet) {
        val content = "<project>upstream</project>"
          .getBytes(StandardCharsets.UTF_8)
        val corruptedContent = "<project>corrupted</project>"
          .getBytes(StandardCharsets.UTF_8)

        withLocalUpstream(sampleMavenPath, content) { upstreamBaseUrl =>
          val tempDir = os.temp.dir(prefix = "mif-relay-test_")
          val repoDir = tempDir / "repository"
          val artifact = repoDir / os.RelPath(sampleMavenPath)
          val service = newService(
            MavenRelayConfig(
              repoDir = repoDir,
              upstreamBaseUrl = upstreamBaseUrl,
              connectTimeoutSeconds = 1,
              requestTimeoutSeconds = 1
            )
          )

          try
            val initialResponse = service.handle("GET", sampleSegments)
            assert(initialResponse.statusCode == 200)
            assert(relayBodyBytes(initialResponse.body).sameElements(content))

            os.write.over(artifact, corruptedContent)

            val repairedGet = service.handle("GET", sampleSegments)
            assert(repairedGet.statusCode == 200)
            assert(relayBodyBytes(repairedGet.body).sameElements(content))
            assert(os.read.bytes(artifact).sameElements(content))

            os.write.over(artifact, corruptedContent)

            val repairedHead = service.handle("HEAD", sampleSegments)
            assert(repairedHead.statusCode == 200)
            assert(repairedHead.body == RelayBody.Empty)
            assert(
              repairedHead.headers.contains(
                "Content-Length" -> content.length.toString
              )
            )
            assert(!os.exists(artifact))
          finally service.close()
        }
      }
    }
  }
