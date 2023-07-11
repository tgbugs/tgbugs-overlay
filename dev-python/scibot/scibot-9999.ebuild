# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/SciCrunch/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Web annotation curation pipeline"
HOMEPAGE="https://github.com/SciCrunch/scibot"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="dev test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/fastentrypoints[${PYTHON_USEDEP}]"

IDEPEND="
	acct-group/scibot
	acct-user/scibot"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/curio[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	www-servers/gunicorn[${PYTHON_USEDEP}]
	>=dev-python/hyputils-0.0.6[memex,${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.23[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

pkg_setup() {
	ebegin "Creating scibot user and group"
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
	newinitd "${FILESDIR}/scibot-bookmarklet.rc" scibot-bookmarklet
	newconfd "${FILESDIR}/scibot-bookmarklet.confd" scibot-bookmarklet
	chmod 0600 "${D}"/etc/conf.d/*
	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run scibot you need to set the hypothes.is"
	ewarn "group, user, and api token in /etc/conf.d/scibot-bookmarklet"
}
