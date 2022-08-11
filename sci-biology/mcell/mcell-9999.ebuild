# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/mcellteam/mcell.git"

DESCRIPTION="MCell: Monte Carlo Simulator of Cellular Microphysiology"
HOMEPAGE="http://mcell.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"  # havn't actually tried to build on other systems...
IUSE=""

DEPEND=">=sys-devel/flex-2.5.6"
RDEPEND="${DEPEND}"

BUILD_DIR="${S}/build"


src_prepare() {
	eapply "${FILESDIR}"/${P}-destdir.patch
}
src_configure() {
	cmake-utils_src_configure
}
src_compile() {
	cmake-utils_src_compile  # problem with cmd line options or something
}
src_install() {
	cmake-utils_src_install
	doman man/*
	dodoc docs/*.*
	dodoc docs/reaction_overview/*.pdf
}
