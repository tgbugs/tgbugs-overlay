# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
inherit distutils-r1 pypi

DESCRIPTION="JSON objects as first class python objects."
HOMEPAGE="https://github.com/hsolbrib/jsonasobj"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest

python_test() {
	epytest -vv || die "tests fail with ${EPYTHON}"
}
