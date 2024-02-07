# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="SPARQL slurper for rdflib"
HOMEPAGE="
	https://pypi.org/project/sparqlslurper/
	https://github.com/hsolbrig/sparqlslurper
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES="${FILESDIR}/no-shim.patch"

RDEPEND="
	>=dev-python/SPARQLWrapper-1.8.2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
