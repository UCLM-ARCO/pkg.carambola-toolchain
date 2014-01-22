# -*- mode: makefile-gmake; coding: utf-8 -*-

SHELL         = /bin/bash
DEST          = carambola
VER           = v2.3~rc4

INSTALL_DIR   = $(DEST)-install/pkg/
TOOLCHAIN_DIR = $(DEST)/staging_dir/toolchain-mipsel_r2_gcc-4.6-linaro_uClibc-0.9.33.2/
LIBEXEC       = $(TOOLCHAIN_DIR)/libexec/gcc/mipsel-openwrt-linux-uclibc/4.6.3


all:

clone-repo:
	[ -d $(DEST) ] || git clone https://github.com/8devices/carambola $(DEST)
	cd $(DEST) && git checkout carambola/$(VER)

build-toolchain:
	cp config $(DEST)/.config
	make -C $(DEST) tools/install toolchain/install

copy-important-content:
	mkdir -p $(INSTALL_DIR)
	cp -r debian $(INSTALL_DIR)
	cp -r $(TOOLCHAIN_DIR)/bin $(INSTALL_DIR)
	cp $(LIBEXEC)/cc1plus $(INSTALL_DIR)/bin

	rm $(INSTALL_DIR)/bin/ldd
	find $(INSTALL_DIR)/bin/ -maxdepth 1 -type l -delete

prepare-package: clone-repo build-toolchain

build-package: copy-important-content
	cd $(INSTALL_DIR) && ian-build

clean:
	rm -rfv carambola-install *.tar.gz

clean-all:
	rm -rfv $(DEST)
