# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Asynchronous task queue/job queue based on distributed message passing"
HOMEPAGE="http://celeryproject.org/ https://pypi.org/project/celery/"
# The pypi tarball lacks CONTRIBUTING.rst required for documentation build.
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/celery/celery/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# There are a number of other optional 'extras' which overlap with those of kombu, however
# there has been no apparent expression of interest or demand by users for them. See requires.txt
IUSE="doc examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	<dev-python/kombu-6.0[${PYTHON_USEDEP}]
	>=dev-python/kombu-5.2.3[${PYTHON_USEDEP}]
	>=dev-python/billiard-3.6.4.0[${PYTHON_USEDEP}]
	<dev-python/billiard-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2021.3[${PYTHON_USEDEP}]
	virtual/python-greenlet[${PYTHON_USEDEP}]
	>=dev-python/vine-5.0.0[${PYTHON_USEDEP}]
	<dev-python/vine-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.3[${PYTHON_USEDEP}]
	<dev-python/click-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-plugins-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/click-didyoumean-0.0.3[${PYTHON_USEDEP}]
	>=dev-python/click-repl-0.2.0[${PYTHON_USEDEP}]
"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		>=dev-python/case-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.24.1[${PYTHON_USEDEP}]
		>=dev-python/pymongo-3.7[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		>=dev-python/pytest-6.2[${PYTHON_USEDEP}]
		dev-python/pytest-celery[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.1[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		>=dev-python/redis-3.2.0[${PYTHON_USEDEP}]
		>=dev-db/redis-2.8.0
		>=dev-python/boto3-1.9.178[${PYTHON_USEDEP}]
		>=dev-python/moto-2.2.6[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		>=dev-python/pyzmq-13.1.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
		dev-vcs/pre-commit[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		>=dev-python/sphinx-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx_celery-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-click-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-testing-0.7.2[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)"

# testsuite needs it own source
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# Fix setuptools version limits that were set for bad reasons
	sed -e '/setuptools/d' \
		-i requirements/*.txt || die

	# Suppress KeyError: 'refdoc'
	sed -e 's|^[[:space:]]*return domain.resolve_xref(env, node\['\''refdoc'\''\], app.builder,$|            if '\''refdoc'\'' not in node:\n                return None\n\0|' \
		-i docs/_ext/celerydocs.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		python_setup -3
		mkdir docs/.build || die
		emake -C docs html
	fi
}

python_test() {
	esetup.py test
}

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd-r2" celery
	newconfd "${FILESDIR}/celery.confd-r2" celery

	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	use doc && local HTML_DOCS=( docs/_build/html/. )

	newbashcomp extra/bash-completion/celery.bash ${PN}

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "zookeeper support" dev-python/kazoo
	optfeature "msgpack support" dev-python/msgpack
	#optfeature "rabbitmq support" dev-python/librabbitmq
	#optfeature "slmq support" dev-python/softlayer_messaging
	optfeature "eventlet support" dev-python/eventlet
	#optfeature "couchbase support" dev-python/couchbase
	optfeature "redis support" dev-db/redis dev-python/redis-py
	optfeature "gevent support" dev-python/gevent
	optfeature "auth support" dev-python/pyopenssl
	optfeature "pyro support" dev-python/Pyro4
	optfeature "yaml support" dev-python/pyyaml
	optfeature "memcache support" dev-python/pylibmc
	optfeature "mongodb support" dev-python/pymongo
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "sqs support" dev-python/boto
	#optfeature "cassandra support" dev-python/cassandra-driver
}
