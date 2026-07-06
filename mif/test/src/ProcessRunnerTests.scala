package in.avimit.dev.mif

import utest._

object ProcessRunnerTests extends TestSuite {
  val tests = Tests {
    test("run executes command successfully") {
      val result = ProcessRunner.run(Seq("echo", "hello"))
      assert(result.out == "hello")
      assert(result.exitCode == 0)
    }

    test("run throws FatalException on command failure") {
      Logger.withLevel(LogLevel.Quiet) {
        intercept[FatalException] {
          ProcessRunner.run(Seq("false"))
        }
        ()
      }
    }

    test("runStreaming returns the exit code as a value") {
      assert(ProcessRunner.runStreaming(Seq("true"), cwd = os.pwd) == Right(0))
      assert(
        ProcessRunner.runStreaming(
          Seq("sh", "-c", "exit 3"),
          cwd = os.pwd
        ) == Right(3)
      )
    }

    test("runStreaming returns Left when the command cannot start") {
      val result = ProcessRunner.runStreaming(
        Seq("mif-no-such-binary-for-tests"),
        cwd = os.pwd
      )
      assert(result.isLeft)
    }

    test("runStreaming rejects arguments with newline or null byte") {
      val result = ProcessRunner.runStreaming(
        Seq("echo", "bad\narg"),
        cwd = os.pwd
      )
      assert(result.isLeft)
    }

    test("runStreaming with propagateEnv=false gives the child only env") {
      // Probe with HOME rather than PATH: shells substitute a default PATH
      // when it is unset, but they never invent a HOME.
      val scrubbedHome = ProcessRunner.runStreaming(
        Seq("/bin/sh", "-c", "test -z \"$HOME\""),
        cwd = os.pwd,
        env = Map.empty,
        propagateEnv = false
      )
      assert(scrubbedHome == Right(0))

      val markerVisible = ProcessRunner.runStreaming(
        Seq("/bin/sh", "-c", "test \"$MIF_TEST_MARKER\" = yes"),
        cwd = os.pwd,
        env = Map("MIF_TEST_MARKER" -> "yes"),
        propagateEnv = false
      )
      assert(markerVisible == Right(0))

      val inheritedPath = ProcessRunner.runStreaming(
        Seq("/bin/sh", "-c", "test -n \"$PATH\""),
        cwd = os.pwd
      )
      assert(inheritedPath == Right(0))
    }
  }
}
