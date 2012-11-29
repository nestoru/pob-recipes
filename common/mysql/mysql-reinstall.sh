#!/bin/bash -e
# common/mysql/mysql.sh

echo -n "mySQL Root Password: "
read -s MYSQL_ROOT_PASSWORD

set +e
/etc/init.d/mysql stop
set -e
if [ -f "/var/lib/mysql" ]; then
  mv /var/lib/mysql ~/temp-backup-mysql
fi
apt-get purge -q -y mysql-server* mysql-common
rm -fr /etc/mysql/
if [ -f "~/temp-backup-mysql" ]; then
  mv ~/temp-backup-mysql /var/lib/mysql
fi
sudo apt-get remove apparmor 
echo "mysql-server-5.5 mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
apt-get -q -y install mysql-server-5.5 mysql-client 
service mysql restart
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "select version()"
