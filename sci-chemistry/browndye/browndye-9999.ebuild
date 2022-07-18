# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

DESCRIPTION="Brownian Dynamics of Biological Molecules"
HOMEPAGE="http://browndye.ucsd.edu/"
SRC_URI="http://browndye.ucsd.edu/browndye.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/ocaml"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

PATCHES=(
	#"${FILESDIR}"/${P}-parallel_build-2.patch
	#"${FILESDIR}"/${P}-install.patch
	)

src_compile() {
	emake all  # fails when run with -j > 1 due to missing ordering rules
}

src_install() {
	emake install
	insinto /usr/bin/
	doins -r "${S}"/usr/bin/*
	find "${D}"/usr/bin/ -type f ! -name '*.*' -exec chmod 755 {} \; \
		|| die "failed to make plugins executables"

	#die
}
