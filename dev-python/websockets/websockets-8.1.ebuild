# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="WebSocket implementation in Python 3"
HOMEPAGE="https://github.com/aaugustin/websockets"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/setuptools
"
RDEPEND="${DEPEND}"

RESTRICT="test"
