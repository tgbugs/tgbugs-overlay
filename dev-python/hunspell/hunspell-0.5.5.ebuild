# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 pypy3_12 python3_{12..15} )
inherit distutils-r1 pypi

DESCRIPTION="Module for the Hunspell spellchecker engine"
HOMEPAGE="https://github.com/blatinier/pyhunspell"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-text/hunspell
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

RESTRICT="test"
