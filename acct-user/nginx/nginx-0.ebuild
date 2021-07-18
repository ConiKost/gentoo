# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="A user for www-servers/nginx"

ACCT_USER_GROUPS=( "nginx" )
ACCT_USER_HOME="/var/lib/nginx"
ACCT_USER_ID="82"

acct-user_add_deps
