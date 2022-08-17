# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="profile"
inherit haskell-cabal
inherit git-r3

DESCRIPTION="convert graphviz dot to yworks graphml"
HOMEPAGE="https://github.com/tgbugs/dot2graphml"
EGIT_REPO_URI="https://github.com/tgbugs/dot2graphml.git"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""

RDEPEND="
	>=dev-haskell/graphviz-2999.17.0.1:=[profile?]
	>=dev-haskell/hxt-9.2:=[profile?]
	>=dev-haskell/text-0.11.2.3:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
"
