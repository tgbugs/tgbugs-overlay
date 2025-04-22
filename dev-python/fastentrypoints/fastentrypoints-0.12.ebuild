# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Makes entry_points specified in setup.py load more quickly"
HOMEPAGE="https://github.com/ninjaaron/fast-entry_points"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# pypi missing tests
#distutils_enable_tests pytest
