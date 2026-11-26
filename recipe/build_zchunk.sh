#!/bin/bash
set -ex

rm -rf builddir

if [[ "${PKG_NAME}" == "zchunk-static" ]]; then
    LIB_TYPE=static
else
    LIB_TYPE=shared
fi

meson setup builddir \
    ${MESON_ARGS} \
    --default-library=${LIB_TYPE} \
    --wrap-mode=nofallback

ninja -v -C builddir -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    ninja -C builddir test
fi
ninja -C builddir install
