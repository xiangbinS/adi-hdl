#--(C) Copyright 2020 - 2021 Xilinx, Inc. 
#--Copyright (C) 2022, Advanced Micro Devices, Inc 
#--SPDX-License-Identifier: Apache-2.0
RM = rm -rf

# to be passed from top-level Makefile
YES ?= 0

PLNX_IMG_DIR = images/linux
PLNX_SDK = $(PLNX_IMG_DIR)/sdk.sh

PLNX_BOOT = $(PLNX_IMG_DIR)/BOOT.BIN
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/zynqmp_fsbl.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/u-boot.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/pmufw.elf
PLNX_BOOT_OBJS += $(PLNX_IMG_DIR)/system.bit
PLNX_BOOT_ARGS =  --fsbl --u-boot --pmufw --fpga 

PLNX_WIC = $(PLNX_IMG_DIR)/petalinux-sdimage.wic.xz
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/boot.scr
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/Image
PLNX_WIC_OBJS += $(PLNX_IMG_DIR)/rootfs.tar.gz
PLNX_WIC_ARGS = --wic-extra-args "-c xz"

PLNX_IMG_OBJS += $(PLNX_BOOT_OBJS)
PLNX_IMG_OBJS += $(PLNX_WIC_OBJS)

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make wic'
	@echo '    This rule builds an SD card wic image.'
	@echo ''
	@echo '  make boot'
	@echo '    This rule builds a boot image (BOOT.BIN).'
	@echo ''
	@echo '  make image'
	@echo '    This rule builds a full Linux image. It is always executed'
	@echo '    unconditionally. The yocto build system tracks changes and'
	@echo '    performs an incremental build on subsequent runs.'
	@echo ''
	@echo '  make sdk'
	@echo '    This rule builds an SDK.'
	@echo ''

.PHONY: all
all: wic

.PHONY: wic
wic: $(PLNX_WIC)
$(PLNX_WIC): $(PLNX_WIC_OBJS) $(PLNX_BOOT)
	@echo 'Build PetaLinux wic image'
	petalinux-package --wic ${PLNX_WIC_ARGS}

.PHONY: boot
boot: $(PLNX_BOOT)
$(PLNX_BOOT): $(PLNX_BOOT_OBJS)
	@echo 'Build PetaLinux boot image'
	petalinux-package --boot ${PLNX_BOOT_ARGS} --force

.PHONY: image
image $(PLNX_IMG_OBJS):
	@echo 'Build PetaLinux image'
	@if [ ${YES} -eq 1 ]; then \
	  yes | petalinux-config --get-hw-description=../../vivado/zcu670_25G_PTP_subsys/project/ --silentconfig; \
	else \
	  petalinux-config --silentconfig; \
	fi
	petalinux-build

.PHONY: sdk
sdk: $(PLNX_SDK)
$(PLNX_SDK):
	@echo 'Build PetaLinux SDK'
	@./trd.cfg -p ${PFM}
	@if [ ${YES} -eq 1 ]; then \
	  yes | petalinux-config --silentconfig; \
	else \
	  petalinux-config --silentconfig; \
	fi
	petalinux-build --sdk

.PHONY: clean
clean:
	-@$(RM) build components/yocto images project-spec/meta-vmk180-trd
	-@$(RM) $(shell grep TMP_DIR project-spec/configs/config | sed -e 's/.*"\(.*\)\"/\1/')


