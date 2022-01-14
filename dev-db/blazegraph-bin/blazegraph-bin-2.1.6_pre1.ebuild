# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE=""

inherit java-pkg-2

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"
MY_TAG_PV="${PV%%_pre*}"
TAG_NAME="${MY_PN^^}_${MY_TAG_PV//./_}_RC"

DESCRIPTION="A high-performance graph database supporting Blueprints and RDF/SPARQL APIs."
HOMEPAGE="https://www.blazegraph.com/"
SRC_URI="https://github.com/blazegraph/database/releases/download/${TAG_NAME}/blazegraph.jar -> ${MY_P}.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=""

IDEPEND="
	acct-group/blazegraph
	acct-user/blazegraph"

RDEPEND="
	>=virtual/jre-1.8"

BDEPEND="
	>=virtual/jdk-1.8"

PACKAGE="${PN}-${SLOT}"
PACKAGE_SHARE="/usr/share/${PACKAGE}"
PACKAGE_FOLDER="/usr/share/${MY_PN}"

EXECUTABLE="/usr/bin/${MY_PN}"

src_unpack() {
	mkdir "${S}"
}

src_compile() {
	:
}

src_install() {
	keepdir "/var/log/${MY_PN}"
	fowners ${MY_PN}:${MY_PN} "/var/log/${MY_PN}"
	newinitd "${FILESDIR}/${MY_PN}.rc" ${MY_PN}
	newconfd "${FILESDIR}/${MY_PN}.confd" ${MY_PN}

	dodir "${PACKAGE_SHARE}"
	cp "${DISTDIR}/${MY_P}.jar" "${ED}${PACKAGE_SHARE}" || die "wat"
	java-pkg_regjar "${ED}${PACKAGE_SHARE}/${MY_P}.jar"

	dodir "/usr/bin"
	echo '#!/usr/bin/env sh' > "${ED}${EXECUTABLE}"
	echo "/usr/bin/java -jar \"${PACKAGE_FOLDER}/${MY_PN}.jar\""' $@' >> "${ED}${EXECUTABLE}"

	chmod 0755 "${ED}${EXECUTABLE}"

	dodir ${PACKAGE_FOLDER}
	dosym "${PACKAGE_SHARE}/${MY_P}.jar" "${PACKAGE_FOLDER}/${MY_PN}.jar"
}

pkg_config() {
	default
}
