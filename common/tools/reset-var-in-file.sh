#!/bin/bash -e
# reset-var-in-file.sh

var=$1
value=$2
filePath=$3

USAGE="Usage: `basename $0` <var> <value> <filePath>"

if [ $# -ne "3" ] 
then
	echo $USAGE
  exit 1 
fi

sed "/$var/d" $filePath > tmp && echo >> tmp && echo "export $var=$value" >> tmp && mv tmp $filePath
