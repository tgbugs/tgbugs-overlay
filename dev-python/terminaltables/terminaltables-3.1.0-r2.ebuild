# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Generate simple tables in terminals from a nested list of strings"
HOMEPAGE="https://github.com/Robpol86/terminaltables"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/colorclass[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
