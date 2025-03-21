# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
	BDEPEND="app-editors/emacs"
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="utilities for working with the NIF ontology, SciGraph, and turtle"
HOMEPAGE="https://github.com/tgbugs/pyontutils"

LICENSE="MIT"
SLOT="0"
IUSE="dev -minimal -ontload spell test"
RESTRICT="
	!test? ( test )
"

BDEPEND="${BDEPEND}
	dev-python/fastentrypoints[${PYTHON_USEDEP}]"

RDEPEND="
	>=dev-python/augpathlib-0.0.32[${PYTHON_USEDEP}]
	dev-python/clifn[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/funowl[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]
	dev-python/htmlfn[${PYTHON_USEDEP}]
	>=dev-python/idlib-0.0.1_pre22[${PYTHON_USEDEP}]
	>=dev-python/joblib-1.1.0[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/nest-asyncio[${PYTHON_USEDEP}]
	>=dev-python/ontquery-0.2.11[${PYTHON_USEDEP}]
	>=dev-python/orthauth-0.0.18[${PYTHON_USEDEP}]
	dev-python/pyld[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	>=dev-python/ttlser-1.1.6[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	ontload? (
		dev-java/scigraph-bin[core]
	)
	spell? (
		app-text/hunspell
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

if [[ ${PV} == "9999" ]]; then
	src_configure () { DISTUTILS_ARGS=( --release ); }

	src_prepare () {
		sed -i '1 i\import fastentrypoints' setup.py
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
else
	src_prepare () {
		sed -i '1 i\import fastentrypoints' setup.py
		default
	}
fi

python_test() {
	esetup.py install_data
	epytest || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}
