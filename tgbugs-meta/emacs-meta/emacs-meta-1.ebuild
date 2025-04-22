# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for emacs"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
app-editors/emacs
app-emacs/vterm
app-emacs/zmq
"
