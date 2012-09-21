#!/bin/bash -e
# name: reinstall-monit-solaris10.sh
# date: 20120921
# author: Nestor Urquiza

USAGE="Usage: `basename $0` <monitVersion>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

export monitVersion=$1
export PATH=$PATH:/usr/sfw/bin:/usr/ccs/bin:/tmp
export LD_LIBRARY_PATH=/usr/sfw/lib/64:$LD_LIBRARY_PATH
rm -f /tmp/make
ln -s /usr/sfw/bin/gmake /tmp/make

cd /tmp
rm -f monit-${monitVersion}.tar.gz
rm -f monit-${monitVersion}.tar.gz.sha256
/usr/sfw/bin/wget http://mmonit.com/monit/dist/monit-${monitVersion}.tar.gz
/usr/sfw/bin/wget http://mmonit.com/monit/dist/monit-${monitVersion}.tar.gz.sha256
export sha256=`cat monit-${monitVersion}.tar.gz.sha256 | awk '{print $1}'`
digest -a sha256  monit-${monitVersion}.tar.gz | grep "$sha256" ||  exit 1
gzip -cd  monit-${monitVersion}.tar.gz | tar xfv -
cd monit-${monitVersion}
./configure \
      --with-ssl-incl-dir=/usr/sfw/include \
      --with-ssl-lib-dir=/usr/sfw/lib/64 \
      CFLAGS='-m64 -mtune=opteron' \
      LDFLAGS='-m64 -mtune=opteron'
gmake
gmake install
/usr/local/bin/monit quit
/usr/local/bin/monit
/usr/local/bin/monit -V 

