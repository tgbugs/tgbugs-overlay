# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Python utilities for the Hypothes.is REST api and websocket interface"
HOMEPAGE="https://github.com/tgbugs/hyputils"

LICENSE="MIT"
SLOT="0"
IUSE="dev test zendesk"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/factory_boy[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
	zendesk? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/zdesk[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	mkdir ${HOME}/.cache || die
	epytest || die "Tests fail with ${EPYTHON}"
}
