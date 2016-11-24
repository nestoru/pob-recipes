#!/bin/bash -ex
# docker-install.sh
# @author Nestor Urquiza

curl -sSL https://get.docker.com/ | sh
usermod -aG docker $USER
apt-get install -y python-pip
pip install docker-compose
newgrp docker
service docker restart
major=$(cat /etc/lsb-release | grep DISTRIB_RELEASE | sed -E 's/^[^0-9]*([0-9]*)\..*$/\1/g') 
if [[ "$major" -ge "15" ]]; then
  journalctl -u docker -n100
else
  tail -100 /var/log/upstart/docker.log
fi
