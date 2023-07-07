# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="ApiNATOMY model converter"
HOMEPAGE="https://github.com/open-physiology/open-physiology-viewer"
EGIT_REPO_URI="https://github.com/open-physiology/open-physiology-viewer.git"

LICENSE="Apache-2.0"
SLOT="9999"
KEYWORDS=""

BDEPEND="
	>=net-libs/nodejs-18"

RDEPEND="
	net-libs/nodejs"

src_unpack() {
	# NOTE for this to work you must have run the command npm with no arguments
	# by itself as root at least once, otherwise npm will continually try to
	# create /etc/npm, this is a bug in the gentoo patch for node which doesn't
	# correctly handle the fact that the code it is patching assumes that the
	# user will always have permission to try to mkdir, however in here that is
	# a sandbox violation
	git-r3_src_unpack
	ewarn "Running npm install in src_unpack. This violates various security assumptions. You have been warned."
	pushd ${S}
	npm install --legacy-peer-deps || die
	pushd wrapper
	npm install --legacy-peer-deps || die
	popd
	popd
}

src_prepare () {
	# move modules inside bin to simplify packaging later, node will still find it
	mv ${S}/wrapper/node_modules ${S}/wrapper/bin/ || die
	default
}

src_configure () {
	# change the conver path in wrapper/bin/model/filehandler.js
	# to point to ./converter directly since we relocate it below
	sed -i "s,require('../../../dist/converter'),require('./converter')," wrapper/bin/model/filehandler.js || die
}

src_compile() {
	npm run build || die
	mv ./dist/converter.js wrapper/bin/model/
}

src_install() {
	INSINTO=/usr/lib64/node_modules/apinat
	dodir ${INSINTO}
	cp -Rp ${S}/wrapper/bin ${ED}${INSINTO}
	dosym ${INSINTO}/bin/converter.js /usr/bin/apinat-converter
}
