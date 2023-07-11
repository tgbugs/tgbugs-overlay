# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{9..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]]; then
	SRC_URI="
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/8e208cb8587c2a4a0c78edbe4042fe47308f823d/ttl/phenotype-core.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/ec7ad867a4aa529b3f24d10012dfaa5ce9a15620/ttl/phenotype-indicators.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/9c86b26ac3fdcd8cf063e979c95e27417e3ec355/ttl/phenotypes.ttl
	https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/0502319c5eac2412bb816a9d8b342450163fc25a/ttl/generated/part-of-self.ttl
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

RDEPEND="
	>=dev-python/hyputils-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/pyontutils-0.1.32[${PYTHON_USEDEP}]
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
