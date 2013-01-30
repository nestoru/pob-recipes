#!/bin/bash -e
# umount-path.sh

USAGE="Usage: `basename $0` <localPath>"

localPath=$1


if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

if grep -qs "$localPath" /proc/mounts; then
    umount "$localPath"
fi
