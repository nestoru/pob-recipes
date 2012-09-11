#!/bin/bash -e
# sql-heartbeat.sh
# 20120911
# Is my Database Server up?


USAGE="Usage: `basename $0` <dbType: MSSQL/MYSQL> <host> <user> <password>"

if [ $# -ne "4" ]
then
  echo $USAGE
  exit 1
fi

dbType=$1
host=$2
user=$3
password=$4

if [ "$dbType" == "MSSQL" ]; then
  /usr/bin/sqsh -b -U $user -P $password -S $host -D Master -C "select 1"
elif [ "$dbType" == "MYSQL" ]; then
  /usr/bin/mysql -u $user -p$password -h $host -e "select 1"
else
  echo $USAGE
  exit 1
fi

