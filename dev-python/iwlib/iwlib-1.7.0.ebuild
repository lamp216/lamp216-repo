# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="iwlib library for Python, for interacting with wireless devices."
HOMEPAGE="https://github.com/nathan-hoad/python-iwlib/"
SRC_URI="https://github.com/nhoad/python-iwlib/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""
RDEPEND="${DEPEND}"
DEPEND="
	net-wireless/wireless-tools
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
"

S="${WORKDIR}/python-${P}"

python_compile() {
	local CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}

	distutils-r1_python_compile
}