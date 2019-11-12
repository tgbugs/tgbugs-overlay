# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy{,3} python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="The most basic Text::Unidecode port"
HOMEPAGE="https://github.com/kmike/text-unidecode"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

python_prepare_all() {
	sed -i '/pytest-runner/d' setup.py
	distutils-r1_python_prepare_all
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp "${S}/test_unidecode.py" . || die
	cp "${S}/setup.cfg" . || die
	pytest || die "Tests fail with ${EPYTHON}"
}
