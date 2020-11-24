meson builddir --prefix="%PREFIX%" --libdir="%LIBRARY_PREFIX%"
if errorlevel 1 exit 1

meson configure -D enable_docs=false builddir
if errorlevel 1 exit 1

ninja -v -C builddir
if errorlevel 1 exit 1

ninja -C builddir test
if errorlevel 1 exit 1

ninja -C builddir install
if errorlevel 1 exit 1
