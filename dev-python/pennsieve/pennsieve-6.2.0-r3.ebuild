# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Python client and command line tool for Pennsieve"
HOMEPAGE="https://github.com/Pennsieve/pennsieve-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev test +cli -agent -pandas"

DEPEND="
	>=dev-python/boto3-1.4[${PYTHON_USEDEP}]
	>=dev-python/deprecated-1.2.0[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	>=dev-python/pytz-2016[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18[${PYTHON_USEDEP}]
	>=dev-python/rsa-4.0[${PYTHON_USEDEP}]
	>=dev-python/semver-2.8.0[${PYTHON_USEDEP}]
	agent? (
		app-misc/pennsieve-agent
		>=dev-python/websocket-client-0.57.0[${PYTHON_USEDEP}]
	)
	cli? (
		>=dev-python/docopt-0.6[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.4[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.8.0[${PYTHON_USEDEP}]
	)
	pandas? (
		>=dev-python/pandas-0.20[${PYTHON_USEDEP}]
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/fix-test-cython-protobuf-jose-future.patch
)

distutils_enable_tests pytest

src_prepare () {
	default
	rm -r "${S}"/tests  # nothing else seems to work
	sed -i "s/PACKAGE_VERSION/${PV}/" ${S}/${PN}/__init__.py
}
