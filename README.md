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


How to make an .ipk
===================

I've included a pair of tools to make your life easier ;) First, a
tool to generate the boilerplate files needed to build the
package. Second, a tool to actually build the .ipk.

Generate package files
----------------------

To pack your software, you need at least two files: a control and a
install, both similar to the Debian counterparts.

The control file holds information about the package: its name,
versión, depends... The install file is used to specify the files you
want to include in your package, and its location.

To geneate these and other files, use opkg-make, indicating the name
of the package and the versión, using the -p flag:

    $ opkg-make -p hello_1.0

This will generate a directory, called opkg, and inside it, a bunch of
files. The mentioned control, and some scripts to run when installing
or removing the package (postinst.ex, postrm.ex, preinst.ex,
prerm.ex). These are example files, if you want to include them you
need to remove the .ex extension.


Build the package
-----------------

You just need to run:

    $ opkg-build

This will generate a file called name\_ver.ipk. Send this package to
you carambola and install it with opkg.


