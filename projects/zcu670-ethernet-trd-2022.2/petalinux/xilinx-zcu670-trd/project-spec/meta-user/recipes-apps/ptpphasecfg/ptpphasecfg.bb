#
# This file is the ptpphasecfg recipe.
#

SUMMARY = "Simple ptpphasecfg application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://standalone_G.8275.1.cfg \
	"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}/${bindir}
	     install -m 0755 ${S}/standalone_G.8275.1.cfg ${D}/${bindir}
}
