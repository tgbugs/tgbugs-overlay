# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit git-r3 eutils

EGIT_REPO_URI="git://github.com/mcellteam/cellblender.git"

DESCRIPTION="MCell blender addon. Create, Simulate, Visualize, and Analyze 3D Cell Models"
HOMEPAGE="http://mcell.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mcell"

DEPEND=">=media-gfx/blender-2.6
	mcell? ( sci-biology/mcell )"
RDEPEND="${DEPEND}"

BUILD_DIR="${S}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-destdir.patch \
		"${FILESDIR}"/${P}-parallel_build.patch
}
src_install() {
	if VER="/usr/share/blender/*";then
		emake DESTDIR=$(echo $VER)/scripts/addons/ install
	fi
}
