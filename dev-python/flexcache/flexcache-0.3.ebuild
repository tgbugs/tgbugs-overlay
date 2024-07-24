# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit pypi distutils-r1

DESCRIPTION=""
HOMEPAGE="
	https://pypi.org/project/flexcache/
	https://github.com/hgrecco/flexcache
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	' 3.10 pypy3)
"

distutils_enable_tests pytest
