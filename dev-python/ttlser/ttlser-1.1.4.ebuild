# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Deterministic turtle serialization for rdflib."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/ttlser"

LICENSE="MIT"
SLOT="0"
IUSE="dev test +ttlfmt"
REQUIRE_USE="test? ( ttlfmt )"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/fastentrypoints[${PYTHON_USEDEP}]"

RDEPEND="
	>=dev-python/rdflib-5.0.0_pre0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	ttlfmt? (
		dev-python/docopt[${PYTHON_USEDEP}]
		>=dev-python/joblib-0.14.0[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
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

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}
