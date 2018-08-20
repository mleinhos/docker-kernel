#!/bin/sh -eax

##
## Build debian package of kernel.
##
## Environmental inputs:
##   CLEAN: if true, make clean first
##

CUSTOM=
#CUSTOM=--append-to-version=-cet # must start with '-', must have a corresponding rule to make the header files
OUTPUT=./debball
SOURCE=/source
VERSION=`make kernelversion`
#CLEAN=1

# Suppress '+' at end of build name in case of modified source
EXTRAS="LOCALVERSION="

threads=`grep 'model name' /proc/cpuinfo | wc -l`
export CONCURRENCY_LEVEL=$threads


build_check() {
    echo "Running $*"
    $*
    if [ $? -ne 0]; then
	exit 1
    fi
    
}

cd $SOURCE

echo "Building kernel version $VERSION"

# FIXME: recent kernels have moved a file; the build system can't find
# it so we link to the old location

ln -f Documentation/admin-guide/reporting-bugs.rst .

if [ -n "$CLEAN" ]; then
    build_check make-kpkg -j $threads clean
fi

build_check fakeroot make-kpkg -j $threads --initrd $EXTRAS kernel_image kernel_headers

if [ ! -d $OUTPUT ]; then
    build_check mkdir $OUTPUT
fi

build_check dpkg-deb --build debian/linux-image-$VERSION*
build_check dpkg-deb --build debian/linux-header-$VERSION*
