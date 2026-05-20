# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} pypy3 pypy3_11 )
PYPI_NO_NORMALIZE=1
PYPI_PN=pyshex

inherit pypi distutils-r1

DESCRIPTION="Idiomatic conversion between URIs and compact URIs (CURIEs) in Python"
HOMEPAGE="
	https://pypi.org/project/curies/
	https://github.com/biopragmatics/curies
"
S=$WORKDIR/${PYPI_PN}-$PV

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES="${FILESDIR}/no-shim.patch"

RDEPEND="
	dev-python/CFGraph[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	>=dev-python/PyShExC-0.10.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/ShExJSG-0.9.0[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/sparqlslurper-0.5.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
