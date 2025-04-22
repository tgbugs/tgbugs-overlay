# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for package builders"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

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
	dev-python/interlex
	tgbugs-meta/dev-meta
	tgbugs-meta/docker-meta
	tgbugs-meta/dynapad-meta
	tgbugs-meta/sparcron-meta
	# FIXME not sure why I needed xorg and gtk here;
	x11-base/xorg-server
	x11-libs/gtk+
)
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
