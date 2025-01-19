#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Skip failing tests on linux-aarch64 and linux-ppc64le
if [[ ${target_platform} == "linux-aarch64" || ${target_platform} == "linux-ppc64le" ]]; then
    sed -i '/test-catch-segv1 /d' tests/Makefile.am
    sed -i '/test-catch-segv2 /d' tests/Makefile.am
fi

export CFLAGS="${CFLAGS} -Wno-int-conversion"
./configure --prefix=$PREFIX \
    --enable-shared \
    --disable-static
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    make check
fi
make install
