# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( pypy{,3} python2_7 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Framework for fast, easy, and documented API development with Flask"
HOMEPAGE="https://github.com/noirbizarre/flask-restplus"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev doc test"

DEPEND=""
RDEPEND="${DEPEND}
>=dev-python/aniso8601-0.82
dev-python/jsonschema
>=dev-python/flask-0.8
dev-python/pytz
>=dev-python/six-1.3.0
dev? (
=dev-python/invoke-0.21.0
=dev-python/flake8-3.5.0
=dev-python/readme-renderer-17.2
=dev-python/tox-2.9.1
)
doc? (
=dev-python/alabaster-0.7.10
=dev-python/sphinx-1.6.5
=dev-python/sphinx-issues-0.3.1
)
test? (
dev-python/blinker
=dev-python/mock-2.0.0
=dev-python/pytest-3.2.3
=dev-python/pytest-benchmark-3.1.1
=dev-python/pytest-cov-2.5.1
=dev-python/pytest-faker-2.0.0
=dev-python/pytest-flask-0.10.0
=dev-python/pytest-mock-1.6.3
=dev-python/pytest-profiling-1.2.11
=dev-python/pytest-sugar-0.9.0
dev-python/tzlocal
)
"
