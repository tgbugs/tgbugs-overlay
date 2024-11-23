# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Zendesk API for Python generated from developer.zendesk.com"
HOMEPAGE="https://github.com/fprimex/zdesk"

PATCHES=(
	"${FILESDIR}/fix-setup-deps.patch"
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest
