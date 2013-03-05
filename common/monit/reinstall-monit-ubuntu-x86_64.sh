#!/bin/bash -e
#common/monit/reinstall-monit-ubuntu-x86_64.sh

USAGE="Usage: `basename $0` <monitVersion> <sha256>"

if [ $# -ne "2" ] 
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
./configure --prefix=/usr/bin --bindir=/usr/bin --sysconfdir=/etc/monit/ --with-ssl-lib-dir=/usr/lib/x86_64-linux-gnu
make
make install

