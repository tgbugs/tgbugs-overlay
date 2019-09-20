# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Code for the SPARC curation workflow."
HOMEPAGE="https://github.com/SciCrunch/sparc-curation"
# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
app-text/xlsx2csv[${PYTHON_USEDEP}]
dev-python/augpathlib[${PYTHON_USEDEP}]
dev-python/dicttoxml[${PYTHON_USEDEP}]
dev-python/google-api-python-client[${PYTHON_USEDEP}]
>=dev-python/jsonschema-3.0.1[${PYTHON_USEDEP}]
dev-python/terminaltables[${PYTHON_USEDEP}]
"
#dev-python/nibabel
#dev-python/pydicom
#dev-python/pyontutils  # skip for now

RESTRICT="test"
