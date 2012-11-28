# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.23.1_p25396.ebuild,v 1.1 2010/07/27 03:14:08 cardoe Exp $

EAPI=4

MYTHTV_VERSION=""
MYTHTV_BRANCH="fixes/0.25"
MYTHTV_REV="c2c276d2053db180730e955999cb6ab25251152c"
MYTHTV_SREV="c2c276d"

inherit mythtv webapp depend.php

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
IUSE=""
KEYWORDS="amd64 x86 ~ppc"

RDEPEND="dev-lang/php:5.3[curl,json,mysql,session,posix]
	|| ( =media-tv/mythtv-bindings-0.25*[php(+)] =media-tv/mythtv-0.25*[php(+)] )
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Net-UPnP"

DEPEND="${RDEPEND}
		app-arch/unzip"

need_httpd_cgi
need_php5_httpd

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	cd "${S}"
	dodoc README INSTALL

	dodir "${MY_HTDOCSDIR}"/data

	insinto "${MY_HTDOCSDIR}"
	doins -r [[:lower:]]*

	webapp_configfile "${MY_HTDOCSDIR}"/mythweb.conf.{apache,lighttpd}

	webapp_serverowned "${MY_HTDOCSDIR}"/data

	webapp_postinst_txt en "${FILESDIR}"/0.24-postinstall-en.txt

	webapp_src_install

	fperms 755 /usr/share/webapps/mythweb/${PV}/htdocs/mythweb.pl
}
