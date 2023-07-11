# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for dev-db/blazegraph-bin"
ACCT_USER_ID="-1"
ACCT_USER_SHELL=/bin/bash
ACCT_USER_HOME=/var/lib/blazegraph
ACCT_USER_HOME_PERMS=0750
ACCT_USER_GROUPS=( blazegraph )

acct-user_add_deps
