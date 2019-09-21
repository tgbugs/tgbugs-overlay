# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit git-r3 distutils-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/tgbugs/ontquery"
EGIT_REPO_URI="https://github.com/tgbugs/ontquery.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dev services test"

SVCDEPEND="
	>=dev-python/rdflib-5.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="
dev-python/setuptools
dev? (
	>=dev-python/pyontutils-0.0.5[${PYTHON_USEDEP}]
)
services? (
	${SVCDEPEND}
)
test? (
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	${SVCDEPEND}
)
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare () {
	# replace package version to keep python quiet
	sed -i "s/__version__.\+$/__version__ = '9999.0.0'/" ${PN}/__init__.py
	default
}
