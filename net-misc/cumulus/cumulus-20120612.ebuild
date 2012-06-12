# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


EAPI=4

inherit eutils

DESCRIPTION="Cumulus server"

HOMEPAGE="https://github.com/OpenRTMFP/Cumulus"

SRC_URI="https://github.com/OpenRTMFP/Cumulus/tarball/6d1981422ec1f0359ec60a303c925482080960c1
-> cumulus-6d19814.tar.gz"

LICENSE="GPL3"

SLOT="0"

KEYWORDS="x86 amd64"

IUSE=""

DEPEND=">=dev-lang/lua-5.1
	dev-libs/openssl
	>=dev-libs/poco-1.4"

RDEPEND="${DEPEND}"

S="${WORKDIR}/OpenRTMFP-Cumulus-6d19814"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}"/gentoo_build.patch
	epatch "${FILESDIR}"/fix_log_and_www_path.patch
}

src_configure() {
	echo "skipping configure"
}


src_compile() {
	cd CumulusLib
	make
	cd ../CumulusServer
	make
}


src_install() {
	cd "${S}"
	dobin CumulusServer/CumulusServer || die
	dolib.so CumulusLib/libCumulus.so || die
}
