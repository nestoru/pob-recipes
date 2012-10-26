#!/bin/bash -e
# common/ubuntu/cron-apt-security-update-reinstall.sh


scriptName=`basename $0`

USAGE=`cat <<EOF
Usage:
=====
$scriptName <mailTo> <mailOn

Description:
===========
Remove any previous cron-apt installation and reinstall it configuring it to automatically apply security fixes *only*
Do not use if you have already configured cron-apt. If that is the case use a different version of this script downloading your configuration from a repository.
Installs cron-apt and configures it to automatically patch *only* the security of the system
Use mailOn="upgrade" (recommended) to receive emails only when security upgrades have been applied
Use mailOn="output" to get information about other packages waiting to be installed
See more options in /etc/cron-apt/config
Note that cron-apt cron entries are in /etc/cron.d/cron-apt in case you want to change the scheduling time
EOF
`

if [ $# -ne "2" ]
then
        echo "$USAGE"
  exit 1
fi

mailTo=$1
mailOn=$2

echo "removing cron-apt ..."
apt-get -q -y remove cron-apt
echo "purging cron-apt config files ..."
apt-get -q -y purge cron-apt
echo "installing cron-apt ..."
apt-get -q -y install cron-apt
echo "creating security.sources.list file out of the sources.list of your distro ..."
cat /etc/apt/sources.list|grep "^[^#]*security" > /etc/apt/security.sources.list
echo "configuring to include the security sources list ..."
sed -i 's/^#.*\(OPTIONS.*security.sources.list"$\)/\1/g' /etc/cron-apt/config
echo "configuring to mail to '$mailTo' ..."
sed -i "s/^#.*MAILTO=\"root\"/MAILTO=\"$mailTo\"/g" /etc/cron-apt/config
echo "configuring mail on '$mailOn' ..."
sed -i "s/^#.*MAILON=\"error\"/MAILON=\"$mailOn\"/g" /etc/cron-apt/config
echo "configuring to upgrade automatically ..."
sed -i 's/dist-upgrade -d -y/upgrade -u -y/g' /etc/cron-apt/action.d/3-download
