# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for shells"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

# TODO consider sys-apps/busybox?
RDEPEND="
app-shells/dash
app-shells/fish
app-shells/pwsh
app-shells/tcsh
app-shells/zsh
"
