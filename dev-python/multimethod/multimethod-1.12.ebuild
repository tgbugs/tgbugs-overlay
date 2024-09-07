# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Multiple argument dispatching in Python"
HOMEPAGE="
	https://coady.github.io/multimethod
	https://pypi.org/project/multimethod
	https://github.com/coady/multimethod
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

distutils_enable_tests pytest

python_install() {
	python_domodule multimethod
}
