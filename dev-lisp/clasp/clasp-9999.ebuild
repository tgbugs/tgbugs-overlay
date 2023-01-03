# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy{3,} python{2_7,3_{4,5,6,7}} )
PYTHON_REQ_USE="threads"

inherit git-r3 python-any-r1 waf-utils llvm

# NOTE: this must be built with FEATURES="-network-sandbox"
# otherwise the git helper modules cannot be fetched

DESCRIPTION="A Common Lisp with LLVM back end and interoperation with C++"
HOMEPAGE="https://github.com/clasp-developers/clasp"
EGIT_REPO_URI="https://github.com/clasp-developers/clasp.git"
EGIT_BRANCH="dev"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

LLVM_MAX_SLOT=6
CXX="clang++"
CC="clang"

BDEPEND="
	dev-vcs/git
	dev-lisp/sbcl
	sys-devel/clang:${LLVM_MAX_SLOT}
	sys-devel/llvm:${LLVM_MAX_SLOT}[gold]
"
DEPEND="
	${BDEPEND}
	dev-libs/boehm-gc
	dev-libs/boost
	dev-libs/ncurses
"
RDEPEND="
"

pkg_setup () {
	python-any-r1_pkg_setup
	llvm_pkg_setup
}

src_configure () {
	waf-utils_src_configure
}

src_compile () {
	waf-utils_src_compile build_cboehm
}
