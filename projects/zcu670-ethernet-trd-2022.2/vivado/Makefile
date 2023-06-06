# --(C) Copyright 2020 - 2021 Xilinx, Inc. 
# --Copyright (C) 2022, Advanced Micro Devices, Inc 
# --SPDX-License-Identifier: Apache-2.0

CWD=$(shell pwd)
CP = cp -rf
MKDIR = mkdir -p
RM = rm -rf
JOBS ?= 8
REV ?= Rev B

design ?= zcu670_25G_PTP_subsys

VIV_DIR = $(CWD)/$(design)
VIV_XSA = $(VIV_DIR)/project/xxv_ptp_subsys_wrapper.xsa

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make design_xsa design=zcu670_25G_PTP_subsys JOBS=8'
	@echo '  Generate Vivado xsa '
	@echo ''

.PHONY: all
all: design_xsa

.PHONY: design_xsa
design_xsa: $(VIV_XSA)
$(VIV_XSA):
	make -C $(VIV_DIR) xsa JOBS=$(JOBS)
	
.PHONY: clean
clean:
	make -C $(VIV_DIR) clean

