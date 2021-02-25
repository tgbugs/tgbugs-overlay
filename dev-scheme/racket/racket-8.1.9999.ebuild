# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils

DESCRIPTION="General purpose, multi-paradigm Lisp-Scheme programming language"
HOMEPAGE="https://racket-lang.org/"
SRC_URI="
	minimal? (  https://www.cs.utah.edu/plt/snapshots/current/installers/racket-minimal-src.tgz )
	!minimal? ( https://www.cs.utah.edu/plt/snapshots/current/installers/racket-src.tgz )
"

LICENSE="LGPL-3 MIT Apache-2.0"
SLOT="0"
IUSE="+bc cgc cs doc +futures +jit minimal +places +readline +threads +X"
REQUIRED_USE="futures? ( jit ) || ( bc cgc cs ) "

RDEPEND="dev-db/sqlite:3
	media-libs/libpng:0
	x11-libs/cairo[X?]
	x11-libs/pango[X?]
	virtual/libffi
	virtual/jpeg:0
	readline? ( dev-libs/libedit )
	X? ( x11-libs/gtk+[X?] )"
RDEPEND="${RDEPEND} !dev-tex/slatex"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}/src"

src_prepare() {
	rm -r bc/foreign/libffi || die 'failed to remove bundled libffi'
	default
	eapply_user
}

src_configure() {
	# According to vapier, we should use the bundled libtool
	# such that we don't preclude cross-compile. Thus don't use
	# --enable-lt=/usr/bin/libtool
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--collectsdir="${EPREFIX}"/usr/share/racket/collects \
		--enable-shared \
		--enable-float \
		--enable-libffi \
		--enable-foreign \
		--disable-libs \
		--disable-strip \
		--enable-useprefix \
		--disable-bcdefault \
		--disable-csdefault \
		$(use_enable bc) \
		$(use_enable cs) \
		$(use_enable X gracket) \
		$(use_enable doc docs) \
		$(use_enable jit) \
		$(use_enable places) \
		$(use_enable futures) \
		$(use_enable threads pthread)
}

src_compile() {
	if use jit; then
		# When the JIT is enabled, a few binaries need to be pax-marked
		# on hardened systems (bug 613634). The trick is to pax-mark
		# them before they're used later in the build system. The
		# following order for racketcgc and racket3m was determined by
		# digging through the Makefile in src/racket to find out which
		# targets would build those binaries but not use them.
		pushd bc
		emake cgc-core
		pax-mark m .libs/racketcgc
		pushd gc2
		emake all
		popd
		pax-mark m .libs/racket3m
		popd
	fi

	if use cgc; then
		emake cgc
	fi

	if use bc; then
		emake bc
	fi

	if use cs; then
		emake cs
	fi
}

src_install() {

	local IMAGE_CS="${PORTAGE_BUILDDIR}/cs/image/"
	local IMAGE_BC="${PORTAGE_BUILDDIR}/bc/image/"
	local IMAGE_CGC="${PORTAGE_BUILDDIR}/cgc/image/"

	# install
	if use cs; then
		emake DESTDIR="${IMAGE_CS}" install-cs || die "died running make install, $FUNCNAME"
	fi

	if use bc; then
		emake DESTDIR="${IMAGE_BC}" install-bc || die "died running make install, $FUNCNAME"
	fi

	if use cgc; then
		emake DESTDIR="${IMAGE_CGC}" install-cgc || die "died running make install, $FUNCNAME"
	fi

	# copy to image sequentially
	if use cgc; then
		cp -au "${IMAGE_CGC}/"* "${D}" || die "copying cgc failed"
		rm -r "${IMAGE_CGC}"
	fi

	if use bc; then
		cp -au "${IMAGE_BC}/"* "${D}" || die "copying bc failed"
		rm -r "${IMAGE_BC}"
	fi

	if use cs; then
		cp -au "${IMAGE_CS}/"* "${D}" || die "copying cs failed"
		rm -r "${IMAGE_CS}"
	fi

	if use jit; then
		# The final binaries need to be pax-marked, too, if you want to
		# actually use them. The src_compile marking get lost somewhere
		# in the install process.
		for f in mred mzscheme racket; do
			pax-mark m "${D}/usr/bin/${f}"
		done

		use X && pax-mark m "${D}/usr/$(get_libdir)/racket/gracket"
	fi
	# raco needs decompressed files for packages doc installation bug 662424
	if use doc; then
		docompress -x /usr/share/doc/${PF}
	fi
	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}
