# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

DESCRIPTION="A Python Slugify application that handles Unicode"

HOMEPAGE="https://github.com/un33k/python-slugify"
SRC_URI="mirror://pypi/p/python-${PN}/python-${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/unidecode-1.0.23[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/python-${P}"
