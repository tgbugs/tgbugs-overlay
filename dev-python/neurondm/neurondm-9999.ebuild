# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	SRC_URI="
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/5e3cf20701075ca2778a1468deacb68622fefd41/ttl/phenotype-core.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/a39b8ff172cabeaa3edc0fde5a607467d428d930/ttl/phenotype-indicators.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/a1688ab020b3e219c47842d990593b0bab084b51/ttl/phenotypes.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/19160c83498cf0facc7e36e6092bddd1cc363053/ttl/generated/part-of-self.ttl
	"
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A data model for neuron types."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/neurondm"

LICENSE="MIT"
SLOT="0"
IUSE="dev notebook test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/hyputils-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.6[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	notebook? (
		dev-python/jupyter[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
	src_prepare () {
		mkdir resources || die
		cp ${DISTDIR}/*.ttl resources || die
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0.$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
		default
	}
fi

python_install_all() {
	local DOCS=( README* docs/* )
	distutils-r1_python_install_all
}

python_test() {
	if [[ ${PV} == "9999" ]]; then
		git remote add origin ${EGIT_REPO_URI}
		git checkout -B testing
	fi
	distutils_install_for_testing
	esetup.py install_data --install-dir="${TEST_DIR}"
	cd "${TEST_DIR}" || die
	cp -r "${S}/test" . || die
	cp "${S}/setup.cfg" . || die
	PYTHONWARNINGS=ignore pytest -v --color=yes || die "Tests fail with ${EPYTHON}"
}
