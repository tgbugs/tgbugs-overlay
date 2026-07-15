# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for lisp implementations"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
dev-lisp/abcl
!elibc_musl? (  # build failures on musl
	dev-lisp/clozurecl
	dev-lisp/clisp
)
dev-lisp/ecl
dev-lisp/sbcl
"
_rdp=""; while IFS= read -r line || [[ -n "$line" ]]; do out="${line%%#*}"; out="${out%"${out##*[![:space:]]}"}"; _rdp+="${out}"$'\n'; done < <(printf '%s\n' "$RDEPEND"); RDEPEND="${_rdp}"
