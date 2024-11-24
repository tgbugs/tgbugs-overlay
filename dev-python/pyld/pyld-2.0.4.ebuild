# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..13} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/digitalbazaar/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	MY_PN=PyLD
	MY_PV=${PV/_pre/.dev}
	MY_P=${MY_PN}-${MY_PV}  # 1.1.1_pre0 -> 1.1.1.dev0
	S=${WORKDIR}/${MY_P}
	SRC_URI="$(pypi_sdist_url --no-normalize "${MY_PN}" "${MY_PV}")"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A library for working with identifiers of all kinds."
HOMEPAGE="https://github.com/tgbugs/idlib"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-python/immutabledict[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/immdict.patch")

distutils_enable_tests pytest

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	PYTHONWARNINGS=ignore epytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	local DOCS=( README* )
	distutils-r1_python_install_all
}
