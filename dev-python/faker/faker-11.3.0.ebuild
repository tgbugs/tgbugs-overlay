# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

MY_PN=Faker
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Faker is a Python package that generates fake data for you."
HOMEPAGE="https://github.com/joke2k/faker"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

# there is an upper bound of 3.0 on the sphinx dep but gentoo no longer packages sphinx that old
DEPEND="
	>=dev-python/python-dateutil-2.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/text-unidecode-1.3[${PYTHON_USEDEP}]
	test? (
		>=dev-python/ukpostcodeparser-1.1.1[${PYTHON_USEDEP}]
		>=dev-python/validators-0.13.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.0.1[${PYTHON_USEDEP}]
		>=dev-python/random2-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/sphinx-2.4[${PYTHON_USEDEP}]
		<dev-python/freezegun-0.4[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	sed -i '/pytest-runner/d' setup.py
	distutils-r1_python_prepare_all
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/tests" . || die
	cp "${S}/setup.cfg" . || die
	pytest || die "Tests fail with ${EPYTHON}"
}
