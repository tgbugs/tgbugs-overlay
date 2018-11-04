# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE=""

inherit java-pkg-2 user

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web services for SciGraph, A Neo4j backed ontology store."
HOMEPAGE="https://github.com/SciGraph/SciGraph/"
SRC_URI='SciGraph-master-services-2018-11-03-c992c7c.zip'

LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8
        app-arch/unzip"

SCIGRAPH="${PN}-${SLOT}"
SCIGRAPH_SHARE="/usr/share/${SCIGRAPH}"
SERVICES_FOLDER="/usr/share/scigraph-services"

EXECUTABLE="/usr/bin/${MY_PN}"

S="${WORKDIR}/${MY_P}-SNAPSHOT"

SCIGRAPH_HOME="/var/lib/scigraph"
pkg_setup() {
	ebegin "Creating scigraph user and group"
	enewgroup scigraph
	enewuser scigraph -1 -1 "${SCIGRAPH_HOME}" scigraph
	eend $?
}

src_install() {
	keepdir "${SCIGRAPH_HOME}"
	fowners scigraph:scigraph "${SCIGRAPH_HOME}"

	dodir ${SCIGRAPH_SHARE}

	cp -Rp lib "${ED}${SCIGRAPH_SHARE}" || die "failed to copy"
	cp "${MY_P}-SNAPSHOT.jar" "${ED}${SCIGRAPH_SHARE}/${MY_P}.jar"
	java-pkg_regjar "${ED}${SCIGRAPH_SHARE}"/lib/*.jar
	java-pkg_regjar "${ED}${SCIGRAPH_SHARE}/${MY_P}.jar"

	keepdir "/var/log/${MY_PN}"
	fowners scigraph:scigraph "/var/log/${MY_PN}"

	dodir "/usr/bin"
	echo '#!/usr/bin/env sh' > "${ED}${EXECUTABLE}"
	echo '/usr/bin/java $@ &' >> "${ED}${EXECUTABLE}"
	echo 'echo $! > '"/var/run/${MY_PN}/${MY_PN}.pid" >> "${ED}${EXECUTABLE}"

	chmod 0755 "${ED}${EXECUTABLE}"

	dodir ${SERVICES_FOLDER}
	dosym "${SCIGRAPH_SHARE}/${MY_P}.jar" "${SERVICES_FOLDER}/scigraph-services.jar"

	newinitd "${FILESDIR}/${PV}/scigraph-services.rc" scigraph-services
	newconfd "${FILESDIR}/${PV}/scigraph-services.confd" scigraph-services
}
