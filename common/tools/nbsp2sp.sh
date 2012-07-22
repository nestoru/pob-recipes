#!/bin/bash -e
# nbsp2sp.sh

filePath=$1

USAGE="Usage: `basename $0` <filePath>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

tr '\240' ' ' < $filePath > /tmp/tmp && mv /tmp/tmp $filePath
