# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ecm

DESCRIPTION="Core control application."
HOMEPAGE="https://gitlab.com/corectrl/corectrl"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/${PN}/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0/9999"
IUSE="+pcinames test"
REQUIRED_USE=""
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtcharts:5[qml]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	sys-auth/polkit
	>=dev-libs/quazip-1.0
	>=dev-libs/pugixml-1.11
	>=dev-libs/spdlog-1.4
	dev-libs/botan:3
	test? (
		>=dev-cpp/catch-3:0
		>=dev-cpp/trompeloeil-40
	)
"
RDEPEND="
	${DEPEND}
	pcinames? ( sys-apps/hwdata )
"
BDEPEND="
	dev-build/cmake
	virtual/pkgconfig
	dev-qt/linguist-tools:5[qml]
"

PATCHES=(
)

S=${WORKDIR}/${PN}-v${PV}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
