# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE=""

inherit java-pkg-2 git-r3

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web services for SciGraph, A Neo4j backed ontology store."
HOMEPAGE="https://github.com/SciGraph/SciGraph/"
EGIT_REPO_URI="https://github.com/SciGraph/SciGraph.git"

LICENSE="Apache-2.0"
SLOT="9999"
KEYWORDS="~amd64 ~x86"
IUSE="+core"

COMMON_DEP=""

IDEPEND="
	acct-group/scigraph
	acct-user/scigraph"

RDEPEND="
	>=virtual/jre-1.8
	x11-misc/xvfb-run"

BDEPEND="
	>=virtual/jdk-1.8
	>=dev-java/maven-bin-3.3"

SERVICES_PN="${MY_PN}-services"
SERVICES="${SERVICES_PN}-bin-${SLOT}"
SERVICES_SHARE="/usr/share/${SERVICES}"
SERVICES_FOLDER="/usr/share/${SERVICES_PN}"

CORE_PN="${MY_PN}-core"
CORE="${CORE_PN}-bin-${SLOT}"
CORE_SHARE="/usr/share/${CORE}"
CORE_FOLDER="/usr/share/${CORE_PN}"
GRAPHLOAD_EXECUTABLE="/usr/bin/scigraph-load"

SCIGRAPH_HOME="/var/lib/scigraph"

src_unpack() {
	git-r3_src_unpack
	ewarn "This install compiles during unpack because still no maven support."
	pushd ${S}
	export HASH=$(git rev-parse --short HEAD)
	sed -i "/<name>SciGraph<\/name>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" pom.xml
	sed -i "/<artifactId>scigraph<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" SciGraph-analysis/pom.xml
	sed -i "/<groupId>io.scigraph<\/groupId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" SciGraph-core/pom.xml
	sed -i "/<artifactId>scigraph<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" SciGraph-entity/pom.xml
	sed -i "/<groupId>io.scigraph<\/groupId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" SciGraph-services/pom.xml
	#eapply_user
	# why isn't this in src_compile you ask? network-sandbox is the answer
	mvn -DskipTests -DskipITs clean install || die "compile failed"
	popd
}

src_install() {
	keepdir "/var/log/${MY_PN}"
	fowners ${MY_PN}:${MY_PN} "/var/log/${MY_PN}"

	SERVICES_P="${SERVICES_PN}-${HASH}"

	dodir ${SERVICES_SHARE}
	dodir ${SERVICES_FOLDER}
	dodir "/usr/bin"

	cp -Rp "${S}/SciGraph-services/target/dependency" "${ED}${SERVICES_SHARE}/lib" || die "failed to copy"
	cp "${S}/SciGraph-services/target/${SERVICES_P}.jar" "${ED}${SERVICES_SHARE}/${SERVICES_P}.jar"
	java-pkg_regjar "${ED}${SERVICES_SHARE}"/lib/*.jar
	java-pkg_regjar "${ED}${SERVICES_SHARE}/${SERVICES_P}.jar"

	dosym "${SERVICES_SHARE}/${SERVICES_P}.jar" "${SERVICES_FOLDER}/${SERVICES_PN}.jar"

	if use core; then
		CORE_P="${CORE_PN}-${HASH}"

		dodir ${CORE_SHARE}
		dodir ${CORE_FOLDER}

		cp "${S}/SciGraph-core/target/${CORE_P}-jar-with-dependencies.jar" "${ED}${CORE_SHARE}/${CORE_P}.jar"
		java-pkg_regjar "${ED}${CORE_SHARE}/${CORE_P}.jar"

		dosym "${CORE_SHARE}/${CORE_P}.jar" "${CORE_FOLDER}/${CORE_PN}.jar"

		echo '#!/usr/bin/env sh' > "${ED}${GRAPHLOAD_EXECUTABLE}"
		echo 'if [ "$(/usr/bin/java -version 2>&1 | head -n1 | cut -d\" -f2 | cut -d. -f1)" -gt "1" ]; then' >> "${ED}${GRAPHLOAD_EXECUTABLE}"
		echo "/usr/bin/java --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/sun.nio.ch=ALL-UNNAMED -cp \"${CORE_FOLDER}/${CORE_PN}.jar\" io.scigraph.owlapi.loader.BatchOwlLoader"' $@' >> "${ED}${GRAPHLOAD_EXECUTABLE}"
		echo 'else' >> "${ED}${GRAPHLOAD_EXECUTABLE}"
		echo "/usr/bin/java -cp \"${CORE_FOLDER}/${CORE_PN}.jar\" io.scigraph.owlapi.loader.BatchOwlLoader"' $@' >> "${ED}${GRAPHLOAD_EXECUTABLE}"
		echo 'fi' >> "${ED}${GRAPHLOAD_EXECUTABLE}"
		chmod 0755 "${ED}${GRAPHLOAD_EXECUTABLE}"
	fi


	newinitd "${FILESDIR}/${MY_PN}.rc" "${MY_PN}"
	newconfd "${FILESDIR}/${MY_PN}.confd" "${MY_PN}"
}
