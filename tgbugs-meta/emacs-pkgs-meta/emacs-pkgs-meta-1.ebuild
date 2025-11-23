# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for emacs packages"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
tgbugs-meta/emacs-pkgs-min-meta
app-emacs/tramp-theme
app-emacs/quelpa
app-emacs/quelpa-use-package
#app-emacs/ansi-color  # built-in
 #app-emacs/tty-format  # manual
app-emacs/arduino-mode
#app-emacs/auto-complete  # built-in
app-emacs/bison-mode
app-emacs/cider
 app-emacs/clojure-mode
 #app-emacs/ac-cider  # no package ???
 app-emacs/clojure-mode-extra-font-locking
app-emacs/color-theme-modern
#app-emacs/conf-mode  # built-in ???
app-emacs/crdt
app-emacs/crontab-mode
app-emacs/csv-mode
app-emacs/cypher-mode
#app-emacs/dired  # built-in
app-emacs/docker
app-emacs/dockerfile-mode
app-emacs/docopt
#app-emacs/electric-indent  # built-in
app-emacs/ebuild-mode
app-emacs/erlang
app-emacs/ess
app-emacs/eval-sexp-fu
#app-emacs/evil  # minimal
 #app-emacs/evil-loader  # not a package
 app-emacs/evil-org
 app-emacs/evil-paredit
 app-emacs/evil-collection
app-emacs/exec-path-from-shell
#app-emacs/explain-pause-mode  # quelpa git
app-emacs/fill-column-indicator
#app-emacs/flycheck  # minimal
 app-emacs/flycheck-package
#app-emacs/flyspell  # built-in
app-emacs/forge
#app-emacs/gcmh  # does not work with undo-tree
app-emacs/geiser
 app-emacs/geiser-chez
 app-emacs/geiser-gambit
 app-emacs/geiser-guile
 #app-emacs/geiser-racket  # broken
app-emacs/git-link
app-emacs/glsl-mode
app-emacs/glue
app-emacs/gnuplot
app-emacs/gnuplot-mode
#app-emacs/go-mode  # not go-lang it seems ?
app-emacs/haskell-mode
#app-emacs/helm-swoop  # FIXME no longer on melpa
app-emacs/highlight-numbers
app-emacs/hl-todo
app-emacs/htmlize
app-emacs/hy-mode
#app-emacs/jdee  # ded note says to use lsp-java
app-emacs/json-mode
app-emacs/js2-mode
app-emacs/julia-mode
app-emacs/julia-repl
app-emacs/jupyter
 app-emacs/simple-httpd
 app-emacs/websocket
app-emacs/keychain-environment
#app-emacs/libyaml  # quelpa github
#app-emacs/lisp-mode  # built-in
 #app-emacs/datum-comments  # git
 app-emacs/slime
 app-emacs/ac-slime
app-emacs/lsp-java
app-emacs/lua-mode
 #app-emacs/magithub  # primary use case handle by git-link
#app-emacs/markdown-mode  # minimal
 app-emacs/edit-indirect
app-emacs/meson-mode
app-emacs/nginx-mode
app-emacs/ninja-mode
#app-emacs/obo-mode  # git
#app-emacs/org-mode  # minimal
 #app-emacs/org-contrib  # git
 #app-emacs/org-eldoc  # git
 #app-emacs/org-expiry  # git
 app-emacs/engrave-faces
 #app-emacs/org-books  # pulls in helm-org which is broken due to use of easy-menu-add-item ... possibly because helm is not installed?
 #app-emacs/elgannt  # quelpa github
 #app-emacs/lentic  # fun but too experimental
 #app-emacs/ob-async  # broken
 #app-emacs/ob-cypher  # git
 app-emacs/ob-hy
 #app-emacs/oc  # org built-in
 #app-emacs/oc-biblatex  # git
 app-emacs/orgit
 app-emacs/org-make-toc
 app-emacs/org-ql
 app-emacs/org-ref
 app-emacs/ox-pandoc
 app-emacs/org-sync
 #app-emacs/orgstrap  # git XXX though technically also melpa
 app-emacs/ox-gfm
 #app-emacs/ob-racket  # manual (sigh)
 #app-emacs/ob-clojure  # org built-in
 #app-emacs/ow  # git
#app-emacs/outline  # built-in
app-emacs/outshine
app-emacs/package-lint
app-emacs/paredit
app-emacs/polymode
 #app-emacs/polymode-org  # seems broken?
app-emacs/pq
#app-emacs/python  # built-in
 app-emacs/elpy
 #app-emacs/pycoverage  # quelpa github
#app-emacs/reval  # git
#app-emacs/rpm-spec-mode  # broken
app-emacs/rust-mode
app-emacs/scala-mode
#app-emacs/scheme  # built-in
#app-emacs/sh-script  # built-in
app-emacs/ssh-config-mode  # ::melpa only
app-emacs/scribble-mode
#app-emacs/sql  # built-in
#app-emacs/symex  # removed from one of them elpas apparently
app-emacs/transient #::gentoo
#app-emacs/tree-sitter  # experimental and pulls in insane deps
 #app-emacs/tree-sitter-langs
app-emacs/trie
#app-emacs/ttl-mode  # git
app-emacs/typescript-mode
app-emacs/vdiff
app-emacs/vimrc-mode
#app-emacs/which-func  # built-in
"

RDEPEND="$(echo "${RDEPEND}" | "${EPREFIX}"/bin/sed 's/[[:blank:]]*#.*$//')"
