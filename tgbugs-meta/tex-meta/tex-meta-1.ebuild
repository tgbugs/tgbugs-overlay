# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for tex"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
app-text/texlive
dev-tex/biblatex
dev-tex/latexmk
dev-texlive/texlive-latexextra
dev-texlive/texlive-luatex
dev-texlive/texlive-music
"
