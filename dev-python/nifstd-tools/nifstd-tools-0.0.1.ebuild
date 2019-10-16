# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

DESCRIPTION="utilities for working with the NIF ontology"
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/nifstd"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev doc spell test"

DEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.3[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev? (
		dev-python/mysql-connector-python[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		app-text/tesseract
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	doc? (
		>=app-editors/emacs-26
	)
	spell? (
		app-text/hunspell
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"
