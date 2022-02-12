# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="A simple immutable mapping for python"
HOMEPAGE="https://github.com/Marco-Sulla/python-frozendict"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND=""
RDEPEND=""

distutils_enable_tests pytest


EPYTEST_IGNORE=(
	test/test_coold.py
	test/test_coold_subclass.py
)
EPYTEST_DESELECT=(
	test/test_frozendict_c.py::test_c_extension
)

src_prepare () {
	default
	sed -i 's/custom_arg\ =\ None/custom_arg = "py"/' setup.py || die
}
