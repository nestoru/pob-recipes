#!/bin/bash -e
# ireport-gui-install.sh

USAGE="Usage: `basename $0` <cifsDirectory> <localDirectory> <windowsDomain> <linuxUser> <linuxGroup> <version>"

CREDENTIALS_PATH="/root/projects/cifs/cifs_smbmount.txt"

cifsDirectory=$1
localDirectory=$2
windowsDomain=$3
linuxUser=$4
linuxGroup=$5
version=$6


if [ $# -ne "6" ] 
then
	echo $USAGE
  exit 1 
fi

distributionFileName=iReport-${version}.tar.gz
mkdir -p "$localDirectory"
common/umount-path.sh "$localDirectory"
common/mount-cifs.sh "$cifsDirectory" "$localDirectory" $CREDENTIALS_PATH $windowsDomain $linuxUser $linuxGroup
echo "Copying distribution file. Might take a while depending on your connection ..."
cp "$localDirectory/$distributionFileName" /opt/


cd /opt
tar xvfz iReport-${version}.tar.gz
cd iReport-${version}
chown -R $linuxUser:$linuxUser /opt/iReport-${version}/
rm -f /opt/iReport
ln -s /opt/iReport-${version} /opt/iReport
cp /opt/iReport/bin/document.ico /usr/share/pixmaps/ireport.ico
cd ~/recipes
common/gnome-application-launcher.sh iReport /opt/iReport/bin/ireport /usr/share/pixmaps/ireport.ico 
