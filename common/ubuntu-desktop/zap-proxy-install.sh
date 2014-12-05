#!/bin/bash -e
# common/ubuntu-desktop/zap-proxy-install.sh

USAGE="Usage: `basename $0` <version>"

version=$1

if [ $# -ne "1" ] 
then
	echo $USAGE
	exit 1 
fi

rm -fR /opt/zap
cd /tmp
curl -L http://sourceforge.net/projects/zaproxy/files/${version}/ZAP_${version}_Linux.tar.gz/download -o ZAP_${version}.tar.gz
tar -zxvf ZAP_${version}.tar.gz
mv ZAP_${version} /opt/zap
chown -R `logname`:`logname` /opt/zap
echo "ZAP was installed successfully in /opt/zap. Run it as 'ssh -X localhost /opt/zap/zap.sh'"
