from mill_ivy_fetcher import *
import unittest
from pathlib import Path
import tomllib


class TestLocalCoursierRepo(unittest.TestCase):
    def test_repo_init(self):
        repo = LocalCoursierRepo()
        self.assertIsNotNone(repo._coursier_dir)
        home_dir = os.getenv("MILL_HOME")
        if home_dir is None:
            home_dir = Path.home()
        self.assertEqual(
            repo._coursier_dir, os.path.join(home_dir, ".cache", "coursier")
        )
        tomllib.loads(repo.to_nvfetcher_cfg_file())


class TestPom(unittest.TestCase):
    def test_pom_init(self):
        pom = Pom(
            "./assets/.cache/coursier/v1/https/repo1.maven.org/maven2/de/tototec/de.tobiasroeser.mill.vcs.version_mill0.11_2.13/0.4.0/de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.pom",
            "./assets/.cache/coursier",
        )
        self.assertEqual(
            pom.last_name, "de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0"
        )
        self.assertEqual(
            pom._install_path,
            "v1/https/repo1.maven.org/maven2/de/tototec/de.tobiasroeser.mill.vcs.version_mill0.11_2.13/0.4.0",
        )
        self.assertEqual(pom.group_id, "de.tototec")
        self.assertEqual(pom.version, "0.4.0")
        self.assertEqual(
            pom.artifact_id, "de.tobiasroeser.mill.vcs.version_mill0.11_2.13"
        )
        self.assertEqual(
            pom.to_maven(".jar"),
            "https://repo1.maven.org/maven2/de/tototec/de.tobiasroeser.mill.vcs.version_mill0.11_2.13/0.4.0/de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.jar",
        )
        obj = tomllib.loads(pom.to_nvfetcher_cfg())
        self.assertGreater(len(obj), 1)


class TestPomSearcher(unittest.TestCase):
    def test_search(self):
        root = PomSearcher("./assets/.cache/coursier")
        self.assertEqual(
            next(root),
            "./assets/.cache/coursier/v1/https/repo1.maven.org/maven2/de/tototec/de.tobiasroeser.mill.vcs.version_mill0.11_2.13/0.4.0/de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.pom",
        )
        self.assertRaises(StopIteration, lambda: next(root))


if __name__ == "__main__":
    unittest.main()
