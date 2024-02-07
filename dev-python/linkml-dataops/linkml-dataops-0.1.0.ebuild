# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Data API for LinkML instance data"
HOMEPAGE="
	https://pypi.org/project/linkml-dataops/
	https://github.com/linkml/linkml-dataops
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jsonpatch[${PYTHON_USEDEP}]
	dev-python/jsonpath-ng[${PYTHON_USEDEP}]
	>=dev-python/linkml-runtime-1.1.6[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
