# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Patch asyncio to allow nested event loops"
HOMEPAGE="https://github.com/erdewit/nest_asyncio"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools
"
RDEPEND="${DEPEND}"

RESTRICT="test"
