# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="meta package for databases"
HOMEPAGE="https://github.com/tgbugs/dockerfiles"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
#app-misc/elasticsearch  # skip due to license nonsense for now
dev-db/mariadb
dev-db/postgresql
dev-db/redict
"
_rdp=""; while IFS= read -r line || [[ -n "$line" ]]; do out="${line%%#*}"; out="${out%"${out##*[![:space:]]}"}"; _rdp+="${out}"$'\n'; done < <(printf '%s\n' "$RDEPEND"); RDEPEND="${_rdp}"
