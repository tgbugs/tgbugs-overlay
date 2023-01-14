# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="a framework querying ontology terms"
HOMEPAGE="https://github.com/tgbugs/ontquery"

LICENSE="MIT"
SLOT="0"
IUSE="dev services test"
RESTRICT="!test? ( test )"

SVCDEPEND="
	>=dev-python/orthauth-0.0.14[yaml,${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	>=dev-python/rdflib-6.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
RDEPEND="
	dev? (
		>=dev-python/pyontutils-0.1.5[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	services? (
		${SVCDEPEND}
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		${SVCDEPEND}
	)
"

if [[ ${PV} == "9999" ]]; then
	BDEPEND="
		dev-python/pyontutils[${PYTHON_USEDEP}]"
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	pytest || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}
