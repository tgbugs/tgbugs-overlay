# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} pypy3 pypy3_11 )
PYPI_NO_NORMALIZE=1
PYPI_PN=shexjsg

inherit pypi distutils-r1

DESCRIPTION="ShEx AST as python classes"
HOMEPAGE="
	https://pypi.org/project/ShExJSG/
	https://github.com/hsolbrig/ShExJSG
"
S=$WORKDIR/${PYPI_PN}-$PV

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/PyJSG-0.12.3[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
