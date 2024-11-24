# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Idiomatic conversion between URIs and compact URIs (CURIEs) in Python"
HOMEPAGE="
	https://pypi.org/project/owlrl/
	https://github.com/RDFLib/OWL-RL/
"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/rdflib-7.1.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
