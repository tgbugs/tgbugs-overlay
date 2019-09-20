# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
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
app-text/xlsx2csv
dev-python/augpathlib
dev-python/dicttoxml
dev-python/google-api-python-client
>=dev-python/jsonschema-3.0.1
dev-python/terminaltables
"
#dev-python/nibabel
#dev-python/pydicom
#dev-python/pyontutils  # skip for now

RESTRICT="test"
