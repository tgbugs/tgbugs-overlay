# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Semantic prefix map registry"
HOMEPAGE="
	https://pypi.org/project/prefixmaps/
	https://github.com/linkml/prefixmaps
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="
	dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]
"

#PATCHES="${FILESDIR}/nodyn.patch"

RDEPEND="
	>=dev-python/bioregistry-0.10.65[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.3[${PYTHON_USEDEP}]
	>=dev-python/myst-parser-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.5[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/rdflib-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.28.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
