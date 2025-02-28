#!/usr/bin/env python3

import os
from os.path import basename
import subprocess
from urllib import parse as urlparse
import textwrap
import xml.etree.ElementTree as ET
import argparse
import shutil
import logging
from logging import info, warning, error
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

        assert p != ""
        return p


POM_XMLNS = {"pom": "http://maven.apache.org/POM/4.0.0"}


class Pom:
    _tree: ET.ElementTree
    _pom_path: str
    _install_path: str
    _uniq_name: str
    group_id: str
    artifact_id: str
    description: str
    packaging: str
    version: str
    last_name: str

    def __init__(self, pom_path: str, root_dir: str) -> None:
        self._pom_path = pom_path
        self._install_path = os.path.dirname(os.path.relpath(pom_path, root_dir))
        self._tree = ET.parse(self._pom_path)
        self.packaging = self._get_str("packaging", "pom:packaging", fallback="jar")
        self.last_name = basename(self._pom_path).removesuffix(".pom")
        self.group_id = self._get_str(
            "groupId", "pom:groupId", "pom:parent/pom:groupId"
        )
        self.artifact_id = self._get_str("artifactId", "pom:artifactId")
        self.version = self._get_str("version", "pom:version", "pom:parent/pom:version")
        self._uniq_name = f"{self.artifact_id}-{self.version}".strip()

    def _guess_suffix(self) -> str:
        match self.packaging:
            case "bundle":
                return ".jar"
            case "so":
                return ".jar"
            case ext:
                return "." + ext

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

    def to_maven(self, suffix: str) -> str:
        segment = os.path.join(
            "maven2",
            self.group_id.replace(".", "/"),
            self.artifact_id,
            self.version,
            self.last_name + suffix,
        )
        return urlparse.urljoin("https://repo1.maven.org", segment)

    def to_nvfetcher_cfg(self) -> str:
        unique_name = self._uniq_name
        safe_ver = self.version.strip()
        suffix = self._guess_suffix()
        is_pom = "pom" in suffix
        bundle_url = self.to_maven(suffix)
        pom_url = self.to_maven(".pom")
        safe_pkgname = self.artifact_id.strip()

        def optional_str(expr: bool, s: str):
            return s if expr else ""

        def to_nvfetcher_raw(name: str, url: str):
            return textwrap.dedent(
                f"""\
        ["{name}"]
        src.manual = "{safe_ver}"
        fetch.url = "{url}"
        fetch.force = true
        passthru.pkgname = "{safe_pkgname}"
        passthru.install_path = "{self._install_path}"
        """
            )

        return to_nvfetcher_raw(
            f"{unique_name}-pom",
            pom_url,
        ) + optional_str(
            not is_pom, to_nvfetcher_raw(f"{unique_name}-bundle", bundle_url)
        )


class LocalCoursierRepo:
    _coursier_dir: str | None = None

    def __init__(self, coursier_dir: str | None = None) -> None:
        if coursier_dir is None:
            self.find_repo_roots()
        else:
            self._coursier_dir = os.path.realpath(coursier_dir)

        if self._coursier_dir is None:
            raise Exception("No coursier directory was found or given")

        if not os.path.exists(self._coursier_dir):
            raise Exception("Specified coursier directory not found")

        info(f"Searching in {self._coursier_dir}")

    def find_repo_roots(self) -> None:
        jvav = shutil.which("java")
        if jvav is None:
            raise FileNotFoundError("java exeutable not found")
        jvav_output = subprocess.run(
            [jvav, "-XshowSettings:properties", "-version"],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        )
        for line in jvav_output.stdout.splitlines():
            if "user.home" in line:
                homedir = line.split("=")[1].strip()
                self._coursier_dir = os.path.join(homedir, ".cache", "coursier")
                break

    def to_nvfetcher_cfg_file(self) -> str:
        assert self._coursier_dir is not None
        poms = [Pom(f, self._coursier_dir) for f in PomSearcher(self._coursier_dir)]
        poms.sort(key=lambda pom: pom._uniq_name)
        return "\n\n".join([pom.to_nvfetcher_cfg() for pom in poms])


def mill_prepare_offline(
    prepare_targets: list[str],
    work_dir: str | None = None,
) -> str:
    ivy_repo_dir = (
        os.path.realpath(work_dir) if work_dir is not None else tempfile.gettempdir()
    )
    if not os.path.exists(ivy_repo_dir):
        warning(f"Speified work dir {work_dir} not exists, creating")
    ivy_cache_dir = os.path.join(ivy_repo_dir, "cache")
    os.makedirs(ivy_cache_dir, exist_ok=True)
    mill_opt_file = tempfile.mktemp()

    def jvm_opt_to_set(env_key: str):
        raw = os.getenv(env_key)
        if raw is not None and raw != "":
            warning(f"using env {env_key}: '{raw}'")
            return dict(
                [
                    (opt[0], opt[1])
                    for arg in raw.strip().split(" ")
                    if (opt := arg.split("="))
                ]
            )
        return {}

    base_java_opt_set = (
        {
            # Override ~/.ivy2
            "-Dcoursier.ivy.home": ivy_repo_dir,
            # Mill vendor an unofficial way for ivy2 local
            "-Divy.home": ivy_repo_dir,
            # Override ~/.cache/coursier/v1
            "-Dcoursier.cache": ivy_cache_dir,
        }
        | jvm_opt_to_set("JAVA_OPTS")
        | jvm_opt_to_set("JAVA_TOOL_OPTIONS")
    )

    base_java_opts = [f"{k}={base_java_opt_set[k]}" for k in base_java_opt_set.keys()]

    with open(mill_opt_file, "w") as mf:
        mf.write("\n".join(base_java_opts))

    java_opt = " ".join(base_java_opts)

    info("Preparing Ivy dependencies")
    mill = shutil.which("mill")
    if mill is None:
        raise FileNotFoundError("Mill executable not found")
    jvm_env = {
        "JAVA_OPTS": java_opt,
        # In Oracle Java, they use "JAVA_TOOL_OPTIONS"
        "JAVA_TOOL_OPTIONS": java_opt,
        # Maven mirror sometime contains invalid dependency and make us hard to debug the problem, use maven central only.
        "COURSIER_REPOSITORIES": "ivy2local|central",
        # Mill will fork process without inherit the JAVA_OPTS env
        "MILL_JVM_OPTS_PATH": mill_opt_file,
    }
    subprocess.check_call(
        [mill, "--no-server"]
        + [target + ".prepareOffline" for target in prepare_targets],
        env=jvm_env,
    )
    subprocess.check_call(
        [mill, "--no-server", "__.scalaCompilerClasspath"],
        env=jvm_env,
    )
    info("Ivy dependencies resolved")
    return ivy_repo_dir


def fetch_handler(args):
    dir = mill_prepare_offline(
        args.targets or ["__"],
        args.work_dir,
    )
    info(f"Downloaded into {dir}")


def dump_handler(args):
    try:
        repo = LocalCoursierRepo(args.coursier_dir)
        content = repo.to_nvfetcher_cfg_file()
        dp = args.dump_path
        if dp is None or dp == "":
            print(content)
        else:
            info(f"nvfetcher config save to {dp}")
            with open(dp, "w") as f:
                f.write(content)
    except Exception as inst:
        error(inst)
        exit(1)


if __name__ == "__main__":
    logging.basicConfig(format="[%(levelname)s] %(message)s", level=logging.INFO)

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
        help="Path to dump nvfetcher config file instead of printing to stdout",
    )
    dump_parser.set_defaults(func=dump_handler)

    fetch_parser = subparser.add_parser("fetch", help="%(prog)s fetch help")
    fetch_parser.add_argument(
        "-o",
        "--work-dir",
        nargs="?",
        help="Use the specify directory as working directory, default using a new temporary directory",
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
