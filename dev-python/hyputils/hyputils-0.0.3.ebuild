# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Python utilities for the Hypothes.is REST api and websocket interface"
HOMEPAGE="https://github.com/tgbugs/hyputils"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev memex test zendesk"
#REQUIRED_USE="test? ( memex )"  # incorrect but a useful pattern
REQUIRE_USE="python_targets_pypy3? ( !memex )"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	memex? (
		dev-python/bleach
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/mistune[${PYTHON_USEDEP}]
		dev-python/psycopg:2[$(python_gen_usedep python3_{6,7})]
		$(python_gen_cond_dep 'dev-python/psycopg:2[${PYTHON_USEDEP}]' 'python3*')
		$(python_gen_cond_dep 'dev-python/psycopg2cffi[${PYTHON_USEDEP}]' 'pypy3')
		dev-python/slugify[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/webob[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/factory_boy[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
	zendesk? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/zdesk[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"
