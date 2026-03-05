package in.avimit.dev.mif

import utest._

object CliTests extends TestSuite {
  val tests = Tests {
    test("version command outputs version") {
      assert(MillIvyFetcher.VERSION == "0.3.0")
    }
  }
}
