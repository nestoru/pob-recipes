#!/bin/bash -ex
# common/tools/ssh-copy-id-uniq.sh

localUser=$1
remoteUser=$2
remoteHost=$3
publicKey=$4
privateKey=$5

LOCAL_HOST_NAME=`hostname`

USAGE="Usage: `basename $0` <localUser> <remoteUser> <remoteHost> <publicKey> <privateKey>"

if [ $# -ne "5" ] 
then
	echo $USAGE
  exit 1 
fi

su $localUser -c "ssh-copy-id -i $publicKey $remoteUser@$remoteHost"
ssh -i $privateKey $remoteUser@$remoteHost "sed -i \"\\\$!{/$localUser@$LOCAL_HOST_NAME/d;}\" ~/.ssh/authorized_keys"

