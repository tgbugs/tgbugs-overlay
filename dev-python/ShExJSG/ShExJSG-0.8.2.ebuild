# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 pypy3_11 )

inherit pypi distutils-r1

DESCRIPTION="ShEx AST as python classes"
HOMEPAGE="
	https://pypi.org/project/ShExJSG/
	https://github.com/hsolbrig/ShExJSG
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/PyJSG-0.11.10[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
