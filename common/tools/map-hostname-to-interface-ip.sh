#!/bin/bash -e
# common/tools/map-hostname-to-interface-ip.sh
# author: Nestor Urquiza
# date: 20121130
# description: Looks for the IP in the specified interface and creates an entry in etc/hosts for the supplied domain

maxSize=$1

USAGE="Usage: `basename $0` <hostname> <interface>"

if [ $# -ne "2" ]
then
  echo $USAGE
  exit 1
fi

hostname=$1
interface=$2

ip=`hostname -i`
sed -i "/$hostname/d" /etc/hosts && bash -c "echo '$ip $hostname' >> /etc/hosts"
