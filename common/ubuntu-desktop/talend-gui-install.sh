#!/bin/bash -e
# talend-gui-install.sh

USAGE="Usage: `basename $0` <cifsDirectory> <localDirectory> <windowsDomain> <linuxUser> <linuxGroup> <distributionFileName> <distributionVersion>"

CREDENTIALS_PATH="/root/projects/cifs/cifs_smbmount.txt"

cifsDirectory=$1
localDirectory=$2
windowsDomain=$3
linuxUser=$4
linuxGroup=$5
distributionFileName=$6
distributionVersion=$7


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
src=$distributionVersion
dst=$distributionVersion-`date "+%Y%m%d"`
if [ -d "$src" ]; then
  echo "Backing up previous Talend installation ..."
  rm -fr $dst
  mv $src $dst
fi
unzip $distributionFileName
#remember to always get back to the root
cd ~/recipes
chown -R $linuxUser:$linuxUser /opt/$distributionVersion/
ln -s /opt/$distributionVersion /opt/TOS
cp /opt/TOS/plugins/*/icons/appli_48x48.xpm /usr/share/pixmaps/talend_48x48.xpm
common/gnome-application-launcher.sh Talend /opt/TOS/TalendOpenStudio-linux-gtk-x86_64 talend_48x48.xpm
