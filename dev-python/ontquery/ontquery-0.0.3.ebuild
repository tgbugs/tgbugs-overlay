# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/tgbugs/ontquery"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="services"

DEPEND="
services? (
	>=dev-python/rdflib-5.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
)
"
RDEPEND="${DEPEND}"

RESTRICT="test"
