# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Tomoe GTK+ interface widget library"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge/tomoe/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="app-i18n/tomoe[python(+)?,${PYTHON_USEDEP}]
	python? (
		${PYTHON_DEPS}
		dev-python/pygobject:2[${PYTHON_USEDEP}]
		dev-python/pygtk:2[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with python python "") \
		--without-gucharmap
}

src_install() {
	default

	if use python ; then
		find "${D}$(python_get_sitedir)" \( -name "*.la" -o -name "*.a" \) -type f -delete || die
	fi
	if ! use static-libs ; then
		find "${ED}" -name "*.la" -type f -delete || die
	fi
}