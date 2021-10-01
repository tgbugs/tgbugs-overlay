# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 user git-r3

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A tool for automating ontology workflows."
HOMEPAGE="https://github.com/ontodev/robot/"
EGIT_REPO_URI="https://github.com/ontodev/robot.git"

LICENSE="BSD"
SLOT="9999"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP=""

RDEPEND=">=virtual/jre-1.8"

IDEPEND=""

# FIXME waiting on EAPI 8 support in java-pkg-2.eclass for IDEPEND
DEPEND="${IDEPEND}
	>=virtual/jdk-1.8
	>=dev-java/maven-bin-3.3"

PACKAGE="${PN}-${SLOT}"
PACKAGE_SHARE="/usr/share/${PACKAGE}"
PACKAGE_FOLDER="/usr/share/${MY_PN}"

EXECUTABLE="/usr/bin/${MY_PN}"

src_unpack() {
	git-r3_src_unpack
	ewarn "This install compiles during unpack because still no maven support."
	pushd ${S}
	export HASH=$(git rev-parse --short HEAD)
	sed -i "/<artifactId>robot<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" pom.xml
	sed -i "/<artifactId>robot<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" robot-core/pom.xml
	sed -i "/<artifactId>robot<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" robot-command/pom.xml
	sed -i "/<artifactId>robot<\/artifactId>/{N;s/<version>.\+<\/version>/<version>${HASH}<\/version>/}" robot-maven-plugin/pom.xml
	# why isn't this in src_compile you ask? network-sandbox is the answer
	mvn -DskipTests clean install || die "compile failed"
	popd
}

src_install() {
	dodir "/usr/bin"
	dodir "${PACKAGE_SHARE}"
	cp "${S}/bin/${MY_PN}.jar" "${ED}${PACKAGE_SHARE}/${MY_P}.jar" || die
	java-pkg_regjar "${ED}${PACKAGE_SHARE}/${MY_P}.jar" || die

	echo '#!/usr/bin/env sh' > "${ED}${EXECUTABLE}"
	echo "exec java "'$ROBOT_JAVA_ARGS'" -jar \"${PACKAGE_FOLDER}/${MY_PN}.jar\""' "$@"' >> "${ED}${EXECUTABLE}"
	chmod 0755 "${ED}${EXECUTABLE}"

	dodir ${PACKAGE_FOLDER}
	dosym "${PACKAGE_SHARE}/${MY_P}.jar" "${PACKAGE_FOLDER}/${MY_PN}.jar"
}