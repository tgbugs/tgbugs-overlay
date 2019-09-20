# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Augmented pathlib. "
HOMEPAGE="https://github.com/tgbugs/augpathlib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev test"

DEPEND="
	dev-python/git-python[${PYTHON_USEDEP}]
	>=dev-python/pexpect-4.7.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxattr
	dev-python/terminaltables
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
