#
# This file is the ptpphasemaster recipe.
#

SUMMARY = "Simple ptpphasemaster application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://linkpartner_G.8275.1.cfg \
	"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}/${bindir}
	     install -m 0755 ${S}/linkpartner_G.8275.1.cfg ${D}/${bindir}
}
