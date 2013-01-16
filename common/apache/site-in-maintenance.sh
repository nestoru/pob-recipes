#!/bin/bash -e
# common/apache/site-in-maintenance.sh

USAGE="Usage: `basename $0` <virtualHostFilePath> <isInMaintenance>"

virtualHostFilePath=$1
isInMaintenance=$2

if [ $# -ne "2" ] 
then
  echo $USAGE
  exit 1 
fi

if $isInMaintenance
then
  sed -i "s/#Rewrite/Rewrite/g" $virtualHostFilePath
else
  sed -i "s/[^#]Rewrite/#Rewrite/g" $virtualHostFilePath
fi
apachectl graceful