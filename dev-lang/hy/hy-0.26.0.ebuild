# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} pypy3 )

inherit distutils-r1

DESCRIPTION="A LISP dialect running in python"
HOMEPAGE="http://hylang.org/"
SRC_URI="https://github.com/hylang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

RDEPEND=">=dev-python/astor-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/funcparserlib-0.3.6[${PYTHON_USEDEP}]
	>=dev-python/rply-0.7.6[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=(
	"${FILESDIR}"/${PN}-0.26.0-do-not-install-get_version.py.patch
)

src_prepare() {
	sed -i "s/from get_version import __version__/__version__ = \"${PV}\"/" setup.py
	sed -i "s/__version__ = \"unknown\"/__version__ = \"${PV}\"/" hy/__init__.py
	default
	use doc && HTML_DOCS=( docs/_build/html/. )
}

python_compile_all() {
	use doc && emake docs
}

distutils_enable_tests pytest

python_test() {
	for _cmd in {hy,hyc,hy2py}; do
		echo "#!/usr/bin/env ${EPYTHON}" > bin/${_cmd}
		echo "import sys; from hy.cmdline import ${_cmd}_main; sys.exit(${_cmd}_main())" >> bin/${_cmd}
		chmod +x bin/${_cmd}
	done
	PATH=bin:${PATH} epytest --ignore-glob='*.hy'
}
