# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.17.0
	adler@1.0.2
	anyhow@1.0.56
	atty@0.2.14
	autocfg@1.1.0
	backtrace@0.3.66
	base64@0.13.0
	bitflags@1.3.2
	cassowary@0.3.0
	cc@1.0.73
	cfg-if@1.0.0
	clap@3.2.20
	clap_lex@0.2.4
	crossterm@0.25.0
	crossterm_winapi@0.9.0
	dirs@4.0.0
	dirs-sys@0.3.7
	getrandom@0.2.6
	gimli@0.26.2
	git-version@0.3.5
	git-version-macro@0.3.5
	glob@0.3.0
	hashbrown@0.12.3
	hermit-abi@0.1.19
	indexmap@1.9.1
	itoa@1.0.1
	libc@0.2.121
	lock_api@0.4.7
	log@0.4.16
	memchr@2.5.0
	miniz_oxide@0.5.4
	mio@0.8.4
	object@0.29.0
	os_str_bytes@6.3.0
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	proc-macro-hack@0.5.19
	proc-macro2@1.0.36
	quote@1.0.17
	redox_syscall@0.2.13
	redox_users@0.4.3
	ron@0.8.0
	rustc-demangle@0.1.21
	ryu@1.0.9
	scopeguard@1.1.0
	serde@1.0.136
	serde_derive@1.0.136
	serde_json@1.0.79
	signal-hook@0.3.13
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.0
	smallvec@1.8.0
	strsim@0.10.0
	syn@1.0.90
	termcolor@1.1.3
	textwrap@0.15.0
	thiserror@1.0.30
	thiserror-impl@1.0.30
	toml@0.5.9
	tui@0.19.0
	unicode-segmentation@1.9.0
	unicode-width@0.1.9
	unicode-xid@0.2.2
	wasi@0.10.2+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.36.1
	windows_aarch64_msvc@0.36.1
	windows_i686_gnu@0.36.1
	windows_i686_msvc@0.36.1
	windows_x86_64_gnu@0.36.1
	windows_x86_64_msvc@0.36.1
	xdg@2.4.1
"

inherit cargo

DESCRIPTION="leftwm-config"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/leftwm/leftwm-config"
SRC_URI="
		https://github.com/leftwm/leftwm-config/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"
