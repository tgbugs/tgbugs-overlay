# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="A Python validator for SHACL"
HOMEPAGE="
	https://pypi.org/project/pyshacl/
	https://github.com/RDFLib/pySHACL
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

PATCHES="${FILESDIR}/fix-pyproj.patch"

RDEPEND="
	>=dev-python/html5lib-1.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-6[${PYTHON_USEDEP}]
	' 3.10 3.11)
	>=dev-python/owlrl-7.1.2[${PYTHON_USEDEP}]
	>=dev-python/rdflib-7.1.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.3[${PYTHON_USEDEP}]
	>=dev-python/prettytable-3.7.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		test/test_js/*
	)
	local EPYTEST_DESELECT=(
		# network sandbox
		test/test_cmdline.py::test_cmdline_web
		test/test_cmdline.py::test_cmdline_jsonld
		test/test_extra.py::test_web_retrieve
	)
	epytest
}
python_install_all () {
	local DOCS=( *.md *.txt )
	distutils-r1_python_install_all
}
