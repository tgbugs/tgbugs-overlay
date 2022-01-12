# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7..10} )
inherit distutils-r1 user

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git@github.com:tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A terminology management system."
HOMEPAGE="https://github.com/tgbugs/interlex"

LICENSE="MIT"
SLOT="0"
IUSE="dev +rabbitmq database elasticsearch test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/celery-5.0.5[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/elasticsearch-py[${PYTHON_USEDEP}]
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-restx[${PYTHON_USEDEP}]
	dev-python/flask-sqlalchemy[${PYTHON_USEDEP}]
	dev-python/gevent[$(python_gen_usedep python3_{8..10})]
	www-servers/gunicorn[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/psycopg:2[${PYTHON_USEDEP}]' python3_{8..10})
	$(python_gen_cond_dep 'dev-python/psycopg2cffi[${PYTHON_USEDEP}]' pypy3)
	>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	>=dev-python/rdflib-6.0.2[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	database? (
		>=dev-db/postgresql-10
		dev-db/pguri
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	elasticsearch? ( app-misc/elasticsearch )
	rabbitmq? ( net-misc/rabbitmq-server )
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

pkg_setup() {
	ebegin "Creating ${PN} user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 "/var/lib/${PN}" ${PN}
	eend $?
}

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		sed -i '1 i\import fastentrypoints' setup.py
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
else
	src_prepare () {
		sed -i '1 i\import fastentrypoints' setup.py
		default
	}
fi

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}

src_install() {
	keepdir "/var/log/${PN}"
	fowners ${PN}:${PN} "/var/log/${PN}"
	newinitd "resources/interlex.rc" interlex
	newconfd "resources/interlex.confd" interlex
	chmod 0600 "${D}"/etc/conf.d/*
	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run interlex you need to make sure that the rabbitmq"
	ewarn "server is running and BROKER_URL is correct in /etc/conf.d/interlex"
}
