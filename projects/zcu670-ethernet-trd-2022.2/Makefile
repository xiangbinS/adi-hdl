#--(C) Copyright 2020 - 2021 Xilinx, Inc. 
#--Copyright (C) 2022, Advanced Micro Devices, Inc 
#--SPDX-License-Identifier: Apache-2.0

CP = cp -f

PWD = $(shell readlink -f .)

design_list = zcu670_25G_PTP_subsys 
 
VIVDIR = $(PWD)/vivado

PLNX_DIR = petalinux/xilinx-zcu670-trd
PLNX_WIC = $(PLNX_DIR)/images/linux/petalinux-sdimage.wic

VIVADO_DIR = $(VIVDIR)/zcu670_25G_PTP_subsys/project
VIVADO_XSA_PLNX = $(VIVADO_DIR)/xxv_ptp_subsys_wrapper.xsa

VIVA_XSA_top = $(VIVDIR)/zcu670_25G_PTP_subsys/project/xxv_ptp_subsys_wrapper.xsa

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make sdcard'
	@echo '    Generate an SD card image using PetaLinux.'
	@echo ''
	@echo ''
	@echo '	 make vivado_design design=<val> JOBS=<n>'
	@echo '    Build the Vivado xsa.'
	@echo '    Valid options for design: ${design_list}.'
	@echo '    JOBS: optional param to set number of synthesis jobs (default 8)'
	@echo ''
	@echo '  make docs'
	@echo '    Generate html documentation using sphinx'
	@echo ''
	@echo '  make clean'
	@echo '    Clean runs'
	@echo ''

.PHONY: all
all: sdcard

.PHONY: sdcard
sdcard: $(PLNX_WIC)
$(PLNX_WIC): $(PLNX_DIR) vivado_design
	@echo 'Build PetaLinux boot image'
	$(MAKE) -C $(PLNX_DIR)  boot

$(PLNX_DIR):
	$(MAKE) -C petalinux project


.PHONY: vivado_design
vivado_design: $(VIVA_XSA_top)
$(VIVA_XSA_top):
	  make -C $(VIVDIR) design_xsa design=$(design_list) 
	 @echo 'Build PetaLinux wic image for $(VIVA_XSA_top)'  
	 
	
.PHONY: docs
docs:
	$(MAKE) -C docs html


.PHONY: clean
clean:
	$(MAKE) -C $(PLNX_DIR) clean
	

