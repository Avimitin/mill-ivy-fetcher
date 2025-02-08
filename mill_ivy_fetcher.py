import os
from os.path import basename
import subprocess
from urllib import parse as urlparse
import xml.etree.ElementTree as ET


class PomSearcher:
    def __init__(self, root: str):
        self._traverser = os.walk(root)

    def __iter__(self):
        return self

    def next_pom(self):
        root, _, files = next(self._traverser)
        for name in files:
            if name.endswith(".pom"):
                return os.path.join(root, name)

        return None

    def __next__(self):
        p = None
        while p is None:
            p = self.next_pom()

        return p


POM_XMLNS = "{http://maven.apache.org/POM/4.0.0}"


class Pom:
    _tree: ET.ElementTree
    group_id: str
    artifact_id: str
    description: str
    version: str
    jar_name: str

    def __init__(self, pom_path: str) -> None:
        self._tree = ET.parse(pom_path)
        self.jar_name = basename(pom_path).strip(".pom") + ".jar"
        self.group_id = self._get_str("groupId")
        self.artifact_id = self._get_str("artifactId")
        self.description = self._get_str("description")
        self.version = self._get_str("version")

    def _get_str(self, path: str) -> str:
        element = self._tree.find(f"{POM_XMLNS}{path}")
        if element is None:
            raise Exception(f"Element {path} not found")
        text = element.text
        if text is None:
            raise Exception(f"Element {path} is not string value")
        return text

    def to_maven(self) -> str:
        segment = os.path.join(
            "maven2",
            self.group_id.replace(".", "/"),
            self.artifact_id,
            self.version,
            self.jar_name,
        )
        return urlparse.urljoin("https://repo1.maven.org", segment)


class LocalCoursierRepo:
    _coursier_dir: str | None = None
    _jar_urls: list[str] = []
    _pom_xmlns = "{http://maven.apache.org/POM/4.0.0}"

    def __init__(self) -> None:
        self.find_repo_roots()
        self.search_poms()

    def find_repo_roots(self) -> None:
        jvav_output = subprocess.run(
            ["java", "-XshowSettings:properties", "-version"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        )
        for line in jvav_output.stdout.splitlines():
            if "user.home" in line:
                homedir = line.split("=")[1].strip()
                self._coursier_dir = os.path.join(homedir, ".cache", "coursier")
                break

    def search_poms(self) -> None:
        assert self._coursier_dir is not None

        self._jar_urls = [Pom(f).to_maven() for f in PomSearcher(self._coursier_dir)]

    def to_nix_expr(self) -> str:
        return "TODO"
