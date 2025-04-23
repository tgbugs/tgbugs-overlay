# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for dynapad"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
app-text/poppler
dev-build/cmake
dev-lang/tk
dev-libs/libconfig
media-gfx/imagemagick
media-gfx/renderdoc
sys-libs/db
tgbugs-meta/racket-meta
"
