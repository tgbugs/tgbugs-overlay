# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pax-utils

DESCRIPTION="General purpose, multi-paradigm Lisp-Scheme programming language"
HOMEPAGE="https://racket-lang.org/"
SRC_URI="
	minimal? ( https://download.racket-lang.org/releases/${PV}/installers/racket-minimal-${PV}-src-builtpkgs.tgz )
	!minimal? ( https://download.racket-lang.org/releases/${PV}/installers/racket-${PV}-src-builtpkgs.tgz )
"
RESTRICT="mirror"

LICENSE="LGPL-3 MIT Apache-2.0"
SLOT="0/8.3"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="bc cgc +cs doc +futures +jit minimal +places +readline +threads +X"
REQUIRED_USE="futures? ( || ( jit cs ) ) || ( bc cgc cs )"

RDEPEND="
	app-eselect/eselect-racket
	dev-db/sqlite:3
	media-libs/libpng:0
	x11-libs/cairo[svg,X?]
	x11-libs/pango[X?]
	dev-libs/libffi
	virtual/jpeg:0
	readline? ( dev-libs/libedit )
	X? ( x11-libs/gtk+[X?] )"
RDEPEND="${RDEPEND} !dev-tex/slatex"

DEPEND="${RDEPEND}"

S="${WORKDIR}/racket-${PV}/src"

src_prepare() {
	rm -r bc/foreign/libffi || die 'failed to remove bundled libffi'
	default
	eapply_user
}

src_configure() {
	# According to vapier, we should use the bundled libtool
	# such that we don't preclude cross-compile. Thus don't use
	# --enable-lt=/usr/bin/libtool

	# When the JIT is enabled, a few binaries need to be pax-marked
	# on hardened systems (bug 613634). The trick is to pax-mark
	# them before they're used later in the build system. The
	# following order for racketcgc and racket3m was determined by
	# digging through the Makefile in src/racket to find out which
	# targets would build those binaries but not use them.

	# using the --enable-postlink option may pax-mark more binaries
	# than we want, but it vastly simplifies the process, and it
	# matches what netbsd does, so at least we are in good company

	if use bc || use cgc && use jit; then
		postlink="/bin/bash -c '$(typeset -f has | sed 's/$/\\/' | sed 's/^}\\$/;};/') $(typeset -f pax-mark | sed 's/$/\\/' | sed 's/^}\\$/;};/') pax-mark m \${1}' _"
	else
		postlink=""
	fi
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--collectsdir="${EPREFIX}"/usr/share/racket/collects \
		--pkgsdir="${EPREFIX}"/usr/share/racket/pkgs \
		--enable-postlink="${postlink}" \
		--enable-shared \
		--enable-float \
		--enable-libffi \
		--enable-foreign \
		--disable-libs \
		--disable-strip \
		--enable-useprefix \
		--disable-cgcdefault \
		--disable-bcdefault \
		--disable-csdefault \
		$(use_enable bc) \
		$(if ! use bc; then use_enable cgc bc; fi) \
		$(use_enable cs) \
		$(use_enable X gracket) \
		$(use_enable doc docs) \
		$(use_enable jit) \
		$(use_enable places) \
		$(use_enable futures) \
		$(use_enable threads pthread)
}

src_compile() {
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

	local PATH_CS="${PORTAGE_BUILDDIR}/cs"
	local PATH_BC="${PORTAGE_BUILDDIR}/bc"
	local PATH_CGC="${PORTAGE_BUILDDIR}/cgc"

	# install
	if use cs; then
		emake DESTDIR="${PATH_CS}/image/" install-cs || die "died running make install, $FUNCNAME"
	fi

	if use bc; then
		emake DESTDIR="${PATH_BC}/image/" install-bc || die "died running make install, $FUNCNAME"
	fi

	if use cgc; then
		emake DESTDIR="${PATH_CGC}/image/" install-cgc || die "died running make install, $FUNCNAME"
	fi

	# copy to image sequentially
	if use cgc; then
		cp -au "${PATH_CGC}/image/"* "${D}" || die "copying cgc failed"
		rm -r "${PATH_CGC}"
	fi

	if use bc; then
		cp -au "${PATH_BC}/image/"* "${D}" || die "copying bc failed"
		rm -r "${PATH_BC}"
	fi

	if use cs; then
		cp -au "${PATH_CS}/image/"* "${D}" || die "copying cs failed"
		rm -r "${PATH_CS}"
	fi

	# raco needs decompressed files for packages doc installation bug 662424
	if use doc; then
		docompress -x /usr/share/doc/${PF}
	fi
	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}
