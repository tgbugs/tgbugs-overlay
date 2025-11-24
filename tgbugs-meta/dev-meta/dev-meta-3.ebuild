# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for tgbugs dev environment"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
tgbugs-meta/db-meta
tgbugs-meta/debug-meta
tgbugs-meta/docker-meta
tgbugs-meta/dynapad-meta
tgbugs-meta/emacs-testing-meta
tgbugs-meta/emacs-pkgs-meta
tgbugs-meta/kg-dev-meta
tgbugs-meta/lisp-meta
tgbugs-meta/python-testing-meta
tgbugs-meta/scheme-meta
tgbugs-meta/shell-meta
"
RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
