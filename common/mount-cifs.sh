#!/bin/bash -e
# mount-cifs.sh

USAGE="Usage: `basename $0` <cifsPath> <localPath> <credentialsPath> <domain> <uid> <gid>"

cifsPath=$1
localPath=$2
credentialsPath=$3
domain=$4
uid=$5
gid=$6


if [ $# -ne "6" ] 
then
	echo $USAGE
  exit 1 
fi

if ! grep -qs "$localPath" /proc/mounts; then
    mount -t cifs "$cifsPath" "$localPath" -o credentials=$credentialsPath,domain=$domain,file_mode=0600,dir_mode=0700,uid=$uid,gid=$gid
fi
