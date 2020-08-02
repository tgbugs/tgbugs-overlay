# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} pypy3 )

inherit distutils-r1

MY_PN="${PN/2/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A pure python implementation of a sliding window memory map manager"
HOMEPAGE="
	https://pypi.org/project/smmap2/
	https://github.com/gitpython-developers/smmap"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~arm64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
	)"
RDEPEND="
	!dev-python/smmap[${PYTHON_USEDEP}]"

python_test() {
	nosetests -v || die "tests failed under ${EPYTHON}"
}

S="${WORKDIR}/${MY_P}"
