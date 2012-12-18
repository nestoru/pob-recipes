#!/bin/bash -e
# eclipse-gui-install.sh

USAGE="Usage: `basename $0` <cifsDirectory> <localDirectory> <windowsDomain> <linuxUser> <linuxGroup> <distributionFileName>"

CREDENTIALS_PATH="/root/projects/cifs/cifs_smbmount.txt"

cifsDirectory=$1
localDirectory=$2
windowsDomain=$3
linuxUser=$4
linuxGroup=$5
distributionFileName=$6


if [ $# -ne "7" ] 
then
	echo $USAGE
  exit 1 
fi

mkdir -p "$localDirectory"
common/umount-path.sh "$localDirectory"
common/mount-cifs.sh "$cifsDirectory" "$localDirectory" $CREDENTIALS_PATH $windowsDomain $linuxUser $linuxGroup
echo "Copying distribution file. Might take a while depending on your connection ..."
cp "$localDirectory/$distributionFileName" /opt/
cd /opt/
gzip -cd $distributionFileName | tar xfv -
chown -R $linuxUser:$linuxUser /opt/eclipse/
common/gnome-application-launcher.sh Eclipse /opt/eclipse/eclipse /opt/eclipse/icon.xpm
