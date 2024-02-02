# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit meson distutils-r1 multilib-minimal flag-o-matic

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more. AMDGPU testing branch"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${PV}/MangoHud-v${PV}-Source.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}"/MangoHud-v${PV}

PATCHES=(
	# https://github.com/flightlessmango/MangoHud/issues/1084
    # "${FILESDIR}/0001-vulkan-manifest-set-cpu_family-in-layer-name.patch"
)

KEYWORDS="-* ~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="+dbus glvnd +X xnvctrl wayland -video_cards_nvidia +video_cards_amdgpu tools"
REQUIRED_USE="
	xnvctrl? ( video_cards_nvidia )
"

BDEPEND="
	dev-python/mako[${PYTHON_USEDEP}]
	dev-build/ninja
"
DEPEND="
	!games-util/mangohud
	tools? (
		>=media-libs/glfw-3.0.0
		media-libs/glew
	)
	dev-util/glslang
	>=dev-util/vulkan-headers-1.2
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	video_cards_amdgpu? (
		x11-libs/libdrm[video_cards_amdgpu]
	)
	glvnd? (
		media-libs/libglvnd[${MULTILIB_USEDEP}]
	)
	dbus? ( 
		sys-apps/dbus[${MULTILIB_USEDEP}] 
	)
	X? ( 
		x11-libs/libX11[${MULTILIB_USEDEP}] 
	)
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
"

RDEPEND="${DEPEND}"

multilib_src_configure() {
	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Dinclude_doc=false
		-Dwith_nvml=$(usex video_cards_nvidia enabled disabled)
		-Dwith_xnvctrl=$(usex xnvctrl enabled disabled)
		-Dwith_x11=$(usex X enabled disabled)
		-Dwith_wayland=$(usex wayland enabled disabled)
		-Dwith_dbus=$(usex dbus enabled disabled)
	)
	if multilib_is_native_abi; then
		emesonargs+=(
			-Dmangoapp=$(usex tools true false)
			-Dmangohudctl=$(usex tools true false)
			-Dmangoapp_layer=$(usex tools true false)
		)
	fi
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	dodoc "${S}/data/MangoHud.conf"

	einstalldocs
}

pkg_postinst() {
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}