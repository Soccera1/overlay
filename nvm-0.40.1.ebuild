EAPI=8

DESCRIPTION="Node Version Manager"
HOMEPAGE="https://github.com/nvm-sh/nvm"
SRC_URI="https://github.com/nvm-sh/nvm/archive/refs/tags/v0.40.1.tar.gz -> nvm-0.40.1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

RDEPEND="
	app-shells/bash
	net-misc/wget
	net-libs/nodejs[npm]
	bash-completion? ( app-shells/bash-completion )
"

DEPEND="${RDEPEND}"

S=${WORKDIR}/nvm-0.40.1

src_prepare() {
	default
}

src_compile() {
	cd "${S}"
	npm install
}

src_install() {
	dodir "${EROOT}/usr/local/bin"
	cp -r "${S}"/* "${D}/usr/local/bin"

	if use bash-completion; then
		dodir "${EROOT}/usr/share/bash-completions/completions"
		cp "${S}/bash_completion" "${D}/usr/share/bash-completion/completions/nvm"
	fi

	echo "# Please add the following line to your ~/.bashrc or ~/.zshrc to enable NVM" >> "${D}/usr/local/bin/nvm-install"
	echo "source /usr/local/bin/nvm.sh" >> "${D}/usr/local/bin/nvm-install"
}

pkg_postinst() {
	elog "NVM is now installed. Please add the following to your ~/.bashrc or ~/.zshrc:"
	elog "  source /usr/local/bin/nvm.sh"
}
