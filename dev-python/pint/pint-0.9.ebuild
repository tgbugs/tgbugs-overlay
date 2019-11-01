# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="https://github.com/hgrecco/pint"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/Pint-${PV}.tar.gz -> ${P}.tar.gz"
S=$WORKDIR/Pint-$PV

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="babel uncertainties"

DEPEND=""
RDEPEND="${DEPEND}
	babel? ( dev-python/Babel[${PYTHON_USEDEP}] )
	uncertainties? ( dev-python/uncertainties[${PYTHON_USEDEP}] )
"

RESTRICT="test"
