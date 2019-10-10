# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit git-r3 distutils-r1

DESCRIPTION="parser combinator library and assorted parsers"
HOMEPAGE="https://github.com/Blackfynn/blackfynn-python"
EGIT_REPO_URI="https://github.com/tgbugs/blackfynn-python.git"
EGIT_BRANCH="no-np-pd"

PATCHES=(
	"${FILESDIR}/setup-no-cython-no-test.patch"
)

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="dev test +cli -agent -pandas"

# questionable setup dependency?
#	dev-python/cython[${PYTHON_USEDEP}]
DEPEND="
	>=dev-python/boto3-1.4[${PYTHON_USEDEP}]
	>=dev-python/deprecated-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/future-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2016[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18[${PYTHON_USEDEP}]
	>=dev-python/semver-2.8.0[${PYTHON_USEDEP}]
	agent? (
		app-misc/blackfynn-agent-bin
		>=dev-python/websocket-client-0.50.0[${PYTHON_USEDEP}]
	)
	cli? (
		>=dev-python/docopt-0.6[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.4[${PYTHON_USEDEP}]
	)
	pandas? (
		>=dev-python/pandas-0.20[${PYTHON_USEDEP}]
	)
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare () {
	# replace package version to keep python quiet
	sed -i "s/__version__.\+$/__version__ = '9999.0.0'/" ${PN}/__init__.py
	default
}
