# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2 java-utils-2

EGIT_REF="77a80d8"

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Math functions for Clojure's numeric tower"
HOMEPAGE="https://clojure.org/ https://github.com/clojure/math.numeric-tower"
SRC_URI="https://github.com/clojure/${MY_PN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86-linux"
IUSE=""

CDEPEND="dev-java/ant:0"
RDEPEND=">=virtual/jre-1.8:*"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.8:*"

S="${WORKDIR}/${MY_PN}-${MY_P}"

src_prepare() {
	default
	cp "${FILESDIR}/build.xml" . || die
}

src_compile() {
	eant jar -Dmaven.build.finalName=${MY_P}
}

src_install() {
	java-pkg_newjar "target/${MY_P}.jar"
	dodoc README.md
}
