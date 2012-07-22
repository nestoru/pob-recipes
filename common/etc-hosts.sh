#!/bin/bash -e
# hadoop-etc-hosts.sh
# only needed if no DNS

svnHostsLocation=$1

USAGE="Usage: `basename $0` <svnHostsLocation>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

cd /etc
cp -p hosts hosts`date "+%Y%m%d"`
svn export $svnHostsLocation hosts