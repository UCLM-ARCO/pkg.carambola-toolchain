# -*- mode: makefile-gmake; coding: utf-8 -*-

# libs goes to: /usr/mipsel-linux-gnu/lib
# headers in:   /usr/mipsel-linux-gnu/include

SHELL         = /bin/bash
DEST          = carambola
VER           = v2.3-rc4

TCNAME        = toolchain-mipsel_r2_gcc-4.6-linaro_uClibc-0.9.33.2
UCNAME        = target-mipsel_r2_uClibc-0.9.33.2
INSTALL_DIR   = $(DEST)-install/pkg
STAGING_DIR   = $(DEST)/staging_dir
TOOLCHAIN_DIR = $(STAGING_DIR)/$(TCNAME)

all:

clone-repo:
	[ -d $(DEST) ] || git clone https://github.com/8devices/carambola $(DEST)
	cd $(DEST) && git checkout carambola/$(VER)

build-toolchain:
	cp config $(DEST)/.config
	make -C $(DEST) \
		tools/install \
		toolchain/install \
		package/toolchain/install \
		package/libs/uclibc++/install

copy-important-files: TCDIR = $(INSTALL_DIR)/staging_dir/$(TCNAME)
copy-important-files: UCDIR = $(INSTALL_DIR)/staging_dir/$(UCNAME)
copy-important-files:
	install -d $(INSTALL_DIR)
	cp -r debian $(INSTALL_DIR)
	cp -r opkg $(INSTALL_DIR)

	install -d $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/bin $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/include $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/lib $(TCDIR)
	cp -r $(TOOLCHAIN_DIR)/libexec $(TCDIR)
	rm $(TCDIR)/bin/ldd

	ln -fs mipsel-openwrt-linux-uclibc-as $(TCDIR)/bin/as

	install -d $(TCDIR)/mipsel-openwrt-linux
	cp -r $(TOOLCHAIN_DIR)/mipsel-openwrt-linux/include $(TCDIR)/mipsel-openwrt-linux

	install -d $(INSTALL_DIR)/usr/include
	cp carambola.mk $(INSTALL_DIR)/usr/include

	install -d $(UCDIR)/usr
	cp -r $(STAGING_DIR)/$(UCNAME)/usr/lib $(UCDIR)/usr

prepare-package: clone-repo build-toolchain

debian-package: copy-important-files
	cd $(INSTALL_DIR) && ian-build

debian-install:
	cd $(INSTALL_DIR) && ian-install

clean:
	rm -rf carambola-install *.tar.gz

clean-all: clean
	rm -rf $(DEST)
