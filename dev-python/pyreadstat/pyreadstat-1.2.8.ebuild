# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Python package to read sas, spss and stata files into pandas data frames."
HOMEPAGE="
	https://pypi.org/project/pyreadstat/
	https://github.com/Roche/pyreadstat
"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	sci-libs/readstat
"

distutils_enable_tests pytest
