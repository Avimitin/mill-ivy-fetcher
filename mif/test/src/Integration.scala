package in.avimit.dev.mif

import utest._

object IntegrationTest extends TestSuite {
  val demoProject = sys.env("DEMO_PROJECT_DIR")
  val p = MillIvyFetcher.fetch(demoProject, Seq())

  def tests = Tests {
    test("fetch") {
      assert(os.walk(p).filter(_.ext == "pom").nonEmpty)
    }

    test("codegen-project") {
      val param = CodegenParams(p / os.up)
      val generator = new Codegen(param)
      val deps = generator.getAllDependencies()
      println(deps)
      assert(deps.nonEmpty)
      assert(deps.foldLeft(true)((prev, cur) => {
        prev && (!cur.contains("mill-internal"))
      }))
    }
  }
}
