#!/bin/bash -e
# common/couch.sh

couchpid=`ps -ef|grep couch | grep -v grep | awk '{print $2}'`
if [ $couchpid ]; then kill -9 $couchpid; fi
apt-get -q -y update
apt-get -q -y autoremove
apt-get -q -y remove couchdb*
apt-get -q -y purge couchdb*
apt-get -q -y build-dep couchdb
apt-get -q -y install libtool zip
cd ~/recipes
rm -fr js-1.8.5
curl -O http://ftp.mozilla.org/pub/mozilla.org/js/js185-1.0.0.tar.gz
tar xvzf js185-1.0.0.tar.gz 
cd js-1.8.5/js/src
./configure
make
make install
cd ~/recipes
rm -fr otp_src_R14B0
curl -O http://www.erlang.org/download/otp_src_R14B04.tar.gz
tar xvzf otp_src_R14B04.tar.gz 
cd otp_src_R14B04
./configure --enable-smp-support --enable-dynamic-ssl-lib --enable-kernel-poll
make
make install
cd ~/recipes
rm -fr apache-couchdb-1.1.1
 curl -O http://www.gtlib.gatech.edu/pub/apache/couchdb/releases/1.2.0/apache-couchdb-1.2.0.tar.gz
tar xvzf apache-couchdb-1.2.0.tar.gz
cd apache-couchdb-1.2.0
prefix='/usr/local'
./configure --prefix=${prefix} 
make
make install
grep couchdb /etc/passwd || useradd -d /var/lib/couchdb couchdb
chown -R couchdb:couchdb ${prefix}/var/{lib,log,run}/couchdb ${prefix}/etc/couchdb
for dir in `whereis couchdb | sed 's/couchdb: //'`; do echo $dir | xargs chown couchdb; done
export xulrunnerversion=`xulrunner -v 2>&1 >  /dev/null | egrep -o "([0-9]{1,2})(\.[0-9]{1,2})+"`
echo $xulrunnerversion
echo "/usr/lib/xulrunner-$xulrunnerversion" > /etc/ld.so.conf.d/xulrunner.conf
echo "/usr/lib/xulrunner-devel-$xulrunnerversion" >> /etc/ld.so.conf.d/xulrunner.conf
/sbin/ldconfig
ln -s /usr/local/etc/init.d/couchdb /etc/init.d/couchdb
update-rc.d couchdb defaults
/etc/init.d/couchdb start
curl -X GET http://localhost:5984
