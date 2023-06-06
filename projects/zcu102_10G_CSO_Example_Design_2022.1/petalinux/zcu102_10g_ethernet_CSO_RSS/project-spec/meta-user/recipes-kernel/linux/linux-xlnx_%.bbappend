FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
		   file://0001-net-xilinx-Add-RXCsum-support.patch \
		   file://0002-net-xilinx-Add-Txcsum-offload-support-for-xxv-ethern.patch"
KERNEL_FEATURES:append = " bsp.cfg"
