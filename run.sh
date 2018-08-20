#!/bin/sh -eax

##
## Run from xen build directory
##

CONTAINER_NAME=matt/kernel-builder:latest

sudo docker run -i -v $(pwd):/source $CONTAINER_NAME ./build-kernel.sh

