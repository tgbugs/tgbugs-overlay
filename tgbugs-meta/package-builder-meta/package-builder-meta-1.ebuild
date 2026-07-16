# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} pypy3_11 )
inherit python-r1

DESCRIPTION="meta package for package builders"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X"

RDEPEND="
dev-db/blazegraph-bin
dev-java/scigraph-bin
dev-lisp/sbcl
dev-scheme/racket
tgbugs-meta/debug-meta
tgbugs-meta/emacs-meta
tgbugs-meta/python-testing-meta
tgbugs-meta/scheme-meta
X? (
	app-editors/gvim
	dev-python/interlex[${PYTHON_USEDEP}]
	tgbugs-meta/dev-meta
	tgbugs-meta/docker-meta
	tgbugs-meta/dynapad-meta
	tgbugs-meta/sparcron-meta
	# FIXME not sure why I needed xorg and gtk here;
	x11-base/xorg-server
	x11-libs/gtk+
)
"
_rdp=""; while IFS= read -r line || [[ -n "$line" ]]; do out="${line%%#*}"; out="${out%"${out##*[![:space:]]}"}"; _rdp+="${out}"$'\n'; done < <(printf '%s\n' "$RDEPEND"); RDEPEND="${_rdp}"
