# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Runtime support for linkml generated models"
HOMEPAGE="
	https://pypi.org/project/linkml-runtime/
	https://github.com/linkml/linkml-runtime
"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES="${FILESDIR}/no-dyn.patch"

# this is dev dependency
#BDEPEND="
	#dev-python/poetry-dynamic-versioning[${PYTHON_USEDEP}]
#"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/deprecated[${PYTHON_USEDEP}]
	dev-python/hbreader[${PYTHON_USEDEP}]
	>=dev-python/json-flattener-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/jsonasobj2-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/prefixcommons-0.1.12[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/rdflib-6.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/prefixmaps-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.2[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
