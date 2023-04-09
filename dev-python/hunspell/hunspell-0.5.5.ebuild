# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

DESCRIPTION="Module for the Hunspell spellchecker engine"
HOMEPAGE="https://github.com/blatinier/pyhunspell"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

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
