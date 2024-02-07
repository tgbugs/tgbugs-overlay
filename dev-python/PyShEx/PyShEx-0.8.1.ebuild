# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Idiomatic conversion between URIs and compact URIs (CURIEs) in Python"
HOMEPAGE="
	https://pypi.org/project/curies/
	https://github.com/biopragmatics/curies
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/CFGraph[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	>=dev-python/PyShExC-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
#sparqlslurper>=0.5.1
#sparqlwrapper>=1.8.5

distutils_enable_tests pytest
