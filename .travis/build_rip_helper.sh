#!/bin/sh -ex

cd src
./autogen.sh
./configure \
     --with-posix \
     --without-rt-preempt \
     --without-xenomai \
     --without-xenomai-kernel \
     --without-rtai-kernel
make -j${JOBS}
useradd mk
chown -R mk:mk ../
make setuid
