package in.avimit.dev.mif

import mainargs.{Leftover, ParserForMethods, main}
import utest._

object CliTests extends TestSuite {
  object ParserFixture:
    @main
    def archive(command: Leftover[String]): Seq[String] = command.value

    @main
    def version(): String = "test"

  val tests = Tests {
    test("version command outputs version") {
      assert(MillIvyFetcher.VERSION == "0.3.0")
    }

    test("archive command accepts build command as leftover arguments") {
      val result = ParserForMethods(ParserFixture).runEither(
        Seq("archive", "--", "mill", "run", "--", "--app-flag")
      )

      assert(result == Right(Seq("--", "mill", "run", "--", "--app-flag")))
      assert(
        MillIvyFetcher.archiveCommandArgs(
          Leftover("--", "mill", "run", "--", "--app-flag")
        ) == Seq("mill", "run", "--", "--app-flag")
      )
      assert(
        MillIvyFetcher.archiveCommandArgs(
          Leftover("--", "mill", "bad\narg", "__.compile", "bad\u0000arg")
        ) == Seq("mill", "__.compile")
      )
      assert(
        MillIvyFetcher
          .archiveCommandArgs(
            Leftover("--", "bad\narg", "bad\u0000arg")
          )
          .isEmpty
      )
      assert(
        ParserForMethods(ParserFixture).runEither(Seq("archive")) == Right(
          Seq()
        )
      )
    }
  }
}
