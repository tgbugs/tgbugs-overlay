# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1 user

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/SciCrunch/sparc-curation.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Code for the SPARC curation workflow."
HOMEPAGE="https://github.com/SciCrunch/sparc-curation"

LICENSE="MIT"
SLOT="0"
IUSE="dev filetypes test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}
	app-text/xlsx2csv[${PYTHON_USEDEP}]
	>=dev-python/augpathlib-0.0.10[${PYTHON_USEDEP}]
	dev-python/blackfynn[${PYTHON_USEDEP}]
	dev-python/dicttoxml[${PYTHON_USEDEP}]
	dev-python/fastentrypoints[${PYTHON_USEDEP}]
	dev-python/gevent[$(python_gen_usedep python3_{6,7})]
	www-servers/gunicorn[${PYTHON_USEDEP}]
	dev-python/idlib[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/protcur-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.19[${PYTHON_USEDEP}]
	>=dev-python/pysercomb-0.0.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	filetypes? (
		dev-python/nibabel[${PYTHON_USEDEP}]
		dev-python/pydicom[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"

USERGROUP=sparc

pkg_setup() {
	ebegin "Creating sparc user and group"
	enewgroup ${USERGROUP}
	enewuser ${USERGROUP} -1 -1 "/var/lib/${USERGROUP}" ${USERGROUP}
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
	pytest || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}

src_install() {
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
