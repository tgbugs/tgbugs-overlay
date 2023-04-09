# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit distutils-r1

DESCRIPTION="BCP47 LCID language codes, plain and simple"
HOMEPAGE="https://github.com/highfestiva/bcp47.py"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	pytest -vv || die "tests fail with ${EPYTHON}"
}
