# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Zendesk API for Python generated from developer.zendesk.com"
HOMEPAGE="https://github.com/fprimex/zdesk"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/requests
	dev-python/six"

RESTRICT="test"
