# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=poetry  # only if it was from git I think
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="New, non-backwards compatible version of the original jsonasobj"
HOMEPAGE="
	https://pypi.org/project/jsonasobj2/
	https://github.com/hsolbrig/jsonasobj2
"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/hbreader[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
