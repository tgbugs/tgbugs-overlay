# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE="source test"

inherit java-pkg-2 java-ant-2

EGIT_REF="d69f559"

MY_PN=${PN//-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A Clojure library with specs to describe Clojure core macros and functions."
HOMEPAGE="https://clojure.org/ https://github.com/clojure/core.specs.alpha"
SRC_URI="https://github.com/clojure/${MY_PN}/tarball/${MY_P} -> ${MY_P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0.2"
KEYWORDS="~amd64 ~x86 ~x86-linux"
IUSE=""
RESTRICT="test" # patches welcome to fix the test

CDEPEND="dev-java/ant-core:0"
RDEPEND=">=virtual/jre-1.8"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/clojure-${MY_PN}-${EGIT_REF}"

EANT_TASKS="jar"
EANT_EXTRA_ARGS="-Dmaven.build.finalName=${MY_P}"

src_prepare() {
	default
	cp ${FILESDIR}/build.xml ${S}
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar "${S}/target/${MY_P}.jar"
	dodoc CONTRIBUTING.md README.md
}
