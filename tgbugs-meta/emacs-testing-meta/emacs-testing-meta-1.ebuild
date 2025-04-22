# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for emacs testing"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="multilib"

RDEPEND="
x86?         ( app-editors/emacs:18 )
multilib?    ( app-editors/emacs:18 )
!elibc_musl? ( app-editors/emacs:26 )  # see gentoo/profiles/features/musl/package.mask
app-editors/emacs:27
app-editors/emacs:28
app-editors/emacs:29
app-editors/emacs:30
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
