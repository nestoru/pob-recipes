#!/bin/bash -e
# mount-nfs.sh

USAGE="Usage: `basename $0` <nfsPath> <localPath>"

nfsPath=$1
localPath=$2

mkdir -p $localPath

if [ $# -ne "2" ] 
then
	echo $USAGE
  exit 1 
fi

if ! grep -qs $localPath /proc/mounts; then
   sudo mount $nfsPath $localPath
fi
