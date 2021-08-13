# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Modular status bar for dwm written in c."
HOMEPAGE="https://github.com/torrinfail/dwmblocks"
SRC_URI="https://github.com/perfectime94/dwmblocks/archive/refs/tags/${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="statuscmd"

RDEPEND="x11-libs/libX11"

DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_prepare() {
	default

	if use statuscmd; then
		eapply -p1 "${FILESDIR}/${PN}-statuscmd-${PV}.patch"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}

pkg_postinst() {
	if use statuscmd; then
		elog "The statuscmd needs the statuscmd-signal dwm patch to work."
		elog "Not using this patch with the statuscmd use flag enabled"
		elog "could result in the bar closing when clicked."
		elog "link of the dwm patch: https://dwm.suckless.org/patches/statuscmd/"
	fi
}
