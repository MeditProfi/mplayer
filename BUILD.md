# Build mplayer on Windows with MinGW-64
---------------------------------

### install latest MSYS2 & MinGW64 packages:

* Download the MSYS2 package and a MinGW toolchain. Download links:
  * [msys](http://sourceforge.net/projects/mplayerwin/files/MinGW/toolchains/) – mplayer-msys2-snapshot-x86-64_20151213_2000.7z
  * [mingw64 mplayer toolchain](http://sourceforge.net/projects/mplayerwin/files/MinGW/toolchains/64-bit/) – mplayer-mingw64-gcc493-20151223_2052.7z
  * [mplayer 3dparty dependencies](http://sourceforge.net/projects/mplayerwin/files/MinGW/sources/) – mplayer-3rdparty-src-20151223_2104.7z
  * [DirectX 7 headers](http://www.filewatcher.com/m/dx7headers.tgz.195735-0.html) – dx7headers.tgz
* Extract MSYS2 anywhere in a path without spaces (e.g. C:\msys).
* Extract mingw64 to the MSYS2 directory (e.g. C:\msys\mingw64).
* Extract dx7headers.tgz into mingw64/include directory
* Edit the 'local_prefix' value in the gcc spec file (mingw64\lib\gcc\x86_64-w64-mingw32\4.9.3\specs) accordingly. E.g.:

    ```
    *local_prefix:
    c:/msys/mingw64/lib/gcc/x86_64-w64-mingw32/4.9.3/
    ```
* Edit 'etc\fstab', mount folder /sources, containing 'mplayer' folder (the directory containing this file)

### build mplayer

* Launch the MSYS2 64-bit shell by executing 'mingw64_shell.bat'.
* cd /sources/ (you should have setup /sources mount point in etc/fstab already)
* unzip mplayer-3dparty to /sources/mplayer-3dparty and run:
    ```
    cd /source/mplayer-3rdparty
    ./build_all.sh
    ```
    This script does not work very well with the $PREFIX variable, so it just builds and installs all mplayer dependencies to / (e.g. C:/msys/mingw64/usr/lib, C:/msys/mingw64/usr/include, etc.)

  This will take some time...


* cd /sources/mplayer (the directory containing this file)
* configure
    ```
    ./configure --enable-static --enable-runtime-cpudetection --enable-menu --disable-inet6 --disable-liba52 --disable-libmpeg2-internal --disable-tv --disable-vidix --disable-faac-lavc --extra-cflags=-I/sources/mplayer-3rdparty/live555-x64 --disable-mencoder
    ```
  We use same configure options as the official mplayer binary from [mplayerwin.sourceforge.net](http://mplayerwin.sourceforge.net/downloads.html).

* make
    ```
    make
    ```
