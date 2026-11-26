if "%PKG_NAME%" == "zchunk-static" (
    set LIB_TYPE=static
) else (
    set LIB_TYPE=shared
)

if exist builddir rd /s /q builddir

:: conda-forge's argp-standalone only ships libargp.a, which meson's MSVC
:: find_library no longer picks up; describe it via a pkg-config file instead
:: (kept outside of the prefix so it is not packaged)
set "ARGP_PC_DIR=%SRC_DIR%\argp-pc"
if not exist "%ARGP_PC_DIR%" mkdir "%ARGP_PC_DIR%"
set "LIBRARY_PREFIX_FWD=%LIBRARY_PREFIX:\=/%"
(
    echo Name: argp-standalone
    echo Description: argp-standalone from conda-forge
    echo Version: 1.5.0
    echo Libs: %LIBRARY_PREFIX_FWD%/lib/libargp.a
    echo Cflags: -I%LIBRARY_PREFIX_FWD%/include
) > "%ARGP_PC_DIR%\argp-standalone.pc"
set "PKG_CONFIG_PATH=%ARGP_PC_DIR%;%PKG_CONFIG_PATH%"

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
