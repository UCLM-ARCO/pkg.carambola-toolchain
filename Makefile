# -*- mode: makefile-gmake; coding: utf-8 -*-

DEST = carambola
VER  = v2.3-rc4

all:

clone-repo:
	[ -d $(DEST) ] || git clone https://github.com/8devices/carambola $(DEST)
	cd $(DEST) && git checkout carambola/$(VER)

build-toolchain:
	cp config $(DEST)/.config
	make -C $(DEST) tools/install toolchain/install

prepare-package: clone-repo build-toolchain

build-package:
	ian-build

clean-all:
	rm -rfv $(DEST)
