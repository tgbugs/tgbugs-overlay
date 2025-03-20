# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Easily pick a place to store data for your Python code."
HOMEPAGE="
	https://pypi.org/project/pystow/
	https://github.com/cthoyt/pystow
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	' 3.10 pypy3)
	test? (
		dev-python/requests-file[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
