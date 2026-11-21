#!/usr/bin/env python3
"""Update the tap formula from a verified upstream release source archive."""

from pathlib import Path
import re
import sys

if len(sys.argv) != 3:
    raise SystemExit("usage: update_formula.py VERSION SHA256")
version, digest = sys.argv[1:]
if not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+", version):
    raise SystemExit("invalid semantic version")
if not re.fullmatch(r"[0-9a-f]{64}", digest):
    raise SystemExit("invalid SHA-256 digest")

formula = Path("Formula/muffle.rb")
source = formula.read_text(encoding="utf-8")
source, url_count = re.subn(
    r'url "https://github\.com/Thavarshan/muffle/archive/refs/tags/v[^" ]+\.tar\.gz"',
    f'url "https://github.com/Thavarshan/muffle/archive/refs/tags/v{version}.tar.gz"',
    source,
    count=1,
)
source, hash_count = re.subn(r'sha256 "[0-9a-f]{64}"',
                             f'sha256 "{digest}"', source, count=1)
source = re.sub(r'assert_match "muffle [0-9]+\.[0-9]+\.[0-9]+"',
                f'assert_match "muffle {version}"', source, count=1)
if url_count != 1 or hash_count != 1:
    raise SystemExit("formula template did not contain expected fields")
formula.write_text(source, encoding="utf-8")
