# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for NIF-Ontology and SPARC Knowledge Graph development"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nest"

RDEPEND="
app-arch/zip
app-misc/protege-bin
app-misc/screen
app-misc/yq
app-text/pandoc-cli
dev-java/robot-bin
dev-libs/redland
dev-lisp/sbcl
dev-node/apinat-converter  # needed for apinatomy;
dev-python/nifstd-tools
dev-python/seaborn  # FIXME was for thesis maybe? queries.org but commented out?;
dev-util/shellcheck
media-gfx/inkscape
tgbugs-meta/kg-release-meta
tgbugs-meta/racket-meta
tgbugs-meta/sparcron-meta  # pulls in rabbitmq-server
tgbugs-meta/tex-meta
nest? (
	acct-group/docker
	app-containers/docker-cli
)
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
