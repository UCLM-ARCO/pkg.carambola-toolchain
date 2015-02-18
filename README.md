About
=====

This is a Debian package to include the OpenWRT toolchain used in
carambola. This allows you to install all needed software to develop
in C++.

How to Install
==============

A compiled version of this package is available from
http://babel.esi.uclm.es. You just need to add the following line to
/etc/apt/sources.list:

    deb http://babel.esi.uclm.es/arco sid main

After that, update and install carambola-toolchain:

    $ sudo apt-get update && sudo apt-get install carambola-toolchain

How to Use
==========

You just need to include "carambola.mk" in your Makefile. See
"hello-world" in examples directory for a very basic example.

