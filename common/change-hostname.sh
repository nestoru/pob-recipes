#!/bin/bash -e
# change-hostname.sh

hostname=$1

USAGE="Usage: `basename $0` <hostname>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

#sed -i "/$hostname/d" /etc/hosts && bash -c "echo '127.0.0.1 $hostname' >> /etc/hosts"
HOST_ENTRY="${grep $hostname /etc/hosts}"
: ${HOST_ENTRY:?"$hostname not found in /etc/hosts"}
echo $hostname > /etc/hostname
hostname -F /etc/hostname


