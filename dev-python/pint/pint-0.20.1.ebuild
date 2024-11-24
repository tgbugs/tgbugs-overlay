# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..12} )
PYPI_NO_NORMALIZE=1
PYPI_PN=Pint

inherit distutils-r1 pypi

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
S=$WORKDIR/${PYPI_PN}-$PV

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="babel uncertainties test"

DEPEND=""
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/importlib-resources[${PYTHON_USEDEP}]' pypy3)
	babel? ( dev-python/babel[${PYTHON_USEDEP}] )
	uncertainties? ( dev-python/uncertainties[${PYTHON_USEDEP}] )
"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

src_prepare () {
	default
	sed -i "s/PACKAGE_VERSION/${PV}/" ${S}/${PN}/__init__.py
}
