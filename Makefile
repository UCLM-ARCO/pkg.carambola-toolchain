# -*- mode: makefile-gmake; coding: utf-8 -*-

# libs goes to: /usr/mipsel-linux-gnu/lib
# headers in:   /usr/mipsel-linux-gnu/include

SHELL         = /bin/bash
DEST          = carambola
VER           = v2.3~rc4

TCNAME        = toolchain-mipsel_r2_gcc-4.6-linaro_uClibc-0.9.33.2
INSTALL_DIR   = $(DEST)-install/pkg/
TOOLCHAIN_DIR = $(DEST)/staging_dir/$(TCNAME)

# LIBEXEC       = $(TOOLCHAIN_DIR)/libexec/gcc/mipsel-openwrt-linux-uclibc/4.6.3
# UCLIBC        = $(TOOLCHAIN_DIR)/mipsel-openwrt-linux-uclibc
# GCCLIB        = $(TOOLCHAIN_DIR)/lib/gcc/mipsel-openwrt-linux-uclibc/4.6.3

all:

clone-repo:
	[ -d $(DEST) ] || git clone https://github.com/8devices/carambola $(DEST)
	cd $(DEST) && git checkout carambola/$(VER)

build-toolchain:
	cp config $(DEST)/.config
	make -C $(DEST) tools/install toolchain/install package/libs/uclibc++/install

copy-important-content: TCDIR = $(INSTALL_DIR)/staging_dir/$(TCNAME)
copy-important-content:
	install -d $(INSTALL_DIR)
	cp -r debian $(INSTALL_DIR)

	install -d $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/bin $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/include $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/lib $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/libexec $(TCDIR)
	rm $(TCDIR)/bin/ldd

	install -d $(TCDIR)/mipsel-openwrt-linux
	cp -r $(TOOLCHAIN_DIR)/mipsel-openwrt-linux/include $(TCDIR)/mipsel-openwrt-linux

# # copy-important-content: HEADERS_DIR = $(INSTALL_DIR)/usr/mipsel-linux-gnu/include
# # copy-important-content: LIB_DIR = $(INSTALL_DIR)/usr/mipsel-linux-gnu/lib
# # copy-important-content: GCCLIB_DIR = $(LIB_DIR)/gcc/mipsel-openwrt-linux-uclibc/4.6.3
# copy-important-content:
# copy-important-content: BIN_DIR = $(INSTALL_DIR)/usr/share/carambola
# copy-important-content:
# 	install -d $(INSTALL_DIR)
# 	cp -r debian $(INSTALL_DIR)

# 	install -d $(BIN_DIR)
# 	cp staging_dir/toolchain-mipsel_r2_gcc-4.6-linaro_uClibc-0.9.33.2/bin/
# # 	cp -r $(TOOLCHAIN_DIR)/bin/* $(BIN_DIR)
# # 	cp $(LIBEXEC)/cc1plus $(BIN_DIR)
# # 	rm $(BIN_DIR)/ldd
# # 	find $(BIN_DIR) -maxdepth 1 -type l -delete

# # 	install -d $(HEADERS_DIR)
# # 	cp -r $(TOOLCHAIN_DIR)/include/* $(HEADERS_DIR)
# # 	cp -r $(UCLIBC)/include/* $(HEADERS_DIR)

# # 	install -d $(GCCLIB_DIR)/lib
# # 	cp -r $(GCCLIB)/include $(GCCLIB_DIR)
# # 	cp -r $(LIBEXEC)/liblto_plugin.so* $(GCCLIB_DIR)/lib

prepare-package: clone-repo build-toolchain

debian-package: copy-important-content
	cd $(INSTALL_DIR) && ian-build

debian-install:
	cd $(INSTALL_DIR) && ian-install

clean:
	rm -rfv carambola-install *.tar.gz

clean-all:
	rm -rfv $(DEST)
