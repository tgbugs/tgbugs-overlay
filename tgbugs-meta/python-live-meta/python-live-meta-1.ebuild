# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for python live ebuilds"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
=dev-python/augpathlib-9999
=dev-python/clifn-9999
=dev-python/htmlfn-9999
=dev-python/hyputils-9999
=dev-python/idlib-9999
=dev-python/interlex-9999
=dev-python/neurondm-9999
=dev-python/nifstd-tools-9999
=dev-python/ontquery-9999
=dev-python/orthauth-9999
=dev-python/protcur-9999
=dev-python/pyontutils-9999
=dev-python/pysercomb-9999
=dev-python/scibot-9999  # FIXME not ready?;
=dev-python/sparcur-9999
=dev-python/sxpyr-9999
=dev-python/ttlser-9999
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
