# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
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

distutils_enable_tests pytest

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	epytest || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}
