#!/bin/bash -e
# generate-ssh-public-key.sh

USAGE="Usage: `basename $0` <user>"

if [ $# -ne "1" ] 
then
	echo $USAGE
  exit 1 
fi

user=$1

mkdir -p /home/$user/.ssh
su - $user -c "ssh-keygen -t rsa -N '' -f /home/$user/.ssh/id_rsa"


