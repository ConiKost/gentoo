# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome.org meson vala xdg

DESCRIPTION="Simple GObject game controller library"
HOMEPAGE="https://gitlab.gnome.org/aplazas/libmanette"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv x86"
IUSE="gtk-doc +introspection +udev +vala test"
RESTRICT="!test? ( test )"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.50:2
	udev? ( dev-libs/libgudev[introspection?] )
	dev-libs/libevdev
	introspection? ( >=dev-libs/gobject-introspection-1.56:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	gtk-doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.3
	)
	vala? ( $(vala_depend) )
	virtual/pkgconfig
"

src_prepare() {
	xdg_src_prepare
	use vala && vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Ddemos=false
		$(meson_use test build-tests)
		-Dinstall-tests=false
		$(meson_use gtk-doc doc)
		$(meson_use introspection)
		$(meson_use vala vapi)
		$(meson_feature udev gudev)
	)
	meson_src_configure
}
