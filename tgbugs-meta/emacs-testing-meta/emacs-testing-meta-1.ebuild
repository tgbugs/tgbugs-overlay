# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for emacs testing"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
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
_rdp=""; while IFS= read -r line || [[ -n "$line" ]]; do out="${line%%#*}"; out="${out%"${out##*[![:space:]]}"}"; _rdp+="${out}"$'\n'; done < <(printf '%s\n' "$RDEPEND"); RDEPEND="${_rdp}"
