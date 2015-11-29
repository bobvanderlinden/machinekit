#!/bin/sh -ex

# this script is run inside a docker container

PROOT_OPTS="--bind=/dev/shm --rootfs=/opt/rootfs --bind=$(pwd) --pwd=$(pwd)"
if echo ${TAG} | grep -iq arm; then
    PROOT_OPTS="${PROOT_OPTS} --qemu=qemu-arm-static"
fi

# rip build
proot ${PROOT_OPTS} .travis/build_rip_helper.sh

# tar the chroot directory
tar czf /tmp/rootfs.tgz -C /opt/rootfs .
cp /tmp/rootfs.tgz ${CHROOT_PATH}${TRAVIS_PATH}/mk_runtests
