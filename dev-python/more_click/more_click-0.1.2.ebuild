# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="More click options"
HOMEPAGE="
	https://pypi.org/project/more_click/
	https://github.com/cthoyt/more_click
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
