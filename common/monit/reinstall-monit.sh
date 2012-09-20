#!/bin/bash -e
# name: reinstall-monit.sh
# date: 20120919
# author: Nestor Urquiza

USAGE="Usage: `basename $0` <monitVersion> <sha256>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

monitVersion=$1
sha256=$2

apt-get -q -y install libpam-dev
rm -f monit-${monitVersion}.tar.gz
wget http://mmonit.com/monit/dist/monit-${monitVersion}.tar.gz
openssl dgst -sha256 monit-${monitVersion}.tar.gz | grep " $sha256" ||  exit 1
tar xvfz monit-${monitVersion}.tar.gz 
cd monit-${monitVersion}
./configure --prefix=/usr/sbin --bindir=/usr/sbin --sysconfdir=/etc/monit/
make
make install
monit quit
monit
