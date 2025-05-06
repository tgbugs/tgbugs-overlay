# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for sparcur sparcron pipelines"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS=""

LIVE_DEPEND="
=dev-python/augpathlib-9999
=dev-python/clifn-9999
=dev-python/htmlfn-9999
=dev-python/hyputils-9999
=dev-python/idlib-9999
=dev-python/ontquery-9999
=dev-python/orthauth-9999
=dev-python/protcur-9999
=dev-python/pyontutils-9999
=dev-python/pysercomb-9999
=dev-python/sparcur-9999
=dev-python/sxpyr-9999
=dev-python/ttlser-9999
"

RDEPEND="${LIVE_DEPEND}
dev-db/redict
#dev-python/pip  # FIXME do we still need pip for debug (pudb)?
dev-python/sparcur
net-misc/rabbitmq-server
www-servers/uwsgi
x11-misc/xdg-user-dirs
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
