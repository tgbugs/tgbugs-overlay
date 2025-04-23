# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for docker bootstrap"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+docker podman"

RDEPEND="
dev-vcs/git
app-misc/screen
app-editors/emacs
docker? (
	app-containers/docker
	app-containers/docker-cli
	app-containers/docker-buildx
)
podman? (
	app-containers/podman
)
"
