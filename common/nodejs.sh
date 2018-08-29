#!/bin/bash -e
# common/nodejs.sh

USAGE="Usage: `basename $0` <version>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

version=$1
user=$USER
os=`uname`

rm -f /usr/local/bin/node
rm -f /usr/bin/node
rm -f /usr/local/bin/npm
rm -f /usr/bin/npm

if [[ "$os" =~ "Darwin" ]]; then
  distroName=node-v${version}-darwin-x64
else
  distroName=node-v${version}-linux-x64
fi

optDir=/usr/local/.opt
mkdir -p $optDir
rm -fr $optDir/node-*
distroFileName=${distroName}.tar.gz
cd $optDir 
curl -O http://nodejs.org/dist/v${version}/$distroFileName
tar -zxvf $distroFileName
mkdir -p /usr/local/bin/
ln -s $optDir/$distroName/bin/node /usr/local/bin/node
ln -s $optDir/$distroName/bin/npm /usr/local/bin/npm
rm -fr /usr/local/lib/node_modules
rm $distroFileName
npm config set prefix /usr/local
node --version
