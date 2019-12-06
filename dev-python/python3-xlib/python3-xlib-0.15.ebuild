# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1

DESCRIPTION="python3-xlib is python3 version of python-xlib"
HOMEPAGE="https://github.com/LiuLang/python3-xlib https://pypi.python.org/pypi/python3-xlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
