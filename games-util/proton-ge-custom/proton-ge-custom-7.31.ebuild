EAPI=8

_internal_name=GE-Proton${PV//./-}
DESCRIPTION="A fancy custom distribution of Valves Proton with various patches"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${_internal_name}/${_internal_name}.tar.gz -> ${P}.tar.gz"

LICENSE=('BSD' 'LGPL' 'zlib' 'MIT' 'MPL' 'OFL' 'Proton')
SLOT="${PV}"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
IUSE="kde gnome"

RDEPEND="
	media-libs/mesa[vulkan,abi_x86_32]
	media-libs/vulkan-loader[abi_x86_32]

	dev-lang/python-exec
	media-libs/vulkan-loader[abi_x86_32]
	virtual/libusb[abi_x86_32]
	media-libs/openal[abi_x86_32]
	x11-libs/libva[abi_x86_32]
	media-video/ffmpeg
	media-libs/speex[abi_x86_32]
	media-libs/libtheora[abi_x86_32]
	x11-libs/libvdpau[abi_x86_32]
	media-libs/gst-plugins-bad[abi_x86_32]
	media-libs/gst-plugins-base[abi_x86_32]
	media-libs/libjpeg-turbo[abi_x86_32]
	dev-libs/libgudev[abi_x86_32]
	media-libs/flac[abi_x86_32]
	media-sound/mpg123[abi_x86_32]

	kde? ( kde-apps/kdialog )
	gnome? ( gnome-extra/zenity )

	app-emulation/winetricks
	virtual/wine[abi_x86_32]
	games-util/steam-launcher"

QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	dodir "/usr/share/steam/compatibilitytools.d/${_internal_name}"
	mv "${S}/${_internal_name}/compatibilitytool.vdf" "${D}/usr/share/steam/compatibilitytools.d/${_internal_name}" || die
	sed -i "s%\"install_path\" \".\"%\"install_path\" \"/opt/proton-ge-custom/${_internal_name}\"%" "${D}/usr/share/steam/compatibilitytools.d/${_internal_name}/compatibilitytool.vdf" || die

	dodir "/opt/proton-ge-custom"
	mv "${S}/${_internal_name}" "${D}/opt/proton-ge-custom" || die
}
