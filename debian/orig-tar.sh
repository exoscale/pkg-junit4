#!/bin/sh -e

# called by uscan with '--upstream-version' <version> <file>
VERSION=$2
DIR=junit4-$VERSION
TAR=../junit4_$VERSION.orig.tar.gz
ORIG_TAR=$3

#rm -f $3
#wget -O $TAR http://github.com/KentBeck/junit/archive/r$VERSION

# clean up the upstream tarball
mkdir $DIR
tar -x -v -z -f $ORIG_TAR
rm $ORIG_TAR
find . -maxdepth 2 -wholename "./junit-*/*" -exec mv '{}' $DIR \;
GZIP=--best tar -c -z -f $TAR -X debian/orig-tar.exclude $DIR
rm -rf $DIR junit-*

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
    . .svn/deb-layout
    mv $TAR $origDir
    echo "moved $TAR to $origDir"
fi
