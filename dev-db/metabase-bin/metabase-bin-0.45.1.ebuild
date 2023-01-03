# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
IUSE="-postgres -mysql"

COMMON_DEP=""

IDEPEND="
	acct-group/metabase
	acct-user/metabase"

RDEPEND=">=virtual/jre-1.8
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql:= )"
DEPEND=">=virtual/jdk-1.8"

PACKAGE="${PN}-${SLOT}"
PACKAGE_SHARE="/usr/share/${PACKAGE}"
PACKAGE_FOLDER="/usr/share/${MY_PN}"

EXECUTABLE="/usr/bin/${MY_PN}"

pkg_setup() {
	if ( use postgres && use mysql ); then
		ewarn "metabase can only use a single backend at a time"
		die "mysql and postgres use flags are mutually exclusive"
	fi
}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${A}" "${S}"
}

src_install() {
	keepdir "/var/log/${MY_PN}"
	fowners ${MY_PN}:${MY_PN} "/var/log/${MY_PN}"
	newinitd "${FILESDIR}/metabase.rc" ${MY_PN}
	newconfd "${FILESDIR}/metabase.confd" ${MY_PN}

	insinto /etc
	newins "${FILESDIR}/${MY_PN}.conf.base" ${MY_PN}.conf
	CFG="${ED}/etc/${MY_PN}.conf"
	if ( use mysql || use postgres ); then
		if use mysql; then
			echo "# mysql" >> "${CFG}"
			echo "MB_DB_TYPE=mysql" >> "${CFG}"
			echo "MB_DB_PORT=3306" >> "${CFG}"
		else
			echo "# postgres" >> "${CFG}"
			echo "MB_DB_TYPE=postgres" >> "${CFG}"
			echo "MB_DB_PORT=5432" >> "${CFG}"
		fi
		echo "# database" >> "${CFG}"
		echo "MB_DB_HOST=localhost" >> "${CFG}"
		echo "MB_DB_DBNAME=metabase" >> "${CFG}"
		echo "MB_DB_USER=metabase" >> "${CFG}"
		echo "MB_DB_PASS=" >> "${CFG}"
	else
		echo "# default h2 embedded database" >> "${CFG}"
		echo "MB_DB_TYPE=h2" >> "${CFG}"
		echo "MB_DB_FILE=/var/lib/${MY_PN}/h2.db" >> "${CFG}"
	fi
	echo  >> "${CFG}"
	fperms 0600 /etc/${MY_PN}.conf

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

pkg_config() {
	einfo "Configuring metabase ..."
	if use postgres; then
		einfo "Creating metabase postgres user ..."
		su - postgres -c "psql -c \"CREATE ROLE metabase LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE\""
		su - postgres -c "psql -c \"CREATE DATABASE metabase WITH OWNER = 'metabase' ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE='en_US.UTF-8' CONNECTION LIMIT = -1\""
	fi
}
