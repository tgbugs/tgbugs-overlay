# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

PYTHON_PV="${PV/_p/.post}"
PYTHON_P="${PN}-${PYTHON_PV}"
S="${WORKDIR}/${PYTHON_P}"

DESCRIPTION="utilities for working with the NIF ontology, SciGraph, and turtle"
HOMEPAGE="https://github.com/tgbugs/pyontutils"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${PYTHON_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#dev-python/ipython[${PYTHON_USEDEP}]  # because who wants to deal with that mess >_<
DEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/git-python[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/ontquery[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/rdflib-5.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/robobrowser[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}/outside-the-asylum.patch"
)
