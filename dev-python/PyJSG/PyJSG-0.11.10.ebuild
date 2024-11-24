# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )
PYPI_NO_NORMALIZE=1
inherit pypi distutils-r1

DESCRIPTION="JSON Schema Grammar bindings for Python"
HOMEPAGE="https://github.com/hsolbrib/pyjsg"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	=dev-python/antlr4-python3-runtime-4.9.3[${PYTHON_USEDEP}]
	>=dev-python/jsonasobj-1.2.1[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/no-setup-requires.patch
)

distutils_enable_tests pytest

python_test() {
	epytest -vv || die "tests fail with ${EPYTHON}"
}
