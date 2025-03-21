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
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A library for working with identifiers of all kinds."
HOMEPAGE="https://github.com/tgbugs/sxpyr"

LICENSE="MIT"
SLOT="0"
IUSE="dev cli test"
RESTRICT="!test? ( test )"

IDEPEND="
	cli? (
		>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	)
"

RDEPEND="${IDEPEND}
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/sxpyr.py
		default
	}
fi

python_test() {
	PYTHONWARNINGS=ignore epytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* )
	distutils-r1_python_install_all
}
