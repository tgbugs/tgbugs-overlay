# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( pypy{3,} python3_{4,5,6,7} )
inherit distutils-r1

DESCRIPTION="Your friendly neighborhood web scraper"
HOMEPAGE="https://github.com/jmcarp/robobrowser"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]
dev-python/six[${PYTHON_USEDEP}]
dev-python/werkzeug[${PYTHON_USEDEP}]
${DEPEND}"

RESTRICT="test"
