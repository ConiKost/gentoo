# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

DESCRIPTION="A static, secure identd.  One source file only!"
HOMEPAGE="http://www.guru-group.fi/~too/sw/"
SRC_URI="http://www.guru-group.fi/~too/sw/identd.readme -> ${P}.readme
	http://www.guru-group.fi/~too/sw/releases/identd.c -> ${P}.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ppc ppc64 sparc x86"

src_unpack() {
	mkdir -p "${S}" || die
	edo cp "${DISTDIR}"/${P}.{c,readme} "${S}"
}

src_compile() {
	edo $(tc-getCC) ${CFLAGS} ${LDFLAGS} \
		-DTRG=\"${PN}\" -DUSE_UNIX_OS -DVERSION=\"${PV}\" \
		-o ${PN} ${P}.c
}

src_install() {
	dosbin ${PN}
	newdoc ${P}.readme identd.readme

	newinitd "${FILESDIR}"/fakeidentd.rc fakeidentd
	newconfd "${FILESDIR}"/fakeidentd.confd fakeidentd
}
