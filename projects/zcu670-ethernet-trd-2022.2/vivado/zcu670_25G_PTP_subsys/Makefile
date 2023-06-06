# --(C) Copyright 2020 - 2021 Xilinx, Inc. 
# --Copyright (C) 2022, Advanced Micro Devices, Inc 
# --SPDX-License-Identifier: Apache-2.0

RM = rm -rf
VIVADO = $(XILINX_VIVADO)/emea/mediadata/opt/Xilinx/Vivado/2022.2/bin/vivado
JOBS ?= 8

VIV_DESIGN = zcu670_25G_PTP_subsys 

VIV_PRJ_DIR = project
VIV_SCRIPTS_DIR = scripts

VIVADO_XSA = $(VIV_PRJ_DIR)/xxv_ptp_subsys_wrapper.xsa
VIV_SRC = $(VIV_SCRIPTS_DIR)/main.tcl

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make xsa'
	@echo '  Generate xsa '
	@echo ''

.PHONY: all
all: xsa

xsa: $(VIVADO_XSA)
$(VIVADO_XSA): $(VIV_SRC)
	$(VIVADO) -mode batch -notrace -source $(VIV_SRC) -tclargs -jobs $(JOBS) 

.PHONY: clean
clean:
	$(RM) $(VIV_PRJ_DIR) vivado* .Xil *dynamic* *.log *.xpe

