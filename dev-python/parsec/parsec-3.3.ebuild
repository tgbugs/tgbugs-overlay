# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="A universal Python parser combinator library inspired by Parsec library of Haskell"
HOMEPAGE="https://github.com/sighingnow/parsec.py"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pip"
RDEPEND="${DEPEND}"

RESTRICT="test"
