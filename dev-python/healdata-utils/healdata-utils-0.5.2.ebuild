# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

# DO NOT USE pypi for now as it is maintained from a fork

DESCRIPTION="HEAL data packaging tools"
HOMEPAGE="
	https://github.com/HEAL/healdata-utils
"

SRC_URI="https://github.com/HEAL/healdata-utils/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyreadstat[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/visions[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/healdata-utils-0.5.2-cleanup-unused-imports.patch" )

distutils_enable_tests pytest

python_test() {
	local -x PYTHONPATH=src
	epytest
}
