#!/bin/sh

test "$1" && extra="-$1"

# releases extract the version number from the VERSION file
version=$(cat VERSION 2> /dev/null)

if test -z $version ; then
# Extract revision number from file used by daily tarball snapshots
# or from the places different Subversion versions have it.
svn_revision=$(cat snapshot_version 2> /dev/null)
test $svn_revision || svn_revision=$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)
test $svn_revision || svn_revision=$(grep revision .svn/entries 2>/dev/null | cut -d '"' -f2)
test $svn_revision || svn_revision=$(sed -n -e '/^dir$/{n;p;q;}' .svn/entries 2>/dev/null)
test $svn_revision && svn_revision=Redxii-SVN-r$svn_revision
test $svn_revision || svn_revision=UNKNOWN
version=$svn_revision
fi

my_debug=$(cat config.h | grep "#define MP_DEBUG 1")
if [ -n "$my_debug" ] ; then
  my_debug=" debug"
else
  my_debug=
fi

# Get GCC Target
# Best guess to determine 32-bit/64-bit
my_gcctarget=$(LC_ALL=C gcc -v 2>&1 /dev/null | grep "Target:" | cut -d' ' -f2)

if test "$my_gcctarget" = "i686-w64-mingw32" ; then
  my_arch="(i686${my_debug})"
elif test "$my_gcctarget" = "x86_64-w64-mingw32" ; then
  my_arch="(x86_64${my_debug})"
elif test "$my_gcctarget" = "mingw32" ; then
  my_arch="(MinGW${my_debug})"
fi

NEW_REVISION="#define VERSION \"${version}${extra} ${my_arch}\""
OLD_REVISION=$(head -n 1 version.h 2> /dev/null)
BUILD_DATE="#define BUILD_DATE \"$(date "+%F %T %Z")\""
TITLE='#define MP_TITLE "%s "VERSION" (C) 2000-2015 MPlayer Team\nFFmpeg version: "FFMPEG_VERSION"\nBuild date: "BUILD_DATE"\n"'

# Update version.h only on revision changes to avoid spurious rebuilds
if test "$NEW_REVISION" != "$OLD_REVISION"; then
    cat <<EOF > version.h
#include "dev/ffmpeg_version.h"

$NEW_REVISION
$BUILD_DATE
$TITLE
EOF
fi
