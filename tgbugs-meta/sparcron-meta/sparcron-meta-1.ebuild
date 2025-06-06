# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for sparcur sparcron pipelines"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
dev-db/redict
#dev-python/pip  # FIXME do we still need pip for debug (pudb)?
dev-python/sparcur
net-misc/rabbitmq-server
www-servers/uwsgi
x11-misc/xdg-user-dirs
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
