# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for debugging tools"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
app-editors/vim
app-portage/eix
app-portage/gentoolkit
dev-debug/gdb
"
