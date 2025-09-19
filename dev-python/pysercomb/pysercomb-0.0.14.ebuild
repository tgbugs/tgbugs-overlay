# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..14} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/parsercomb.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="parser combinator library and assorted parsers"
HOMEPAGE="https://github.com/tgbugs/parsercomb"

LICENSE="MIT"
SLOT="0"
IUSE="dev test +rdf +units"
RESTRICT="!test? ( test )"

RDEPEND="
	rdf? (
		>=dev-python/pyontutils-0.1.32[${PYTHON_USEDEP}]
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	units? (
		>=dev-python/pint-0.16.1[babel,uncertainties,${PYTHON_USEDEP}]
	)
"

PDEPEND="
	units? (
		dev-python/protcur[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

distutils_enable_tests pytest
