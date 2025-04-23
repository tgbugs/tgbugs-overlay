# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for shells"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# TODO consider sys-apps/busybox?
RDEPEND="
app-shells/dash
app-shells/fish
app-shells/pwsh
app-shells/tcsh
app-shells/zsh
"
