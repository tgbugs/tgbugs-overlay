# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/protc.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Web annotation workflows for protocol curation."
HOMEPAGE="https://github.com/tgbugs/protc/tree/master/protcur"

LICENSE="MIT"
SLOT="0"
IUSE="dev test"
RESTRICT="!test? ( test )"

IDEPEND="
	acct-user/protcur
	acct-group/protcur
"

DEPEND="
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/htmlfn[${PYTHON_USEDEP}]
	>=dev-python/hyputils-0.0.9[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}
	>=dev-python/pysercomb-0.0.8[${PYTHON_USEDEP}]
"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
	src_configure () { DISTUTILS_ARGS=( --release ); }

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
	esetup.py install_data --install-dir="${TEST_DIR}"
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* )
	distutils-r1_python_install_all
}

src_install() {
	keepdir "/var/log/${PN}"
	fowners ${PN}:${PN} "/var/log/${PN}"
	newinitd "${S}/resources/protcur.rc" protcur
	newconfd "${S}/resources/protcur.confd" protcur
	chmod 0600 "${D}"/etc/conf.d/*
	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run protcur you need to set the hypothes.is"
	ewarn "group, user, and api token in /etc/conf.d/protcur"
}
