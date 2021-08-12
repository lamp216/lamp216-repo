# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Easily manage wineprefix using environments"
HOMEPAGE="https://github.com/bottlesdevs/Bottles"
SRC_URI="https://github.com/bottlesdevs/Bottles/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-util/meson
		dev-util/ninja
		>=dev-lang/python-3.7.11:=
		dev-libs/glib
		>=gui-libs/libhandy-1.0.2"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/Bottles-${PV}"

src_configure() {
	mkdir build
	meson_src_configure
}

src_compile(){
	meson_src_compile
}

src_install(){
	meson_src_install
}
