# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for python testing"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
dev-lang/python:3.8
dev-lang/python:3.9
dev-lang/python:3.10
dev-lang/python:3.11
dev-lang/python:3.12
dev-lang/python:3.13
#dev-lang/python:3.13t
#dev-lang/python:3.14
#dev-lang/python:3.14t
dev-lang/pypy:2.7
dev-lang/pypy:3.11
dev-python/pip
dev-python/pytest
"
_rdp=""; while IFS= read -r line || [[ -n "$line" ]]; do out="${line%%#*}"; out="${out%"${out##*[![:space:]]}"}"; _rdp+="${out}"$'\n'; done < <(printf '%s\n' "$RDEPEND"); RDEPEND="${_rdp}"
