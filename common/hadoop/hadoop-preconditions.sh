#!/bin/bash -e
# hadoop-preconditions.sh

hostname=$1

USAGE="Usage: `basename $0` <hostname>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

common/change-hostname.sh $hostname
common/ssh-config.sh
common/ubuntu/refresh-servers-repo.sh

#to install java automatically you will need svn and cifs setup
#common/svn.sh <svn url here>
#common/cifs.sh
#common/ubuntu/bash-config.sh
#common/java.sh jdk-6u33-linux-x64.bin jdk1.6.0_33 <windows domain> <linux user> <linux group> <cifs pob-resource-repository>

common/hadoop/hadoop-environment.sh