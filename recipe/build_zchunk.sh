#! /bin/bash
set -ex

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BUILD_PREFIX/lib/pkgconfig
export PKG_CONFIG=$BUILD_PREFIX/bin/pkg-config

if [[ $PKG_NAME == "zchunk-static" ]]; then
    meson setup builddir \
        ${MESON_ARGS} \
        --buildtype=release \
        --default-library=static \
        --prefer-static \
        --prefix=$PREFIX \
        -Dlibdir=lib
elif [[ $PKG_NAME == "zchunk" ]]; then
    meson setup builddir \
        ${MESON_ARGS} \
        --buildtype=release \
        --prefix=$PREFIX \
        -Dlibdir=lib
fi


ninja -v -C builddir -j${CPU_COUNT}

if [[ $PGK_NAME == "zchunk" ]]; then
    ninja -C builddir test
fi

ninja -C builddir install
