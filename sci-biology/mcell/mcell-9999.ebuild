# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2 cmake-utils

EGIT_REPO_URI="git://github.com/mcellteam/mcell.git"

DESCRIPTION="MCell: Monte Carlo Simulator of Cellular Microphysiology"
HOMEPAGE="http://mcell.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/flex-2.5.6"
RDEPEND="${DEPEND}"

#CMAKE_USE_DIR=${WORKDIR}/${P}
#CMAKE_IN_SOURCE_BUILD=true
BUILD_DIR="${WORKDIR}/${P}/build"


src_configure() {
	cmake-utils_src_configure
}
src_compile() {
	cmake-utils_src_compile  # problem with cmd line options or something
}
