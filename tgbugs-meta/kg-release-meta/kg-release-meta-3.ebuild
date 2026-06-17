# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} pypy3 pypy3_11 )
inherit python-r1

DESCRIPTION="meta package for SPARC Knowledge Graph release images"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
dev-db/blazegraph-bin
dev-haskell/dot2graphml
dev-java/scigraph-bin
$(python_gen_cond_dep '
dev-python/ipykernel[${PYTHON_USEDEP}]
' 'python3*')
dev-python/pip
media-gfx/feh
media-gfx/graphviz
tgbugs-meta/emacs-meta
tgbugs-meta/emacs-pkgs-min-meta
x11-misc/xdg-user-dirs
"
