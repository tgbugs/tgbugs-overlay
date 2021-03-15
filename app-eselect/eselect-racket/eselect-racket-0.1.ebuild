# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Manages racket symlink"
HOMEPAGE="https://www.gentoo.org/proj/en/eselect/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	app-eselect/eselect-lib-bin-symlink"

S=${WORKDIR}

pkg_setup() { :; }

src_prepare() {
	cat "${FILESDIR}"/racket.eselect-${PV} > "${WORKDIR}"/racket.eselect || die
	eapply_user
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/eselect/modules
	doins racket.eselect
}

pkg_preinst() { :; }

pkg_postinst() { :; }
