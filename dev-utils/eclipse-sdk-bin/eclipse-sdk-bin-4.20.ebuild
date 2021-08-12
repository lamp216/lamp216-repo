# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

BUILD_DATE="202106111600"
DESCRIPTION="Eclipse is an integrated development environment used in computer programming. It contains a base workspace and an extensible plug-in system for customizing the environment."
HOMEPAGE="https://www.eclipse.org/"
SRC_URI="https://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops4/R-${PV}-${BUILD_DATE}/eclipse-SDK-${PV}-linux-gtk-x86_64.tar.gz&r=1 -> ${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-java/openjdk-bin-11.0.11_p9-r1
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/eclipse

QA_PREBUILT="opt/${P}/*"

src_install(){
	exeinto /opt/${P}
	doexe eclipse
	insinto /opt/${P}
	doins -r artifacts.xml dropins plugins configuration features p2 readme
	dosym "/opt/${P}/eclipse" "usr/bin/eclipse"
	domenu "${FILESDIR}"/${PN}.desktop
	newicon "${FILESDIR}/eclipse.png" "eclipse.png"
}
