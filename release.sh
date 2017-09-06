#!/usr/bin/env bash

cd debsource
find {etc,usr,var} -type f -exec md5sum "{}" + > DEBIAN/md5sumsms
cd ../
fakeroot dpkg -b debsource debs/dists/stable/dtinstaller.deb
cd debs/dists/stable/
dpkg --install dtinstaller.deb
dtinstaller