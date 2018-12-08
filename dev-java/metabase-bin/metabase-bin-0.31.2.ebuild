# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE=""

inherit java-pkg-2

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Get business intelligence from databases"
HOMEPAGE="https://www.metabase.com/"
SRC_URI="http://downloads.metabase.com/v${PV}/metabase.jar -> ${MY_P}.jar"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

PACKAGE="${PN}-${SLOT}"
PACKAGE_SHARE="/usr/share/${PACKAGE}"
PACKAGE_FOLDER="/usr/share/${MY_PN}"

EXECUTABLE="/usr/bin/${MY_PN}"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	dodir "${PACKAGE_SHARE}"
	cp "${S}/${MY_P}.jar" "${ED}${PACKAGE_SHARE}"
	java-pkg_regjar "${ED}${PACKAGE_SHARE}/${MY_P}.jar"

	dodir "/usr/bin"
	echo '#!/usr/bin/env sh' > "${ED}${EXECUTABLE}"
	echo "/usr/bin/java -jar \"${PACKAGE_FOLDER}/${MY_PN}.jar\""' $@' >> "${ED}${EXECUTABLE}"

	chmod 0755 "${ED}${EXECUTABLE}"

	dodir ${PACKAGE_FOLDER}
	dosym "${PACKAGE_SHARE}/${MY_P}.jar" "${PACKAGE_FOLDER}/${MY_PN}.jar"
}
