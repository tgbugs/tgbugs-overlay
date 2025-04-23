# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ontology editor and framework for building intelligent systems"
HOMEPAGE="https://protege.stanford.edu/"
SRC_URI="
https://github.com/protegeproject/protege-distribution/releases/download/protege-${PV}/Protege-${PV}-linux.tar.gz -> ${MY_P}.tar.gz
https://bitbucket.org/dtsarkov/factplusplus/downloads/uk.ac.manchester.cs.owl.factplusplus-P5.x-v1.6.5.jar -> factplusplus-1.6.5.jar
"

LICENSE="BSD-2"
SLOT="${PV}"
KEYWORDS="~amd64"
IUSE="+reasoners"


RDEPEND=">=virtual/jre-17"
DEPEND=">=virtual/jdk-17"

PROTEGE="${PN}-${SLOT}"
PROTEGE_SHARE="/opt/${PROTEGE}"

EXECUTABLE="/usr/bin/${MY_PN}"

QA_PRESTRIPPED="
	opt/${PROTEGE}/protege
"

S="${WORKDIR}/${MY_P^}"

src_prepare() {
	default
	rm -r "${S}/jre"
	einfo "${A}"
	if use reasoners; then
		cp "${DISTDIR}/factplusplus-1.6.5.jar" "${S}/plugins/"
	fi

	sed -i 's/^\$EFFECTIVE_JAVA_HOME\/bin\/java/\/usr\/bin\/java\ --add-opens java.xml\/com.sun.org.apache.xml.internal.serialize=ALL-UNNAMED/' "${S}/run.sh"

	echo "max_heap_size=12G" >> "${S}/conf/jvm.conf"
	echo "min_heap_size=5G" >> "${S}/conf/jvm.conf"
	echo "max_stack_size=160M" >> "${S}/conf/jvm.conf"
}

src_install() {
	insinto "${PROTEGE_SHARE}"
	doins -r "${S}"/*

	chmod 0755 "${ED}${PROTEGE_SHARE}/run.sh"
	chmod 0755 "${ED}${PROTEGE_SHARE}/protege"
	dosym "${PROTEGE_SHARE}/run.sh" "${EXECUTABLE}"
}
