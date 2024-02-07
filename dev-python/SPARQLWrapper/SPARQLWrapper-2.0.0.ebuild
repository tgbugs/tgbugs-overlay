# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="A wrapper for a remote SPARQL endpoint"
HOMEPAGE="
	https://pypi.org/project/SPARQLWrapper/
	https://github.com/RDFLib/sparqlwrapper
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/rdflib-6.1.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
