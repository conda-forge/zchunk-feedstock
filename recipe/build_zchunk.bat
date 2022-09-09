if %PKG_NAME% == *static (
    set STATIC_ARGS="--default-library=static --prefer-static"
)

meson setup builddir ^
    %MESON_ARGS% ^
    %STATIC_ARGS% ^
    --buildtype=release ^
    --prefix=%LIBRARY_PREFIX% ^
    -Dlibdir=lib

ninja -v -C builddir

ninja -C builddir test

ninja -C builddir install
