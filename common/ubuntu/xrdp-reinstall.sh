#!/bin/bash -e
# common/ubuntu/xrdp-reinstall.sh

apt-get -q -y remove xrdp
apt-get -q -y update
apt-get -q -y clean
apt-get -q -y purge xrdp
apt-get -q -y install xrdp