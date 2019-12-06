# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="A terminology management system."
HOMEPAGE="https://github.com/tgbugs/interlex"
# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+rabbitmq"

DEPEND=""
RDEPEND="${DEPEND}
rabbitmq? ( net-misc/rabbitmq-server )
>=dev-python/celery-4.2.2
dev-python/elasticsearch-py
dev-python/flask
dev-python/flask-restplus
dev-python/flask-sqlalchemy
>=dev-python/psycopg-2.7
"
#dev-python/pyontutils  # skip for now

RESTRICT="test"

# NOTE use --onlydeps at this stage
