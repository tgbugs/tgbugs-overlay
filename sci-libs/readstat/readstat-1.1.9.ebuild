# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library for converting SAS, Stata, and SPSS files"
HOMEPAGE="https://github.com/WizardMac/ReadStat"
SRC_URI="https://github.com/WizardMac/ReadStat/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	virtual/libiconv
"

PATCHES=( "${FILESDIR}/readstat-1.1.9-uaf-and-fix-warn.patch" )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
