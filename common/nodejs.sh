#!/bin/bash -e
# common/nodejs.sh

USAGE="Usage: `basename $0` <version>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

version=$1
user=`logname`
os=`uname`

if [[ "$os" =~ "Darwin" ]]; then
  distroName=node-v${version}-darwin-x64
elif [[ "$os" =~ "SunOS" ]]; then
  distroName=node-v${version}-sunos-x64  
else
  distroName=node-v${version}-linux-x64
fi

distroFileName=${distroName}.tar.gz
cd /opt
curl -O http://nodejs.org/dist/v${version}/$distroFileName
tar -zxvf $distroFileName
rm -f /usr/local/bin/node
rm -f /usr/bin/node
ln -s /opt/$distroName/bin/node /usr/bin/node
ln -s /opt/$distroName/bin/node /usr/local/bin/node
rm -f /usr/local/bin/npm
rm -f /usr/bin/npm
ln -s /opt/$distroName/bin/npm /usr/bin/npm
ln -s /opt/$distroName/bin/npm /usr/local/bin/npm
node --version
mkdir -p /opt/nodejs
rm $distroFileName
root@genevadev:/tm
