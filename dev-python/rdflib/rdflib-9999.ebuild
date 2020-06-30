# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6..9} )
PYTHON_REQ_USE="sqlite?,threads(+)"
inherit distutils-r1


if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/tgbugs/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	MY_PN=neu${PN}
	MY_P=${MY_PN}-${PV/_pre/.dev}  # 1.1.1_pre0 -> 1.1.1.dev0
	S=${WORKDIR}/${MY_P}
	SRC_URI="mirror://pypi/n/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="RDF library containing a triple store and parser/serializer"
HOMEPAGE="https://github.com/RDFLib/rdflib https://github.com/tgbugs/rdflib"
EGIT_REPO_URI="https://github.com/tgbugs/rdflib.git"

LICENSE="BSD"
SLOT="0"
IUSE="doc berkdb examples mysql redland sqlite test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	berkdb? ( dev-python/bsddb3[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	test? (
		dev-python/doctest-ignore-unicode[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.1-r1[${PYTHON_USEDEP}]
		dev-python/sparql-wrapper[${PYTHON_USEDEP}]
		)"

if [[ ${PV} == "9999" ]]; then
	src_prepare () {
		# replace package version to keep python quiet
		sed -i "s/__version__\ =\ .\+$/__version__ = \"9999.0.0+$(git rev-parse --short HEAD)\"/" ${PN}/__init__.py
		default
	}
else
	src_prepare () {
		mv ${S}/${MY_PN}.egg-info ${S}/${PN}.egg-info || die
		sed -i "s/${MY_PN}/${PN}/g" ${S}/*/{*.txt,PKG-INFO} || die
		sed -i "s/${MY_PN}/${PN}/g" ${S}/{*.py,PKG-INFO} || die
		default
	}
fi

python_prepare_all() {
	# Upstream manufactured .pyc files which promptly break distutils' src_test
	find -name "*.py[oc~]" -delete || die

	# Bug 358189; take out tests that attempt to connect to the network
	sed -e "/'--with-doctest',/d" -e "/'--doctest-extension=.doctest',/d" \
		-e "/'--doctest-tests',/d" -i run_tests.py || die

	sed -e "s: 'sphinx.ext.intersphinx',::" -i docs/conf.py || die

	# doc build requires examples folder at the upper level of docs
	if use doc; then
		cd docs || die
		ln -sf ../examples . || die
		cd ../ || die
	fi

	distutils-r1_python_prepare_all
}

python_compile_all() {
	# https://github.com/RDFLib/rdflib/issues/510
	if use doc; then
		einfo ""; einfo "Several warnings and Errors present in the build"
		einfo "For a complete build, it is required to install"
		einfo "github.com/gjhiggins/n3_pygments_lexer and"
		einfo "github.com/gjhiggins/sparql_pygments_lexer"
		einfo "outside portage via pip or by cloning. These have not been"
		einfo "given a tagged release by the author and are not in portage"
		einfo ""
		emake -C docs html
	fi
}

python_test() {
	# the default; nose with: --where=./ does not work for python3
	if python_is_python3; then
		pushd "${BUILD_DIR}/src/" > /dev/null
		"${PYTHON}" ./run_tests.py || die "Tests failed under ${EPYTHON}"
		popd > /dev/null
	else
		"${PYTHON}" ./run_tests.py || die "Tests failed under ${EPYTHON}"
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	if use examples ; then
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
