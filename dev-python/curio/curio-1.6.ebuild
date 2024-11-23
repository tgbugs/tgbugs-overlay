# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Curio is a library for performing concurrent I/O with coroutines in Python 3."
HOMEPAGE="https://github.com/dabeaz/curio"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

python_test() {
	pytest -vv || die "tests fail with ${EPYTHON}"
}
