package in.avimit.dev.mif

import utest._

object FetcherTest extends TestSuite {
  def tests = Tests {
    test("fetch-project") {
      val demoProject = sys.env("DEMO_PROJECT_DIR")
      val p = MillIvyFetcher.fetch(demoProject, Seq())
      assert(os.walk(p).filter(_.ext == "pom").nonEmpty)
    }
  }
}
