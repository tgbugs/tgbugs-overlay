# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for SPARC Knowledge Graph release images"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
dev-db/blazegraph-bin
dev-haskell/dot2graphml
dev-java/scigraph-bin
dev-python/ipykernel
dev-python/pip
media-gfx/feh
media-gfx/graphviz
tgbugs-meta/emacs-meta
x11-misc/xdg-user-dirs
"
