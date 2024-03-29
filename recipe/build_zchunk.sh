#! /bin/bash
set -ex

rm -rf builddir

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BUILD_PREFIX/lib/pkgconfig
export PKG_CONFIG=$BUILD_PREFIX/bin/pkg-config

if [[ $PKG_NAME == "zchunk-static" ]]; then
    meson setup builddir \
        ${MESON_ARGS} \
        --buildtype=release \
        --default-library=static \
        --prefix=$PREFIX \
        -Dlibdir=lib
elif [[ $PKG_NAME == "zchunk" ]]; then
    meson setup builddir \
        ${MESON_ARGS} \
        --buildtype=release \
        --default-library=shared\
        --prefix=$PREFIX \
        -Dlibdir=lib
fi


ninja -v -C builddir -j${CPU_COUNT}

ninja -C builddir test

ninja -C builddir install
