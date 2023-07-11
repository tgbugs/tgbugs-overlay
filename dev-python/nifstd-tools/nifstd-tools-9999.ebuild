# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	PYPI_NO_NORMALIZE=1
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="utilities for working with the NIF ontology"
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/nifstd"

LICENSE="MIT"
SLOT="0"
IUSE="dev doc server spell test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/fastentrypoints[${PYTHON_USEDEP}]"

IDEPEND="
	acct-user/nifstd-tools
	acct-group/nifstd-tools
"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/nbconvert[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.32[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev? (
		dev-python/mysql-connector-python[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		app-text/tesseract
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	doc? (
		>=app-editors/emacs-26
		app-text/pandoc
	)
	server? (
		www-servers/gunicorn[${PYTHON_USEDEP}]
	)
	spell? (
		app-text/hunspell
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN%%-*}"
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
	if [[ ${PV} == "9999" ]]; then
		git remote add origin ${EGIT_REPO_URI}
	fi
	distutils_install_for_testing
	esetup.py install_data --install-dir="${TEST_DIR}"
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	pytest -v --color=yes -s || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* )
	distutils-r1_python_install_all
}

src_install() {
	keepdir "/var/log/${PN}"
	fowners ${PN}:${PN} "/var/log/${PN}"
	newinitd "resources/ontree.rc" ontree
	newconfd "resources/ontree.confd" ontree
	chmod 0600 "${D}"/etc/conf.d/*
	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run ontree you need to set the SciGraph"
	ewarn "api endpoint and possibly api key in /etc/conf.d/ontree"
}
