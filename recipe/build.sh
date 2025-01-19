#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

./configure --prefix=$PREFIX \
    --enable-shared \
    --disable-static
make
make check
make install
