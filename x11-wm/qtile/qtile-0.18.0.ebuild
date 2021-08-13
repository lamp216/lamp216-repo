# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="A full-featured, hackable tiling window manager written and configured in Python"
HOMEPAGE="http://www.qtile.org/e"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${PN}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRIC="test"

IUSE="dbus wayland X widget-wlan widget-calendar widget-wallpaper widget-sensors widget-volume widget-pulse-volume widget-nvidia-sensors widget-net widget-check-updates widget-mpris widget-mpd widget-moc widget-memory widget-launchbar widget-keyboardlayout widget-keyboardkbdd widget-imap widget-idlerpg widget-cpu widget-cmus widget-bluetooth"

RDEPEND="
		>=dev-python/cffi-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/xcffib-0.10.1[${PYTHON_USEDEP}]
		X?	(
				x11-base/xorg-server
				x11-libs/pango
				x11-libs/cairo
				>=dev-python/cairocffi-0.9.0[${PYTHON_USEDEP}]
				dev-python/pycairo[${PYTHON_USEDEP}]
			)
		dbus?	(
				sys-apps/dbus
				dev-python/python-dbus-next[${PYTHON_USEDEP}]
				)
		wayland?	(
				dev-libs/wayland
				gui-libs/wlroots
				dev-python/pywlroots
					)
		widget-wlan? ( dev-python/iwlib[${PYTHON_USEDEP}] )
		widget-calendar?	(
				dev-python/httplib2[${PYTHON_USEDEP}]
				dev-python/python-dateutil[${PYTHON_USEDEP}]
							)
		widget-wallpaper? (	media-gfx/feh )
		widget-sensors? ( sys-apps/lm-sensors )
		widget-nvidia-sensors? ( x11-drivers/nvidia-drivers )
		widget-volume? ( media-sound/alsa-utils )
		widget-pulse-volume? (	media-sound/pulseaudio )
		widget-net? ( dev-python/psutil )
		widget-check-updates? ( app-portage/eix )
		widget-bluetooth?
			(	net-wireless/bluez
				dev-python/python-dbus-next[${PYTHON_USEDEP}]
			)
		widget-cmus? ( media-sound/cmus )
		widget-cpu? ( dev-python/psutil )
		widget-idlerpg? ( dev-python/xmltodict )
		widget-imap?
			(
				gnome-base/gnome-keyring
				dev-python/keyring
			)
		widget-keyboardkbdd? ( dev-python/python-dbus-next[${PYTHON_USEDEP}] )
		widget-keyboardlayout? ( x11-apps/setxkbmap )
		widget-launchbar? ( dev-python/pyxdg )
		widget-memory? ( dev-python/psutil )
		widget-moc? ( media-sound/moc )
		widget-mpd? ( media-sound/mpd )
		widget-mpris? ( dev-python/python-dbus-next[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare(){
	if ! use widget-wlan ; then
		(
			sed -i '/"Wlan": "wlan",/d' libqtile/widget/__init__.py
			rm libqtile/widget/wlan.py*
		)
	fi
	if ! use widget-calendar ; then
		(
			sed -i '/"KhalCalendar": "khal_calendar",/d' libqtile/widget/__init__.py
			rm libqtile/widget/khal_calendar.py*
		)
	fi
	if ! use widget-wallpaper ; then
		(
			sed -i '/"Wallpaper": "wallpaper",/d' libqtile/widget/__init__.py
			rm libqtile/widget/wallpaper.py*
		)
	fi
	if ! use widget-volume ; then
		(
			sed -i '/"Volume": "volume",/d' libqtile/widget/__init__.py
			rm libqtile/widget/volume.py*
		)
	fi
	if ! use widget-sensors ; then
		(
			sed -i '/"Sensors": "sensors",/d' libqtile/widget/__init__.py
			rm libqtile/widget/sensors.py*
		)
	fi
	if ! use widget-pulse-volume ; then
		(
			sed -i '/"PulseVolume": "pulse_volume",/d' libqtile/widget/__init__.py
			rm libqtile/widget/pulse_volume.py*
			rm libqtile/widget/pulseaudio_ffi.py*
		)
	fi
	if ! use widget-nvidia-sensors ; then
		(
			sed -i '/"NvidiaSensors": "nvidia_sensors",/d' libqtile/widget/__init__.py
			rm libqtile/widget/nvidia_sensors.py*
		)
	fi
	if ! use widget-net ; then
		(
			sed -i '/"Net": "net",/d' libqtile/widget/__init__.py
			rm libqtile/widget/net.py*
		)
	fi
	if use widget-check-updates ; then
		(
			sed -i 's/"Arch",/"Gentoo_eix",/g' libqtile/widget/check_updates.py
		)
	fi
	if ! use widget-check-updates ; then
		(
			sed -i '/"CheckUpdates": "check_updates",/d' libqtile/widget/__init__.py
			rm libqtile/widget/check_updates.py*
		)
	fi
	if ! use widget-mpris ; then
		(
			sed -i '/"Mpris2": "mpris2widget",/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpris2widget.py*
		)
	fi
	if ! use widget-mpd ; then
		(
			sed -i '/"Mp2": "mpd2widget",/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpd2widget.py*
		)
	fi
	if ! use widget-moc ; then
		(
			sed -i '/"Moc": "moc",/d' libqtile/widget/__init__.py
			rm libqtile/widget/moc.py*
		)
	fi
	if ! use widget-memory ; then
		(
			sed -i '/"Memory": "memory",/d' libqtile/widget/__init__.py
			rm libqtile/widget/memory.py*
		)
	fi
	if ! use widget-launchbar ; then
		(
			sed -i '/"Launchbar": "launchbar",/d' libqtile/widget/__init__.py
			rm libqtile/widget/launchbar.py*
		)
	fi
	if ! use widget-keyboardlayout ; then
		(
			sed -i '/"KeyboardLayout": "keyboardlayout",/d' libqtile/widget/__init__.py
			rm libqtile/widget/keyboardlayout.py*
		)
	fi
	if ! use widget-keyboardkbdd ; then
		(
			sed -i '/"KeyboardKbdd": "keyboardkbdd",/d' libqtile/widget/__init__.py
			rm libqtile/widget/keyboardkbdd.py*
		)
	fi
	if ! use widget-imap ; then
		(
			sed -i '/"ImapWidget": "imapwidget",/d' libqtile/widget/__init__.py
			rm libqtile/widget/imapwidget.py*
		)
	fi
	if ! use widget-idlerpg ; then
		(
			sed -i '/"IdleRPG": "idlerpg",/d' libqtile/widget/__init__.py
			rm libqtile/widget/idlerpg.py*
		)
	fi
	if ! use widget-cpu ; then
		(
			sed -i '/"CPU": "cpu",/d' libqtile/widget/__init__.py
			rm libqtile/widget/cpu.py*
		)
	fi
	if ! use widget-cmus ; then
		(
			sed -i '/"Cmus": "cmus",/d' libqtile/widget/__init__.py
			rm libqtile/widget/cmus.py*
		)
	fi
	if ! use widget-bluetooth ; then
		(
			sed -i '/"Bluetooth": "bluetooth",/d' libqtile/widget/__init__.py
			rm libqtile/widget/bluetooth.py*
		)
	fi
	eapply_user

}

python_install_all() {
	local DOCS=( CHANGELOG README.rst )
	distutils-r1_python_install_all

	insinto /usr/share/xsessions
	doins resources/qtile.desktop
}

pkg_postinst() {
	ewarn "If use widget-imap is enabled u need to follow these steps"
	ewarn "1) create the file ~/.local/share/python_keyring/keyringrc.cfg with the following contents:"
	ewarn ""
	ewarn "[backend]"
	ewarn "default-keyring=keyring.backends.Gnome.Keyring"
	ewarn "keyring-path=/home/<userid>/.local/share/keyring/"
	ewarn ""
	ewarn "2) Execute the following python shell script once:"
	ewarn ""
	ewarn "#!/usr/bin/env python3"
	ewarn "import keyring"
	ewarn "user = <userid>"
	ewarn "password = <password>"
	ewarn "keyring.set_password('imapwidget', user, password)"
}
