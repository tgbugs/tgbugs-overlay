# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Prefix commons python utlities"
HOMEPAGE="
	https://pypi.org/project/prefixcommons/
	https://github.com/prefixcommons/prefixcommons-py
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/requests-2.28.1[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/curies-0.1.5[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
