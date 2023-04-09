# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/digitalbazaar/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	MY_PN=PyLD
	MY_P=${MY_PN}-${PV/_pre/.dev}  # 1.1.1_pre0 -> 1.1.1.dev0
	S=${WORKDIR}/${MY_P}
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A library for working with identifiers of all kinds."
HOMEPAGE="https://github.com/tgbugs/idlib"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/frozendict[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
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
	local DOCS=( README* )
	distutils-r1_python_install_all
}
