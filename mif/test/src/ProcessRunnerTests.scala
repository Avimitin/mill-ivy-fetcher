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
      intercept[FatalException] {
        ProcessRunner.run(Seq("false"))
      }
    }
  }
}
