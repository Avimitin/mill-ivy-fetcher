package in.avimit.dev.mif

import utest._

object SandboxTests extends TestSuite:
  private val home = os.Path("/tmp/mif-test-home")

  val tests = Tests {
    test("SandboxMode parses the documented values") {
      assert(SandboxMode.parse("bwrap") == Right(SandboxMode.Bwrap))
      assert(SandboxMode.parse("none") == Right(SandboxMode.Disabled))
      assert(SandboxMode.parse("BWRAP") == Right(SandboxMode.Bwrap))
      assert(
        SandboxMode.parse("chroot").left.exists(_.contains("bwrap, none"))
      )
    }

    test("BuildTools detects mill from any invocation shape") {
      assert(BuildTools.detect(Seq("mill", "__.compile")) == Right(MillSupport))
      assert(BuildTools.detect(Seq("./mill")) == Right(MillSupport))
      assert(
        BuildTools.detect(Seq("/nix/store/abc/bin/mill")) == Right(MillSupport)
      )
      assert(
        BuildTools
          .detect(Seq("gradle", "build"))
          .left
          .exists(reason =>
            reason.contains("gradle") && reason.contains("mill")
          )
      )
      assert(
        BuildTools
          .detect(Seq.empty)
          .left
          .exists(_.contains("missing build command"))
      )
    }

    test("MillSupport warns about daemon reuse") {
      val tempDir = os.temp.dir(prefix = "mif-sandbox-test_")

      val noFlag =
        MillSupport.preflightWarnings(tempDir, Seq("mill", "__.compile"))
      assert(noFlag.exists(_.contains("--no-daemon")))

      for flag <- Seq("-i", "--interactive", "--no-daemon", "--no-server") do
        val warnings =
          MillSupport.preflightWarnings(
            tempDir,
            Seq("mill", flag, "__.compile")
          )
        assert(warnings.isEmpty)

      os.makeDir.all(tempDir / "out" / "mill-daemon")
      val stale =
        MillSupport.preflightWarnings(tempDir, Seq("mill", "-i", "__.compile"))
      assert(stale.exists(_.contains("mill shutdown")))
    }

    test("CoursierMirror mirrors both central aliases to the relay") {
      val rendered = CoursierMirror.properties(
        "https://repo1.maven.org/maven2",
        "http://127.0.0.1:43217/"
      )
      val golden =
        """mif0.from=https://repo1.maven.org/maven2
          |mif0.to=http://127.0.0.1:43217
          |mif1.from=https://repo.maven.apache.org/maven2
          |mif1.to=http://127.0.0.1:43217
          |""".stripMargin
      assert(rendered == Right(golden))

      val aliased = CoursierMirror.properties(
        "https://repo.maven.apache.org/maven2/",
        "http://127.0.0.1:43217"
      )
      assert(
        aliased == Right(
          golden.replaceFirst(
            "mif0.from=https://repo1.maven.org/maven2",
            "mif0.from=https://repo1.maven.org/maven2"
          )
        )
      )

      val custom = CoursierMirror.properties(
        "https://nexus.example.com/maven2/",
        "http://127.0.0.1:43217"
      )
      assert(
        custom == Right(
          "mif0.from=https://nexus.example.com/maven2\nmif0.to=http://127.0.0.1:43217\n"
        )
      )

      assert(
        CoursierMirror.properties("not a url", "http://127.0.0.1:1").isLeft
      )
    }

    test("SandboxEnv builds a minimal bwrap environment") {
      val parent = Map(
        "PATH" -> "/nix/store/tools/bin:/run/current-system/sw/bin",
        "TERM" -> "xterm-256color",
        "LANG" -> "en_US.UTF-8",
        "JAVA_HOME" -> "/nix/store/jdk",
        "COURSIER_CACHE" -> "/home/user/.cache/coursier",
        "COURSIER_MIRRORS" -> "/home/user/mirror.properties",
        "JAVA_TOOL_OPTIONS" -> "-Xmx1g",
        "SECRET_TOKEN" -> "do-not-leak"
      )
      val (env, warnings) = SandboxEnv.buildBwrap(parent, home)

      assert(env("HOME") == SandboxEnv.bwrapHome.toString)
      assert(env("PATH") == parent("PATH"))
      assert(env("JAVA_HOME") == "/nix/store/jdk")
      assert(!env.contains("TERM"))
      assert(!env.contains("LANG"))
      assert(!env.contains("XDG_CACHE_HOME"))
      assert(!env.contains("XDG_CONFIG_HOME"))
      assert(!env.contains("XDG_DATA_HOME"))
      assert(!env.contains("COURSIER_CACHE"))
      assert(!env.contains("COURSIER_CONFIG_DIR"))
      assert(!env.contains("COURSIER_MIRRORS"))
      assert(!env.contains("SECRET_TOKEN"))

      val toolOptions = env("JAVA_TOOL_OPTIONS")
      assert(toolOptions == s"-Duser.home=${SandboxEnv.bwrapHome}")
      assert(!toolOptions.contains("-Dcoursier.cache="))
      assert(!toolOptions.contains("-Dcoursier.config-dir="))
      assert(!toolOptions.contains("-Dcoursier.mirrors="))
      assert(!toolOptions.contains("-Dcoursier.ivy.home="))
      assert(!toolOptions.contains("-Divy.home="))
      assert(!toolOptions.contains("-Xmx1g"))

      assert(warnings.exists(_.contains("COURSIER_CACHE")))
      assert(warnings.exists(_.contains("COURSIER_MIRRORS")))
      assert(warnings.exists(_.contains("JAVA_TOOL_OPTIONS")))
      assert(!warnings.exists(_.contains("SECRET_TOKEN")))
    }

    test("SandboxEnv builds an explicit env-only environment") {
      val parent = Map(
        "PATH" -> "/nix/store/tools/bin:/run/current-system/sw/bin",
        "TERM" -> "xterm-256color",
        "LANG" -> "en_US.UTF-8",
        "JAVA_HOME" -> "/nix/store/jdk"
      )
      val (env, warnings) = SandboxEnv.buildCleanEnv(parent, home)

      assert(env("HOME") == home.toString)
      assert(env("PATH") == parent("PATH"))
      assert(env("TERM") == "xterm-256color")
      assert(env("LANG") == "en_US.UTF-8")
      assert(env("JAVA_HOME") == "/nix/store/jdk")
      assert(env("XDG_CACHE_HOME") == (home / ".cache").toString)
      assert(env("XDG_CONFIG_HOME") == (home / ".config").toString)
      assert(env("XDG_DATA_HOME") == (home / ".local" / "share").toString)
      assert(env("COURSIER_CACHE") == (home / ".cache" / "coursier").toString)
      assert(
        env("COURSIER_MIRRORS") ==
          (home / ".config" / "coursier" / "mirror.properties").toString
      )
      assert(warnings.isEmpty)
    }

    test("SandboxEnv inherits PATH only when the host provides it") {
      val (env, warnings) = SandboxEnv.buildBwrap(Map.empty, home)
      assert(!env.contains("PATH"))
      assert(warnings.isEmpty)
    }

    test("SandboxEnv quotes java options containing spaces") {
      val spacedHome = os.Path("/tmp/mif test home")
      val options = SandboxEnv.javaToolOptions(spacedHome)
      assert(options.contains("\"-Duser.home=/tmp/mif test home\""))
    }

    test("BubblewrapSandbox argv has load-bearing mount ordering") {
      val projectDir = os.Path("/home/user/project")
      val sandboxHome = os.Path("/tmp/mif-archive-home-x")
      val spec = BubblewrapSandbox.Spec(
        projectDir = projectDir,
        sandboxHome = sandboxHome,
        env = Map("HOME" -> SandboxEnv.bwrapHome.toString, "PATH" -> "/bin"),
        command = Seq("mill", "-i", "__.prepareOffline")
      )

      val golden = Seq(
        "bwrap",
        "--die-with-parent",
        "--unshare-pid",
        "--tmpfs",
        "/",
        "--dir",
        "/bin",
        "--ro-bind-try",
        "/bin",
        "/bin",
        "--dir",
        "/lib",
        "--ro-bind-try",
        "/lib",
        "/lib",
        "--dir",
        "/lib64",
        "--ro-bind-try",
        "/lib64",
        "/lib64",
        "--dir",
        "/usr",
        "--ro-bind-try",
        "/usr",
        "/usr",
        "--dir",
        "/nix",
        "--ro-bind-try",
        "/nix/store",
        "/nix/store",
        "--dir",
        "/run",
        "--dir",
        "/run/current-system",
        "--ro-bind-try",
        "/run/current-system/sw",
        "/run/current-system/sw",
        "--dir",
        "/etc",
        "--ro-bind-try",
        "/etc/ssl",
        "/etc/ssl",
        "--ro-bind-try",
        "/etc/pki",
        "/etc/pki",
        "--dev",
        "/dev",
        "--proc",
        "/proc",
        "--dir",
        "/tmp",
        "--bind",
        "/home/user/project",
        "/workdir",
        "--bind",
        "/tmp/mif-archive-home-x",
        "/mif",
        "--chdir",
        "/workdir",
        "--clearenv",
        "--setenv",
        "HOME",
        "/mif",
        "--setenv",
        "PATH",
        "/bin",
        "--",
        "mill",
        "-i",
        "__.prepareOffline"
      )
      assert(BubblewrapSandbox.argv(spec) == golden)
    }

    test("SandboxStrategy requires bwrap unless none is explicit") {
      val probeOk = () => Right(())
      val probeFail = () => Left("bwrap: setting up uid map: Permission denied")

      assert(
        SandboxStrategy.resolve(SandboxMode.Bwrap, isLinux = true, probeOk) ==
          Right(SandboxStrategy.Bwrap)
      )

      val bwrapFail =
        SandboxStrategy.resolve(SandboxMode.Bwrap, isLinux = true, probeFail)
      assert(
        bwrapFail.left.exists(reason =>
          reason.contains("uid map") && reason.contains("--sandbox none")
        )
      )

      val darwinBwrap =
        SandboxStrategy.resolve(SandboxMode.Bwrap, isLinux = false, probeOk)
      assert(
        darwinBwrap.left.exists(reason =>
          reason.contains("requires Linux") && reason.contains("--sandbox none")
        )
      )

      val disabled =
        SandboxStrategy.resolve(SandboxMode.Disabled, isLinux = true, probeFail)
      disabled match
        case Right(SandboxStrategy.CleanEnvOnly(reasons)) =>
          assert(reasons.exists(_.contains("without filesystem isolation")))
        case other => assert(false)
    }
  }
