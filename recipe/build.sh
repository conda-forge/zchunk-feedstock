#! /bin/bash
set -ex

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BUILD_PREFIX/lib/pkgconfig
export PKG_CONFIG=$BUILD_PREFIX/bin/pkg-config

if [[ "$PKG_NAME" == *static ]]; then
    MESON_ARGS="$MESON_ARGS --default-library=static --prefer-static
fi

meson setup builddir \
    ${MESON_ARGS} \
    --buildtype=release \
    --prefix=$PREFIX \
    -Dlibdir=lib

ninja -v -C builddir -j${CPU_COUNT}

ninja -C builddir test

ninja -C builddir install
