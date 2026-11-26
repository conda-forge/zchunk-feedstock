if "%PKG_NAME%" == "zchunk-static" (
    set LIB_TYPE=static
) else (
    set LIB_TYPE=shared
)

if exist builddir rd /s /q builddir

:: let MSVC's find_library locate conda's libargp.a
set "LIB=%LIBRARY_LIB%;%LIB%"

meson setup builddir ^
    %MESON_ARGS% ^
    --default-library=%LIB_TYPE% ^
    --wrap-mode=nofallback ^
    -Db_vscrt=md
if errorlevel 1 exit 1

ninja -v -C builddir
if errorlevel 1 exit 1

ninja -C builddir test
if errorlevel 1 exit 1

ninja -C builddir install
if errorlevel 1 exit 1
