package in.avimit.dev.mif

import utest._

object LoggerTests extends TestSuite {
  val tests = Tests {
    test("fatal throws FatalException") {
      Logger.withLevel(LogLevel.Quiet) {
        val ex = intercept[FatalException] {
          Logger.fatal("test error")
        }
        assert(ex.getMessage == "test error")
      }
    }
  }
}
