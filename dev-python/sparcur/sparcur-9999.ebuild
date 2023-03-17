# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/SciCrunch/sparc-curation.git"
	inherit git-r3
	KEYWORDS=""
	BDEPEND="app-editors/emacs"
else
	MY_P=${PN}-${PV/_pre/.dev}  # 1.1.1_pre0 -> 1.1.1.dev0
	S=${WORKDIR}/${MY_P}
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Code for the SPARC curation workflow."
HOMEPAGE="https://github.com/SciCrunch/sparc-curation"

LICENSE="MIT"
SLOT="0"
IUSE="cron dev filetypes server test"
RESTRICT="!test? ( test )"

BDEPEND="${BDEPEND}
	dev-python/fastentrypoints[${PYTHON_USEDEP}]"

IDEPEND="
	acct-group/sparc
	acct-user/sparc"

RDEPEND="
	app-text/xlsx2csv[${PYTHON_USEDEP}]
	>=dev-python/augpathlib-0.0.25[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pennsieve[${PYTHON_USEDEP}]
	dev-python/dicttoxml[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	>=dev-python/protcur-0.0.11[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.32[${PYTHON_USEDEP}]
	>=dev-python/pysercomb-0.0.11[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	cron? (
		dev-python/celery[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	filetypes? (
		dev-python/nibabel[${PYTHON_USEDEP}]
		dev-python/pydicom[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
	server? (
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}]
		www-servers/gunicorn[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

USERGROUP=sparc

if [[ ${PV} == "9999" ]]; then
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
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	pytest || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}

src_install() {
	local pyver
	pyver=$(python -c 'import sys;print(f"python{sys.version_info.major}{sys.version_info.minor}")')
	echo "UWSGI_PYTHON_MODULE=${pyver}" >> "${S}/resources/filesystem/etc/conf.d/sparcron-server"

	doinitd "${S}/resources/filesystem/etc/init.d/sparcron-server"
	doconfd "${S}/resources/filesystem/etc/conf.d/sparcron-server"

	doinitd "${S}/resources/filesystem/etc/init.d/sparcur-dashboard"
	doconfd "${S}/resources/filesystem/etc/conf.d/sparcur-dashboard"

	keepdir "/var/log/${PN}"
	keepdir "/var/log/${PN}/dashboard"
	fowners ${USERGROUP}:${USERGROUP} "/var/log/${PN}"
	fowners ${USERGROUP}:${USERGROUP} "/var/log/${PN}/dashboard"

	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run sparcur-dashboard you need to set the path to"
	ewarn "SPARCDATA in /etc/conf.d/sparcur-dashboard"
}
