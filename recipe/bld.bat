meson setup builddir ^
    %MESON_ARGS% ^
    --buildtype=release ^
    --prefix=%PREFIX%\Library ^
    -Dlibdir=lib

ninja -v -C builddir

ninja -C builddir test

ninja -C builddir install