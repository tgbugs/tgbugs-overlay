# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Idiomatic conversion between URIs and compact URIs (CURIEs) in Python"
HOMEPAGE="
	https://pypi.org/project/PyShExC/
	https://github.com/shexSpec/grammar-python-antlr
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES="${FILESDIR}/no-shim.patch"

RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
	>=dev-python/jsonasobj-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/PyJSG-0.11.10[${PYTHON_USEDEP}]
	>=dev-python/ShExJSG-0.8.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
