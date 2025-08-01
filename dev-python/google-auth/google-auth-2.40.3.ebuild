# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Google Authentication Library"
HOMEPAGE="
	https://github.com/googleapis/google-auth-library-python/
	https://pypi.org/project/google-auth/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	dev-python/cachetools[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.7[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/rsa-3.1.4[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aioresponses[${PYTHON_USEDEP}]
		>=dev-python/cryptography-38.0.3[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		>=dev-python/pyjwt-2.0[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
		dev-python/pyu2f[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# unpin deps
	sed -i -e 's:,<[0-9.]*::' setup.py || die
}

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}

python_test() {
	local EPYTEST_DESELECT=(
		# tests are broken with up-to-date pyopenssl
		tests/transport/test__mtls_helper.py::TestDecryptPrivateKey::test_success
	)
	local EPYTEST_IGNORE=(
		# these are compatibility tests with oauth2client
		# disable them to unblock removal of that package
		tests/test__oauth2client.py
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	distutils_write_namespace google
	epytest -p asyncio
}
