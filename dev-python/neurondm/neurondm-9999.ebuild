# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit git-r3 distutils-r1

DESCRIPTION="A data model for neuron types."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/neurondm"
EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dev notebook test"

DEPEND="
	>=dev-python/hyputils-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.3[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	notebook? (
		dev-python/jupyter[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${S}/${PN}"

src_prepare () {
	# replace package version to keep python quiet
	sed -i "s/__version__.\+$/__version__ = '9999.0.0'/" ${PN}/__init__.py
	default
}
