# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="helper classes for organizing docopt programs"
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/clifn"

LICENSE="MIT"
SLOT="0"
IUSE="dev test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
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
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}
