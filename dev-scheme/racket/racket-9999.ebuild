# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/racket/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="minimal? ( http://download.racket-lang.org/installers/${PV}/${PN}-minimal-${PV}-src-builtpkgs.tgz ) !minimal? ( http://download.racket-lang.org/installers/${PV}/${P}-src-builtpkgs.tgz )"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="General purpose, multi-paradigm Lisp-Scheme programming language"
HOMEPAGE="http://racket-lang.org/"
LICENSE="MIT Apache-2.0"
SLOT="0"
IUSE="cgc cs doc +futures install-chez +jit minimal +places +readline +threads +X"
REQUIRED_USE="futures? ( jit ) install-chez? ( cs )"

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

if [[ ${PV} == "9999" ]]; then
	S="${WORKDIR}/${P}/${PN}/src"
else
	S="${WORKDIR}/${P}/src"
fi

if [[ ${PV} == "9999" ]]; then
	PATCHES=( "${FILESDIR}"/install-chez-scheme.patch )
fi

if [[ ${PV} == "9999" ]]; then
	src_unpack() {
		git-r3_src_unpack
		if use cs; then
			export SCHEME_SRC="${WORKDIR}/ChezScheme"
			mkdir "${SCHEME_SRC}"
			unset EGIT_DIR
			export EGIT_REPO_URI="https://github.com/racket/ChezScheme.git"
			export EGIT_CHECKOUT_DIR="${SCHEME_SRC}"
			git-r3_src_unpack
		fi
	}
fi

src_prepare() {
	default
	rm -r foreign/libffi || die 'failed to remove bundled libffi'
	if [[ ${PV} == "9999" ]]; then
		if use cs; then
			ln -s ${SCHEME_SRC} .  # alternate fix for the configure step
		fi
	fi
}

src_configure() {
	# According to vapier, we should use the bundled libtool
	# such that we don't preclude cross-compile. Thus don't use
	# --enable-lt=/usr/bin/libtool
	# racketcs does not currently support shared libs
	# https://github.com/racket/racket/issues/2993
	econf \
		--enable-shared \
		--enable-float \
		--enable-libffi \
		--enable-foreign \
		--disable-libs \
		--disable-strip \
		$(use_enable X gracket) \
		$(use_enable cs) \
		$(use_enable doc docs) \
		$(use_enable jit) \
		$(use_enable places) \
		$(use_enable futures) \
		$(use_enable threads pthread) \
		$(if [[ ${PV} == "9999" ]]; then echo --enable-useprefix; else echo; fi)
}

src_compile() {
	if use jit; then
		# When the JIT is enabled, a few binaries need to be pax-marked
		# on hardened systems (bug 613634). The trick is to pax-mark
		# them before they're used later in the build system. The
		# following order for racketcgc and racket3m was determined by
		# digging through the Makefile in src/racket to find out which
		# targets would build those binaries but not use them.
		pushd racket
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

	if use cs; then
		emake cs SCHEME_SRC="${SCHEME_SRC}" RACKET="${S}/racket/racket3m" CS_SETUP_TARGET=nothing-after-base
	fi

	default

	if ! use minimal; then
		emake install PREFIX="/usr" DESTDIR="${D}"
		pushd "${S}/../../"
		export LD_LIBRARY_PATH="${D}/usr/lib64"
		"${D}/usr/bin/racket" -X "${D}/usr/share/racket/collects" -G "${D}/etc/racket" -l- pkg/dirs-catalog --check-metadata build/local/pkgs-catalog
		"${D}/usr/bin/raco" pkg catalog-copy --force --from-config build/local/pkgs-catalog build/local/catalog
		unset LD_LIBRARY_PATH
		#"${S}/racket/racket3m" -l- pkg/dirs-catalog --check-metadata build/local/pkgs-catalog
		popd
	fi
}

src_install() {
	# FIXME racketcs doesn't set the correct collects location, it remembers
	# the sandboxed location instead of the ultimate location (sigh)
	if use cgc; then
		emake install-both PREFIX="/usr" DESTDIR="${D}"
	else
		emake install PREFIX="/usr" DESTDIR="${D}"
	fi

	if use cs; then
		# FIXME TODO the cs executables have the wrong mode set
		emake install-cs PREFIX="/usr" DESTDIR="${D}" CS_SETUP_TARGET=no-setup-install RACKET="${S}/racket/racket3m"
		if use install-chez; then
			pushd "${SCHEME_SRC}"
			emake install
			popd
		fi
	fi

	einstalldocs

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
}
