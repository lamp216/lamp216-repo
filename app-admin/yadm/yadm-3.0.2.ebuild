# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1

DESCRIPTION="A dotfile manager for the config files in your home folder"
HOMEPAGE="https://github.com/TheLocehiliosan/yadm/"
SRC_URI="https://github.com/TheLocehiliosan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	app-crypt/gnupg
	dev-vcs/git
"

DEPEND="
	test? ( ${RDEPEND}
		dev-python/pytest
		dev-tcltk/expect
	)
"

src_compile() {
	emake "${PN}.md"
}

src_test() {
	# test_encryption: needs write access to /tmp
	# test_alt, test_compat_jinja, test_unit_template_j2: needs envtpl
	# test_syntax: needs yamllint (not packaged)
	# test_compat_alt: known broken, tests deprecated features
	# test_compat_jinja: needs envtpl
	rm -v test/test_encryption.py || die
	rm -v test/test_alt.py || die
	rm -v test/test_compat_jinja.py || die
	rm -v test/test_unit_template_j2.py || die
	rm -v test/test_syntax.py || die
	rm -v test/test_compat_alt.py || die

	pytest || die "Testsuite failed under ${EPYTHON}"
}

src_install() {
	einstalldocs

	dobin "${PN}"
	doman "${PN}.1"

	newbashcomp completion/bash/yadm ${PN}

	insinto /usr/share/fish/site-functions
	newins completion/fish/${PN}.fish ${PN}.fish

	insinto /usr/share/zsh/site-functions
	newins completion/zsh/_${PN} _${PN}
}

pkg_postinst() {
	elog "For autocompletion to work u need to do a few extra steps"
	elog ""
	elog "For Bash:"
	elog "Add this to you bashrc [ -f /usr/share/bash-completion/completions/yadm ] && source /usr/share/bash-completion/completions/yadm"
	elog ""
	elog "For Zsh:"
	elog "Add the next lines to ur .zshrc"
	elog "fpath=(/usr/share/zsh/site-functions/_yadm $fpath)"
	elog "autoload -U compinit"
	elog "compinit"
	elog ""
	elog "For Fish:"
	elog "Copy the completion script yadm.fish located at /usr/share/fish/site-functions/yadm.fish to any folder within \$fish_complete_path."
}
