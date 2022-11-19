# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Graphics API Capture and Replay Tools for Reconstructing Graphics Application Behavior"
HOMEPAGE="https://github.com/LunarG/gfxreconstruct"
SRC_URI="https://github.com/LunarG/gfxreconstruct/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

IUSE="+X wayland debug"
RDEPEND="
	X? (
		>=x11-libs/libxcb-1.15-r1
		>=x11-libs/xcb-util-keysyms-0.4.0-r2
		>=x11-libs/libXrandr-1.5.2
	)
	wayland? (
		>=dev-libs/wayland-1.21.0
	)
	>=sys-libs/zlib-1.2.12-r3
	>=app-arch/lz4-1.9.4
	>=app-arch/zstd-1.5.2-r3
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-3.10.2
	>=dev-util/vulkan-headers-1.3.224
	X? (
		>=x11-libs/libxcb-1.15-r1
		>=x11-libs/xcb-util-keysyms-0.4.0-r2
		>=x11-libs/libXrandr-1.5.2
	)
	wayland? (
		>=dev-libs/wayland-1.21.0
	)
	>=sys-libs/zlib-1.2.12-r3
	>=app-arch/lz4-1.9.4
	>=app-arch/zstd-1.5.2-r3
"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVULKAN_HEADER="/usr/include/vulkan/vulkan_core.h"
	)
	if use debug; then
		mycmakeargs+=(
			-DCMAKE_BUILD_TYPE=Debug
		)
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
