# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2

EGIT_REPO_URI="git://github.com/petere/pguri.git"

DESCRIPTION="uri datatype for PostgreSQL"
HOMEPAGE="https://github.com/petere/pguri"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/uriparser
	dev-db/postgresql:=
"
RDEPEND="${DEPEND}"

src_compile() {
	export PG_CONFIG=/usr/bin/pg_config
	emake
}
