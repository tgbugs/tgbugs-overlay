# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="Pythonic representation of OWL through the OWL functional syntax"
HOMEPAGE="https://github.com/hsolbrib/funowl"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/bcp47
	>=dev-python/PyJSG-0.11.6
	>=dev-python/rdflib-5.0.0
	dev-python/rfc3987
"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/no-shim.patch
	"${FILESDIR}"/no-setup-requires.patch
)

distutils_enable_tests pytest

python_test() {
	distutils_install_for_testing
	pytest -vv || die "tests fail with ${EPYTHON}"
}
