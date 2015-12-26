#! /bin/sh

# Prevent locale nonsense from breaking basic text processing utilities
export LC_ALL=C

svn up

test $svn_revision || svn_revision=$(LC_ALL=C svn info 2> /dev/null | grep Revision | cut -d' ' -f2)
test $svn_revision || svn_revision=$(grep revision .svn/entries 2>/dev/null | cut -d '"' -f2)
test $svn_revision || svn_revision=$(sed -n -e '/^dir$/{n;p;q;}' .svn/entries 2>/dev/null)
test $svn_revision || svn_revision=UNKNOWN

echo -n ${svn_revision}>/e/Buildsys/projects/mplayer/packaging/pkg_version