# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Augmented pathlib."
HOMEPAGE="https://github.com/tgbugs/augpathlib"

LICENSE="MIT"
SLOT="0"
IUSE="dev test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/GitPython[${PYTHON_USEDEP}]
	>=dev-python/pexpect-4.7.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxattr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	|| ( sys-apps/file[python,${PYTHON_USEDEP}] dev-python/python-magic[${PYTHON_USEDEP}] )
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_test() {
	git config --global user.email "${USER}@ebuild-testing.${HOSTNAME}"
	git config --global user.name "Portage Testing"
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}
