# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6..9} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="python functions for generating html"
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/htmlfn"

LICENSE="MIT"
SLOT="0"
IUSE="dev test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}
