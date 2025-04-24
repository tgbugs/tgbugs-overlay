# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit pypi distutils-r1

DESCRIPTION="Promiscuous file and URL reader"
HOMEPAGE="
	https://pypi.org/project/hbreader/
	https://github.com/hsolbrig/hbreader
"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

# RDEPEND=""

distutils_enable_tests pytest
