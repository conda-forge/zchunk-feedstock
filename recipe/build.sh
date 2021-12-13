#! /bin/bash
set -ex

meson setup builddir \
    ${MESON_ARGS} \
    --buildtype=release \
    --prefix=$PREFIX \
    --libdir=$PREFIX/lib

ninja -v -C builddir -j${CPU_COUNT}

ninja -C builddir test

ninja -C builddir install