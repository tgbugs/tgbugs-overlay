# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit distutils-r1

DESCRIPTION="Subcommand REPL for click apps"
HOMEPAGE="https://github.com/click-contrib/click-repl"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
}
