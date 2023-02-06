if "%PKG_NAME%" == "zchunk-static" (
    set LIB_TYPE_ARGS="--default-library=static"
) else (
    set LIB_TYPE_ARGS="--default-library=shared"
)

rd /s /q builddir

meson setup builddir ^
    %MESON_ARGS% ^
    %LIB_TYPE_ARGS% ^
    --buildtype=release ^
    -Db_vscrt=static_from_buildtype ^
    --prefix=%LIBRARY_PREFIX% ^
    -Dlibdir=lib

ninja -v -C builddir

ninja -C builddir test

ninja -C builddir install
