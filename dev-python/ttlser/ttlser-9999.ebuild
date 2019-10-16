# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
inherit git-r3 distutils-r1

DESCRIPTION="Deterministic turtle serialization for rdflib."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/ttlser"
EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"

PATCHES=(
	"${FILESDIR}/outside-the-asylum.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="dev test +ttlfmt"

DEPEND="
	>=dev-python/rdflib-5.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
	ttlfmt? (
		dev-python/docopt[${PYTHON_USEDEP}]
		>=dev-python/joblib-0.14.0[${PYTHON_USEDEP}]
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
