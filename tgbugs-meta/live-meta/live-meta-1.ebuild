# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for live ebuilds"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

# FIXME I suspect we don't need this one because
# we use it when not installed and sets are faster
RDEPEND="
dev-java/robot-bin
dev-java/scigraph-bin
dev-python/interlex
dev-python/sparcur
"
