#!/bin/bash -e
# common/nodejs.sh

USAGE="Usage: `basename $0` <version> <user>"

if [ $# -ne "2" ] 
then
  echo $USAGE
  exit 1 
fi

version=$1
user=$2
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
rm -fr $optDir
mkdir -p $optDir
distroFileName=${distroName}.tar.gz
cd $optDir 
curl -OL https://nodejs.org/dist/v${version}/$distroFileName
tar -zxvf $distroFileName
mkdir -p /usr/local/bin/
ln -s $optDir/$distroName/bin/node /usr/local/bin/node
ln -s $optDir/$distroName/bin/npm /usr/local/bin/npm
rm -fr /usr/local/lib/node_modules
rm $distroFileName
npm config set prefix /usr/local
chown -R $user /usr/local/bin
chown -R $user /usr/local/lib
chown -R $user $optDir/
node --version
