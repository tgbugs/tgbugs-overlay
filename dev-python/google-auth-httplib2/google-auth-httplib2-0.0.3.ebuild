# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy{,3} )

inherit distutils-r1

DESCRIPTION="httplib2 Transport for Google Auth"
HOMEPAGE="https://pypi.org/project/google-auth-httplib2/ https://github.com/GoogleCloudPlatform/google-auth-library-python-httplib2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
IUSE="test"

RDEPEND="
	dev-python/google-auth[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}
	test? (
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v || die "Tests failed under ${EPYTHON}"
}
