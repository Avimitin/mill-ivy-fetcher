from mill_ivy_fetcher import *
import unittest
from pathlib import Path


class TestFetcher(unittest.TestCase):
    def test_repo_init(self):
        repo = LocalCoursierRepo()
        self.assertIsNotNone(repo._coursier_dir)
        home_dir = Path.home()
        self.assertEqual(
            repo._coursier_dir, os.path.join(home_dir, ".cache", "coursier")
        )
        self.assertGreater(len(repo._jar_urls), 0)


class TestPom(unittest.TestCase):
    def test_pom_init(self):
        pom = Pom("./assets/de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.pom")
        self.assertEqual(
            pom.jar_name, "de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.jar"
        )
        self.assertEqual(pom.group_id, "de.tototec")
        self.assertEqual(pom.version, "0.4.0")
        self.assertEqual(
            pom.artifact_id, "de.tobiasroeser.mill.vcs.version_mill0.11_2.13"
        )
        self.assertEqual(
            pom.description,
            "Mill plugin to derive a version from (last) git tag and edit state",
        )
        self.assertEqual(
            pom.to_maven(),
            "https://repo1.maven.org/maven2/de/tototec/de.tobiasroeser.mill.vcs.version_mill0.11_2.13/0.4.0/de.tobiasroeser.mill.vcs.version_mill0.11_2.13-0.4.0.jar",
        )


if __name__ == "__main__":
    unittest.main()
