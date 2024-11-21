# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/petere/pguri.git"

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

src_prepare() {
	default
	export pg_versions=$(eselect postgresql list | tail -n +2 | awk '{ print $1 }')
	local version
	for version in ${pg_versions}; do
		mkdir ${WORKDIR}/${version}
		cp -a ${S}/* ${WORKDIR}/${version}/
	done
}

src_compile() {
	local version
	for version in ${pg_versions}; do
		cd ${WORKDIR}/${version}
		emake PG_CONFIG=/usr/bin/pg_config${version} PG_CPPFLAGS=-Wno-int-conversion
	done
}

src_install() {
	local version
	for version in ${pg_versions}; do
		cd ${WORKDIR}/${version}
		emake PG_CONFIG=/usr/bin/pg_config${version} DESTDIR=${D} install
	done
}
