import os
from os.path import basename
import subprocess
from urllib import parse as urlparse
import xml.etree.ElementTree as ET
import toml


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


POM_XMLNS = {"pom": "http://maven.apache.org/POM/4.0.0"}


class Pom:
    _tree: ET.ElementTree
    _pom_path: str
    group_id: str
    artifact_id: str
    description: str
    version: str
    jar_name: str

    def __init__(self, pom_path: str) -> None:
        self._pom_path = pom_path
        self._tree = ET.parse(self._pom_path)
        self.jar_name = basename(self._pom_path).strip(".pom") + ".jar"
        self.group_id = self._get_str(
            "groupId", "pom:groupId", "pom:parent/pom:groupId"
        )
        self.artifact_id = self._get_str("artifactId", "pom:artifactId")
        self.description = self._get_str(
            "description", "pom:description", fallback=self.artifact_id
        )
        self.version = self._get_str("version", "pom:version", "pom:parent/pom:version")

    def _get_str(
        self,
        *paths,
        fallback: str | None = None,
    ) -> str:
        element: ET.Element | str | None = None
        valid = None
        for p in paths:
            element = self._tree.find(p, POM_XMLNS)
            if element is not None:
                valid = p
                break

        if element is None:
            if fallback is not None:
                element = fallback
            else:
                raise Exception(
                    f"Element {", ".join(paths)} not found for {self._pom_path}"
                )

        if isinstance(element, ET.Element):
            element = element.text
            if element is None:
                raise Exception(
                    f"Element {valid} is not string value in {self._pom_path}"
                )

        return element

    def to_maven(self) -> str:
        segment = os.path.join(
            "maven2",
            self.group_id.replace(".", "/"),
            self.artifact_id,
            self.version,
            self.jar_name,
        )
        return urlparse.urljoin("https://repo1.maven.org", segment)

    def to_nvfetcher_key(self) -> str:
        key = {
            self.artifact_id: {
                "src": {"manual": self.version},
                "fetch": {"url": self.to_maven(), "force": True},
                "passthru": {"description": self.description},
            }
        }
        return toml.dumps(key)


class LocalCoursierRepo:
    _coursier_dir: str | None = None
    _pom_xmlns = "{http://maven.apache.org/POM/4.0.0}"

    def __init__(self) -> None:
        self.find_repo_roots()

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

    def to_nvfetcher_key_file(self) -> str:
        assert self._coursier_dir is not None
        return "\n\n".join(
            [Pom(f).to_nvfetcher_key() for f in PomSearcher(self._coursier_dir)]
        )


if __name__ == "__main__":
    print(LocalCoursierRepo().to_nvfetcher_key_file())
