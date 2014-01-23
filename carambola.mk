# -*- mode: makefile-gmake; coding: utf-8 -*-

# libs goes to: /usr/mipsel-linux-gnu/lib
# headers in:   /usr/mipsel-linux-gnu/include

STAGING_DIR   = /usr/share/carambola
TOOLCHAIN     = $(STAGING_DIR)/toolchain-mipsel_r2_gcc-4.6-linaro_uClibc-0.9.33.2
GCCINCLUDE    = $(TOOLCHAIN)/mipsel-openwrt-linux/include/c++/4.6.3
PATH         := $(TOOLCHAIN)/bin:$(PATH)

export PATH
export STAGING_DIR

LDFLAGS       = -L$(TOOLCHAIN)/lib \
		-L$(STAGING_DIR)/target-mipsel_r2_uClibc-0.9.33.2/usr/lib

CXX           = mipsel-openwrt-linux-uclibc-g++
CXXFLAGS      = --sysroot=$(TOOLCHAIN) -I. \
		-I$(TOOLCHAIN)/include \
		-I/usr/mipsel-linux-gnu/include \
		-I$(GCCINCLUDE) \
		-I$(GCCINCLUDE)/mipsel-openwrt-linux-uclibc

