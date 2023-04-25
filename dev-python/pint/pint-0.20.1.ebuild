# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/Pint-${PV}.tar.gz -> ${P}.tar.gz"
S=$WORKDIR/Pint-$PV

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="babel uncertainties test"

DEPEND=""
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/importlib-resources[${PYTHON_USEDEP}]' pypy3)
	babel? ( dev-python/Babel[${PYTHON_USEDEP}] )
	uncertainties? ( dev-python/uncertainties[${PYTHON_USEDEP}] )
"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

src_prepare () {
	default
	sed -i "s/PACKAGE_VERSION/${PV}/" ${S}/${PN}/__init__.py
}
