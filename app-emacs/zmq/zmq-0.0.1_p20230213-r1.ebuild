# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NEED_EMACS=26
MY_PN="emacs-zmq"
[[ ${PV} = *_p20230213 ]] && COMMIT="92236b2cbd57741f840dc9f0582461cb8d82f78c"

inherit autotools elisp

DESCRIPTION="Emacs bindings for zeromq."
HOMEPAGE="https://github.com/nnicandro/emacs-zmq/"
SRC_URI="https://github.com/nnicandro/${MY_PN}/archive/${COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}"/${MY_PN}-${COMMIT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="net-libs/zeromq[drafts]"
RDEPEND="
	${DEPEND}
	>=app-editors/emacs-26:*[dynamic-loading]
"

PATCHES=(
	"${FILESDIR}"/${PN}-no-compile-no-download.patch
	"${FILESDIR}"/${PN}-tests-no-download.patch
	"${FILESDIR}"/${PN}-subprocess-module-path.patch
)

DOCS=( README.org )
SITEFILE="50${PN}-gentoo.el"

src_configure() {
	pushd src || die
	eautoreconf
	./configure \
		--prefix=${S} \
		--enable-shared=emacs-zmq \
		--without-docs \
		--enable-drafts=yes \
		--enable-libunwind=no \
		--disable-curve-keygen \
		--disable-perf \
		--disable-eventfd || die
	popd
}

src_compile() {
	ZMQ_LIBS=/usr/lib64/libzmq.so
	emake ${S}/emacs-zmq.so || die  # FIXME match makefile extension ?
	mv emacs-zmq.so zmq-core.so
	elisp_src_compile
}

src_install() {
	elisp_src_install
	elisp-modules-install ${PN} zmq-core.so
}
