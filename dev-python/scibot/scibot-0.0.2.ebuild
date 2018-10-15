# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1 user

DESCRIPTION="Web annotation curation pipeline"
HOMEPAGE="https://github.com/SciCrunch/scibot"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/curio[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	>=dev-python/hyputils-0.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.0.4[${PYTHON_USEDEP}]
	dev-python/gevent[$(python_gen_usedep python3_{6,7})]
	www-servers/gunicorn[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	ebegin "Creating scibot user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 "/var/lib/${PN}" ${PN}
	eend $?
}

src_install() {
	keepdir "/var/log/${PN}"
	fowners ${PN}:${PN} "/var/log/${PN}"
	newinitd "${FILESDIR}/scibot-bookmarklet.rc" scibot-bookmarklet
	newconfd "${FILESDIR}/scibot-bookmarklet.confd" scibot-bookmarklet
	distutils-r1_src_install
}

pkg_postinst() {
	ewarn "In order to run scibot you need to set the hypothes.is"
	ewarn "group, user, and api token in /etc/conf.d/scibot-bookmarklet"
}
