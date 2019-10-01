# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit git-r3 distutils-r1

DESCRIPTION="parser combinator library and assorted parsers"
HOMEPAGE="https://github.com/tgbugs/parsercomb"
EGIT_REPO_URI="https://github.com/tgbugs/parsercomb.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dev test +units"

DEPEND="
	units? (
		dev-python/pint[uncertainties,${PYTHON_USEDEP}]
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare () {
	# replace package version to keep python quiet
	sed -i "s/__version__.\+$/__version__ = '9999.0.0'/" ${PN}/__init__.py
	default
}
