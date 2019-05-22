# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit git-r3 distutils-r1

DESCRIPTION="utilities for working with the NIF ontology, SciGraph, and turtle"
HOMEPAGE="https://github.com/tgbugs/pyontutils"
EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev spell test"

#dev-python/ipython[${PYTHON_USEDEP}]  # because who wants to deal with that mess >_<
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/git-python[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/ipython
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	>=dev-python/ontquery-0.0.8[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ttlser[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
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

