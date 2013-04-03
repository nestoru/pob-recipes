#!/bin/bash -e
# common/mysql/mysql-change-collation-all-tables-db.sh

USAGE="Usage: `basename $0` <host> <user> <db> <collation (i.e utf8_unicode_ci)>"

if [ $# -ne "4" ]
then
  echo $USAGE
  exit 1
fi

host=$1
user=$2
db=$3
collation=$4

echo -n "mySQL Root Password: "
read -s MYSQL_ROOT_PASSWORD
tables=`mysql -h $host -u $user -p$MYSQL_ROOT_PASSWORD $db -e 'show tables'`
for table in $tables
do
  if [[ ! $table =~ ^Tables.in.* ]]; then
  	sql="ALTER TABLE $table COLLATE $collation"
  	echo $sql 
    mysql -h $host -u $user -p$MYSQL_ROOT_PASSWORD $db -e "$sql"
  fi
done

