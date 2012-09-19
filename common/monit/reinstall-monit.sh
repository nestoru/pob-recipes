#!/bin/bash -e
# name: reinstall-monit.sh
# date: 20120919
# author: Nestor Urquiza

USAGE="Usage: `basename $0` <monitVersion>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

monitVersion=$1

apt-get -q -y install libpam-dev
rm -f monit-${monitVersion}.tar.gz
wget http://mmonit.com/monit/dist/monit-${monitVersion}.tar.gz
openssl dgst -sha256 monit-${monitVersion}.tar.gz | grep " 8276b060b3f0e6453c9748d421dec044ddae09d3e4c4666e13472aab294d7c53$" ||  exit 1
tar xvfz monit-${monitVersion}.tar.gz 
cd monit-${monitVersion}
./configure --prefix=/usr/sbin --bindir=/usr/sbin --sysconfdir=/etc/monit/
make
make install
monit quit
monit
