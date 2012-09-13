#!/bin/bash -e
# assert-no-big-files.sh
# author: Nestor Urquiza
# date: 2012013
# description: Returns in stderr those files which have exceeded maximum size parameter

maxSize=$1

USAGE="Usage: `basename $0` <maxSize (number of bytes/k/M/G)>"

if [ $# -ne "1" ]
then
  echo $USAGE
  exit 1
fi



res=`find / -type f -size +$maxSize -exec ls -lh {} \;  2> /dev/null | grep -v kcore`
if [ "$res" ]
then
  printf "%s\n" "$res" 1>&2
  exit 1
fi
