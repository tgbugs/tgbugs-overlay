# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	SRC_URI="
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/6bf13c6d392f472fa9f18b92f41da3a196d4c9fc/ttl/phenotype-core.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/6bf13c6d392f472fa9f18b92f41da3a196d4c9fc/ttl/phenotype-indicators.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/8b5e640fa19b59ea38363980ac5a6d1e9ae57e68/ttl/phenotypes.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/5733d5374c98cd66e05817454defbb96a1320fbd/ttl/generated/part-of-self.ttl
	"
	EGIT_REPO_URI="https://github.com/tgbugs/pyontutils.git"
	inherit git-r3
	KEYWORDS=""
else
	inherit pypi
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A data model for neuron types."
HOMEPAGE="https://github.com/tgbugs/pyontutils/tree/master/neurondm"

LICENSE="MIT"
SLOT="0"
IUSE="dev models notebook test"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/hyputils-0.0.8[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.27[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	models? (
		>=dev-python/nifstd-tools-0.0.6[${PYTHON_USEDEP}]
	)
	notebook? (
		dev-python/jupyter[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]]; then
	S="${S}/${PN}"
	src_prepare () {
		mkdir resources || die
		cp ${DISTDIR}/*.ttl resources || die
		# replace package version to keep python quiet
		sed -i "s/__version__.\+$/__version__ = '9999.0.0+$(git rev-parse --short HEAD)'/" ${PN}/__init__.py
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
