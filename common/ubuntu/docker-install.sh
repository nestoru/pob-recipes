#!/bin/bash -ex
# docker-install.sh
# @author Nestor Urquiza

sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo apt-get install -y python-pip
sudo pip install docker-compose
sudo newgrp docker
sudo service docker restart
major=$(cat /etc/lsb-release | grep DISTRIB_RELEASE | sed -E 's/^[^0-9]*([0-9]*)\..*$/\1/g') 
if [[ "$major" -ge "15" ]]; then
  journalctl -u docker -n100
else
  tail -100 /var/log/upstart/docker.log
fi
