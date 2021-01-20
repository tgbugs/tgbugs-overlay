# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7..9} )
inherit git-r3 distutils-r1

DESCRIPTION="rdflib extension adding JSON-LD parser and serializer"
HOMEPAGE="https://github.com/RDFLib/rdflib-jsonld https://github.com/tgbugs/rdflib-jsonld"
EGIT_REPO_URI="https://github.com/tgbugs/rdflib-jsonld.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/rdflib[${PYTHON_USEDEP}]"

RESTRICT="test"
