#!/bin/bash -e
# hadoop-slave.sh

hostname=$1

USAGE="Usage: `basename $0` <hostname>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

common/hadoop/hadoop-preconditions.sh $hostname
common/hadoop/hadoop-install.sh
common/hadoop/hadoop-full-distributed-config.sh
common/hadoop/hadoop-generate-ssh-public-key.sh
common/hadoop/hadoop-authorize-slave-public-ssh-key.sh
