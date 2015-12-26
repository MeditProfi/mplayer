@echo off
echo MPlayer for Windows Package Creator
echo.
echo 1. 32-bit Release
echo 2. 32-bit Debug
echo 3. 64-bit Release
echo 4. 64-bit Debug
echo 5. 32/64-bit Release Packages
echo 6. Make all
echo.

:reask
set /p USER_CHOICE="Choose an action: "

if "%USER_CHOICE%" == "1"  goto pkgver
if "%USER_CHOICE%" == "2"  goto pkgver
if "%USER_CHOICE%" == "3"  goto pkgver
if "%USER_CHOICE%" == "4"  goto pkgver
if "%USER_CHOICE%" == "5"  goto pkgver
if "%USER_CHOICE%" == "6"  goto pkgver
goto reask

:pkgver
echo.
if exist "pkg_version"  for /f "tokens=*" %%i in ('type pkg_version') do set REVISION=%%i
if "%REVISION%" == ""  set /p REVISION="Revision: "

set OUTPUT_DIR=.\completed\r%REVISION%

if "%USER_CHOICE%" == "1"  goto 32bitrelease
if "%USER_CHOICE%" == "2"  goto 32bitdebug
if "%USER_CHOICE%" == "3"  goto 64bitrelease
if "%USER_CHOICE%" == "4"  goto 64bitdebug
if "%USER_CHOICE%" == "5"  goto 32bitrelease
if "%USER_CHOICE%" == "6"  goto 32bitrelease
:: Should not happen
goto end

:32bitrelease

ren mplayer mplayer-svn-%REVISION%

7za a -t7z %OUTPUT_DIR%\mplayer-svn-%REVISION%.7z mplayer-svn-%REVISION% -xr!mplayer64.exe -xr!mencoder64.exe -xr!mplayer.exe.debug -xr!mencoder.exe.debug  -xr!mplayer64.exe.debug -xr!mencoder64.exe.debug -xr!gdb -xr!buildinfo-mencoder-32 -xr!buildinfo-mencoder-64 -xr!buildinfo-mencoder-debug-32 -xr!buildinfo-mencoder-debug-64 -xr!buildinfo-mplayer-32 -xr!buildinfo-mplayer-64 -xr!buildinfo-mplayer-debug-32 -xr!buildinfo-mplayer-debug-64 -xr!gdb.exe -xr!gdb64.exe -mx7

ren mplayer-svn-%REVISION% mplayer

if "%USER_CHOICE%" == "1"  goto end
if "%USER_CHOICE%" == "3"  goto 64bitrelease
if "%USER_CHOICE%" == "5"  goto 64bitrelease

:32bitdebug

ren mplayer\mplayer.exe mplayer.exe.bak32
ren mplayer\mencoder.exe mencoder.exe.bak32
ren mplayer\mplayer.exe.debug mplayer.exe
ren mplayer\mencoder.exe.debug mencoder.exe
ren mplayer mplayer-svn-%REVISION%-d

7za a -t7z %OUTPUT_DIR%\debug\mplayer-svn-%REVISION%-d.7z mplayer-svn-%REVISION%-d -xr!mplayer64.exe -xr!mencoder64.exe -xr!*.bak32 -xr!mplayer64.exe.debug -xr!mencoder64.exe.debug -xr!gdb -xr!buildinfo-mencoder-64 -xr!buildinfo-mencoder-debug-64 -xr!buildinfo-mplayer-64 -xr!buildinfo-mplayer-debug-64 -xr!gdb64.exe -mx7

ren mplayer-svn-%REVISION%-d mplayer
ren mplayer\mplayer.exe mplayer.exe.debug
ren mplayer\mencoder.exe mencoder.exe.debug
ren mplayer\mplayer.exe.bak32 mplayer.exe
ren mplayer\mencoder.exe.bak32 mencoder.exe

if "%USER_CHOICE%" == "2"  goto end

:64bitrelease

ren mplayer\mplayer.exe mplayer.exe.bak32
ren mplayer\mencoder.exe mencoder.exe.bak32
ren mplayer\mplayer64.exe mplayer.exe
ren mplayer\mencoder64.exe mencoder.exe
ren mplayer mplayer-svn-%REVISION%-x86_64

:: Release
7za a -t7z %OUTPUT_DIR%\mplayer-svn-%REVISION%-x86_64.7z mplayer-svn-%REVISION%-x86_64 -xr!mplayer.exe.debug -xr!mencoder.exe.debug -xr!mplayer64.exe.debug -xr!mencoder64.exe.debug -xr!*.bak32 -xr!*.bak64 -xr!gdb -xr!codecs -xr!buildinfo-mencoder-32 -xr!buildinfo-mencoder-64 -xr!buildinfo-mencoder-debug-32 -xr!buildinfo-mencoder-debug-64 -xr!buildinfo-mplayer-32 -xr!buildinfo-mplayer-64 -xr!buildinfo-mplayer-debug-32 -xr!buildinfo-mplayer-debug-64 -xr!gdb.exe -xr!gdb64.exe -mx7

ren mplayer-svn-%REVISION%-x86_64 mplayer
ren mplayer\mplayer.exe mplayer64.exe
ren mplayer\mencoder.exe mencoder64.exe
ren mplayer\mplayer.exe.bak32 mplayer.exe
ren mplayer\mencoder.exe.bak32 mencoder.exe

if "%USER_CHOICE%" == "5"  goto end

:64bitdebug

ren mplayer\mplayer.exe mplayer.exe.bak32
ren mplayer\mencoder.exe mencoder.exe.bak32
ren mplayer\mplayer64.exe.debug mplayer.exe
ren mplayer\mencoder64.exe.debug mencoder.exe
ren mplayer\gdb.exe gdb.exe.bak32
ren mplayer\gdb64.exe gdb.exe
ren mplayer mplayer-svn-%REVISION%-x86_64-d

7za a -t7z %OUTPUT_DIR%\debug\mplayer-svn-%REVISION%-x86_64-d.7z mplayer-svn-%REVISION%-x86_64-d -xr!mplayer.exe.debug -xr!mencoder.exe.debug -xr!mplayer64.exe -xr!mencoder64.exe -xr!*.bak32 -xr!*.bak64 -xr!gdb -xr!codecs -xr!buildinfo-mencoder-32 -xr!buildinfo-mencoder-debug-32 -xr!buildinfo-mplayer-32 -xr!buildinfo-mplayer-debug-32 -xr!gdb.exe.bak32 -mx7

ren mplayer-svn-%REVISION%-x86_64-d mplayer
ren mplayer\mplayer.exe mplayer64.exe.debug
ren mplayer\mencoder.exe mencoder64.exe.debug
ren mplayer\mplayer.exe.bak32 mplayer.exe
ren mplayer\mencoder.exe.bak32 mencoder.exe
ren mplayer\gdb.exe gdb64.exe
ren mplayer\gdb.exe.bak32 gdb.exe

if "%USER_CHOICE%" == "4"  goto end

:end

echo sha256deep -k -r -l debug\*.7z^>SHA256SUMS>%OUTPUT_DIR%\makesha256.cmd
echo sha256deep -b -k *.7z^>^>SHA256SUMS>>%OUTPUT_DIR%\makesha256.cmd
echo del makesha256.cmd>>%OUTPUT_DIR%\makesha256.cmd

pause

:reallyend
