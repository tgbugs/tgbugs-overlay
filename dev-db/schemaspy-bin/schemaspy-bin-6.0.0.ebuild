# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE=""

inherit java-pkg-2

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Document your database simply and easily"
HOMEPAGE="https://github.com/schemaspy/schemaspy/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_P}.jar"

LICENSE="LGPL-3+"
SLOT="6.0"
KEYWORDS="~amd64 ~x86"
IUSE="+postgres +mysql"

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.8
		media-gfx/graphviz
		mysql? ( dev-java/jdbc-mysql )
		postgres? ( dev-java/jdbc-postgresql )"
DEPEND=">=virtual/jdk-1.8"

SCHEMASPY="${PN}-${SLOT}"
SCHEMASPY_SHARE="/usr/share/${SCHEMASPY}"
SCHEMASPY_FOLDER="/usr/share/${MY_PN}"

EXECUTABLE="/usr/bin/${MY_PN}"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	dodir "${SCHEMASPY_SHARE}"
	cp "${S}/${MY_P}.jar" "${ED}${SCHEMASPY_SHARE}"
	java-pkg_regjar "${ED}${SCHEMASPY_SHARE}/${MY_P}.jar"

	dodir "/usr/bin"
	echo '#!/usr/bin/env sh' > "${ED}${EXECUTABLE}"
	echo "/usr/bin/java -jar \"${SCHEMASPY_FOLDER}/${MY_PN}.jar\""' $@' >> "${ED}${EXECUTABLE}"

	chmod 0755 "${ED}${EXECUTABLE}"

	dodir ${SCHEMASPY_FOLDER}
	dosym "${SCHEMASPY_SHARE}/${MY_P}.jar" "${SCHEMASPY_FOLDER}/${MY_PN}.jar"
}
