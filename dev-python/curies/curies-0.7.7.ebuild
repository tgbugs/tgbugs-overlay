# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
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
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pytrie[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
