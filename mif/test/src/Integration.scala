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
      val tmpdir = os.temp.dir()
      val param = CodegenParams(p / os.up, tmpdir)

      val generator = new Codegen(param)

      val deps = generator.getAllDependencies()
      assert(deps.nonEmpty)
      assert(deps.foldLeft(true)((prev, cur) => {
        prev && (!cur.module.name.value.contains("mill-internal"))
      }))

      generator.run()
    }
  }
}
