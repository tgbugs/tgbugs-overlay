# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Module for click to enable registering CLI commands via entry points"
HOMEPAGE="
	https://github.com/click-contrib/click-plugins/
	https://pypi.org/project/click-plugins/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~loong ~riscv x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
