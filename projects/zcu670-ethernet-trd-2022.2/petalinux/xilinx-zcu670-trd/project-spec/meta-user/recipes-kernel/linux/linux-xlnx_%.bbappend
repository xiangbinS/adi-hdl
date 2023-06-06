FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
                   file://0001-ptp-ptp_clockmatrix-Increase-LOCK_TIMEOUT_MS-to-3000.patch \
                   file://0002-ptp-ptp_clockmatrix-Add-support-for-updating-Firmwar.patch \
                   file://0003-ptp-Add-EXTTS-support-for-xilinx-timer.patch \
                   file://0004-ptp-clock_matrix-Add-support-for-FW-4.8.8.patch \
                   file://0008-dt-bindings-net-xilinx_axienet-Add-xlnx-ptp_node-for.patch \
                   file://0001-ptp-xilinx-Acquire-ptp-device-information-dynamicall.patch \
				   file://0001-dt-bindings-net-xilinx_axienet-Add-reset-gpios-for-X.patch \	
				   file://0002-net-xilinx-Add-QPLL-reset-for-XXV-MAC.patch \
				   file://0001-net-xilinx-axienet-PTP-Rx-enhancement-for-MRMAC-XXV.patch \
				   file://0002-net-xilinx-axienet-PTP-Tx-enhancement-for-MRMAC-XXV.patch \
				   file://0003-net-xilinx-axienet-Remove-FIFO-related-code-for-MRMA.patch"			 	

KERNEL_FEATURES:append = " bsp.cfg"
