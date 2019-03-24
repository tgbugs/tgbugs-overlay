# Copyright 1999-2017 Gentoo Foundation
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
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
dev-python/celery
dev-python/elasticsearch
dev-python/flask
dev-python/flask_restplus
dev-python/flask_sqlalchemy
dev-python/psycopg2
"
#dev-python/pyontutils  # skip for now

RESTRICT="test"
