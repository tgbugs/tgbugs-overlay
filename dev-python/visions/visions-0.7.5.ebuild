# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Python package to read sas, spss and stata files into pandas data frames."
HOMEPAGE="
	https://pypi.org/project/visions/
	https://github.com/dylan-profiler/visions
"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/numpy-1.23.2[${PYTHON_USEDEP}]
	>=dev-python/pandas-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
	>=dev-python/networkx-2.4[${PYTHON_USEDEP}]
	>=dev-python/multimethod-1.4[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
