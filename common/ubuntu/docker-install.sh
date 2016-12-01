#!/bin/bash -e
# docker-install.sh
# @author Nestor Urquiza

curl -sSL https://get.docker.com/ | sh
sudo newgrp docker
sudo usermod -aG docker `logname`
sudo apt-get install -y python-pip
sudo pip install docker-compose
sudo service docker restart
major=$(cat /etc/lsb-release | grep DISTRIB_RELEASE | sed -E 's/^[^0-9]*([0-9]*)\..*$/\1/g')
if [[ "$major" -ge "15" ]]; then
  journalctl -u docker -n100 --no-pager
else
  tail -100 /var/log/upstart/docker.log
fi
echo
echo "Logout and login back!!!"
