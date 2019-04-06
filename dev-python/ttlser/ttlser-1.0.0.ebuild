# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Deterministic turtle serialization for rdflib."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/ttlser"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

PATCHES=(
	"${FILESDIR}/outside-the-asylum.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/rdflib-5.0.0[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"
