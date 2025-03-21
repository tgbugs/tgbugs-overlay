# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Your friendly neighborhood web scraper"
HOMEPAGE="https://github.com/jmcarp/robobrowser"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
dev-python/requests[${PYTHON_USEDEP}]
dev-python/six[${PYTHON_USEDEP}]
dev-python/werkzeug[${PYTHON_USEDEP}]
${DEPEND}"

RESTRICT="test"
