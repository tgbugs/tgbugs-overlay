# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )

PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Framework for fast, easy, and documented API development with Flask"
HOMEPAGE="https://github.com/python-restx/flask-restx"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dev doc test"
RESTRICT="
	!test? ( test )
"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/aniso8601-0.82[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev? (
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/tox[${PYTHON_USEDEP}]
	)
	doc? (
		=dev-python/alabaster-0.7.12[${PYTHON_USEDEP}]
		=dev-python/sphinx-5.3.0[${PYTHON_USEDEP}]
		=dev-python/sphinx-issues-3.0.1[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/blinker[${PYTHON_USEDEP}]
		=dev-python/faker-2.0.0[${PYTHON_USEDEP}]
		=dev-python/mock-3.0.5[${PYTHON_USEDEP}]
		=dev-python/invoke-1.3.0[${PYTHON_USEDEP}]
		=dev-python/pytest-7.0.1[${PYTHON_USEDEP}]
		=dev-python/pytest-benchmark-3.4.1[${PYTHON_USEDEP}]
		=dev-python/pytest-cov-4.0.0[${PYTHON_USEDEP}]
		=dev-python/pytest-flask-1.2.0[${PYTHON_USEDEP}]
		=dev-python/pytest-mock-3.6.1[${PYTHON_USEDEP}]
		=dev-python/pytest-profiling-1.7.0[${PYTHON_USEDEP}]
		=dev-python/invoke-1.7.3[${PYTHON_USEDEP}]
		=dev-python/twine-3.8.0[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
	)
"
