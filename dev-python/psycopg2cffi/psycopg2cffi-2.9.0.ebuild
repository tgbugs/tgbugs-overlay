# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )
inherit distutils-r1 pypi

DESCRIPTION="Implementation of the psycopg2 module using cffi."
HOMEPAGE="https://github.com/chtd/psycopg2cffi"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-db/postgresql"

DEPEND="
"

RDEPEND="${DEPEND}"

RESTRICT="test"
