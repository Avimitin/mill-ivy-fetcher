#!/usr/bin/env python3

import os
from os.path import basename
import subprocess
from urllib import parse as urlparse
import xml.etree.ElementTree as ET
import toml
import argparse
import logging
from logging import info, error
import tempfile


class PomSearcher:
    def __init__(self, root: str):
        self._traverser = os.walk(root)

    def __iter__(self):
        return self

    def next_pom(self) -> str | None:
        root, _, files = next(self._traverser)
        for name in files:
            if name.endswith(".pom"):
                return os.path.join(root, name)

        return None

    def __next__(self) -> str:
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
        unique_name = self.artifact_id + "-" + self.version
        key = {
            unique_name: {
                "src": {"manual": self.version},
                "fetch": {"url": self.to_maven(), "force": True},
                "passthru": {"description": self.description},
            }
        }
        return toml.dumps(key)


class LocalCoursierRepo:
    _coursier_dir: str | None = None
    _pom_xmlns = "{http://maven.apache.org/POM/4.0.0}"

    def __init__(self, coursier_dir: str | None = None) -> None:
        if coursier_dir is None:
            self.find_repo_roots()
        else:
            self._coursier_dir = coursier_dir

        if self._coursier_dir is None:
            raise Exception("No coursier directory was found or given")

        if not os.path.exists(self._coursier_dir):
            raise Exception(f"No such directory '{self._coursier_dir}'")

        info(f"Searching in {self._coursier_dir}")

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


def mill_prepare_offline(
    prepare_targets: list[str],
    user_home: str | None = None,
    extra_java_opts: list[str] | None = None,
) -> str:
    home_dir = user_home or tempfile.gettempdir()
    mill_opt_file = tempfile.mktemp()

    java_opt = f"-Duser.home={home_dir} "
    if extra_java_opts is not None:
        java_opt += " ".join(extra_java_opts)

    with open(mill_opt_file, "w") as mf:
        mf.write(java_opt.replace(" ", "\n"))

    subprocess.check_call(
        ["mill", "-i"] + [target + ".prepareOffline" for target in prepare_targets],
        env={
            # Java doens't respect $HOME, we need to change the user.home property
            "JAVA_OPTS": java_opt,
            # Maven mirror sometime contains invalid dependency and make us hard to debug the problem, use maven central only.
            "COURSIER_REPOSITORIES": "ivy2local|central",
            # Mill will fork process without inherit the JAVA_OPTS env, so we need "MILL JVM OPT" file to help us modify home dir.
            "MILL_JVM_OPTS_PATH": mill_opt_file,
        },
    )
    return os.path.join(home_dir, ".cache", "coursier")


def fetch_handler(args):
    mill_prepare_offline(
        args.targets or ["__"],
        args.home,
        args.java_opts,
    )


def dump_handler(args):
    try:
        repo = LocalCoursierRepo(args.coursier_dir)
        content = repo.to_nvfetcher_key_file()
        dp = args.dump_path
        if dp is None:
            print(content)
        else:
            with open(dp, "w") as f:
                f.write(content)
    except Exception as inst:
        error(inst)
        exit(1)


if __name__ == "__main__":
    logging.basicConfig(format="[%(levelname)s] %(message)s")

    parser = argparse.ArgumentParser(
        prog="mill-ivy-fetcher", usage="%(prog)s [options]"
    )
    subparser = parser.add_subparsers(required=True)
    dump_parser = subparser.add_parser("dump", help="%(prog)s dump help")
    dump_parser.add_argument(
        "-c",
        "--coursier-dir",
        nargs="?",
        help="Use other path instead of ~/.cache/coursier to search poms",
    )
    dump_parser.add_argument(
        "-d",
        "--dump-path",
        nargs="?",
        help="Path to dump final key file instead of printing to stdout",
    )
    dump_parser.set_defaults(func=dump_handler)

    fetch_parser = subparser.add_parser("fetch", help="%(prog)s fetch help")
    fetch_parser.add_argument(
        "-o",
        "--home",
        nargs="?",
        help="Use the specify directory as HOME directory, default using temporary directory",
    )
    fetch_parser.add_argument(
        "-j",
        "--java-opts",
        action="append",
        help="Set custom Java options. Can be used multiple time to append options.",
    )
    fetch_parser.add_argument(
        "-t",
        "--targets",
        action="append",
        help="Set custom object target to fetch Ivy dependencies. Can be used multiple time to append options.",
    )
    fetch_parser.set_defaults(func=fetch_handler)

    args = parser.parse_args()
    args.func(args)
