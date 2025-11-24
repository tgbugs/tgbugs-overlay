# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for minimal emacs packages"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
app-emacs/csv-mode
app-emacs/evil
app-emacs/flycheck
app-emacs/jupyter
app-emacs/magit
app-emacs/markdown-mode
app-emacs/ob-cypher  # git
app-emacs/org-mode
app-emacs/orgstrap
app-emacs/powershell
app-emacs/racket-mode
app-emacs/rainbow-delimiters
app-emacs/sparql-mode  # git
app-emacs/undo-tree
app-emacs/vterm
app-emacs/yaml-mode
app-emacs/sly
 app-emacs/ac-sly
 app-emacs/sly-repl-ansi-color
"

RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
