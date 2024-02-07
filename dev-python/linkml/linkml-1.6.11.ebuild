# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Linked Open Data Modeling Language"
HOMEPAGE="
	https://linkml.io/linkml
	https://pypi.org/project/linkml/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

#BDEPEND="
	#dev-python/poetry-dynamic-versioning
#"

#PATCHES="${FILESDIR}/nodyn.patch"
PATCHES="${FILESDIR}/no-shim.patch"

RDEPEND="
	>=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/graphviz-0.10.1[${PYTHON_USEDEP}]
	dev-python/hbreader[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonasobj2-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.0.0[${PYTHON_USEDEP}]
	dev-python/linkml-dataops[${PYTHON_USEDEP}]
	>=dev-python/linkml-runtime-1.6.0[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	dev-python/parse[${PYTHON_USEDEP}]
	>=dev-python/prefixcommons-0.1.7[${PYTHON_USEDEP}]
	>=dev-python/prefixmaps-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.0.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/PyJSG-0.11.6[${PYTHON_USEDEP}]
	>=dev-python/PyShEx-0.7.20[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/rdflib-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22[${PYTHON_USEDEP}]
	>=dev-python/SPARQLWrapper-1.8.5[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.4.31[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.9.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
