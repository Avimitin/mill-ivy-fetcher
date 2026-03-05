package in.avimit.dev.mif

import utest._

object ValidationTests extends TestSuite {
  val tests = Tests {
    test("sanitize rejects newline in arguments") {
      intercept[FatalException] {
        ProcessRunner.run(Seq("echo", "hello\nworld"))
      }
    }

    test("sanitize rejects null byte in arguments") {
      intercept[FatalException] {
        ProcessRunner.run(Seq("echo", "hello\u0000world"))
      }
    }

    test("sanitize accepts valid arguments") {
      val result = ProcessRunner.run(Seq("echo", "hello world"))
      assert(result.out == "hello world")
    }
  }
}
