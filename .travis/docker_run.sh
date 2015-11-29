#!/bin/bash -ex
cd "$(dirname $0)/.."

CONTAINER="kinsamanka/mkdocker"

# run build step
docker run \
    -v $(pwd):$(pwd) \
    -e FLAV="${FLAV}" \
    -e JOBS=${JOBS} \
    -e TAG=${TAG} \
    -w $(pwd) \
    ${CONTAINER}:${TAG} \
    $(pwd)/.travis/build_rip.sh

# tests are run under a new container instead of chrooting
# this will allow us to run docker without using privileged mode
if [ ${CMD} == "run_tests" ];
then
    # create container using RIP rootfs
    docker build -t mk_runtest .travis/mk_runtests
    
    # run regressions
    docker run \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        --rm=true mk_runtest $(pwd)/.travis/run_tests.sh
fi
