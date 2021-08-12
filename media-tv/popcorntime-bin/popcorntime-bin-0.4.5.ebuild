# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="Popcorn Time is a multi-platform, free software BitTorrent client that includes an integraded media player"
HOMEPAGE="https://github.com/popcorn-official"
SRC_URI="amd64? ( https://github.com/popcorn-official/popcorn-desktop/releases/download/v${PV}/Popcorn-Time-${PV}-linux64.zip )
		x86?	( https://github.com/popcorn-official/popcorn-desktop/releases/download/v${PV}/Popcorn-Time-${PV}-linux32.zip )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="splitdebug strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="
		/opt/${PN}/lib/*
		/opt/${PN}/node_modules/*
		/opt/${PN}/src/*
"

src_install() {
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/Popcorn-Time
	insinto /usr/share/applications
	dosym "/opt/${PN}/Popcorn-Time" "usr/bin/popcorntime"
	domenu "${FILESDIR}"/${PN}.desktop
	newicon "src/app/images/icon.png" "popcorntime.png"
}

pkg_postinst(){
	elog "${PN} ${PV} installed successfully in your system"
}
