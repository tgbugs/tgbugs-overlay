# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="Calculations for the position of the sun and moon."
HOMEPAGE="https://github.com/sffjunkie/astral"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pip"
RDEPEND="${DEPEND}"

RESTRICT="test"

#python_prepare_all() {
	#distutils-r1_python_prepare_all
#}

#python_install_all() {
	#distutils-r1_python_install_all
#}
