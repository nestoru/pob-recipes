#!/bin/bash -e
# name: show-grants-mysql.sh 
# date: 20120928
# author: Nestor Urquiza

USAGE="Usage: `basename $0` <mysql connection options>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

mysql -B -N $@ -e "SELECT DISTINCT CONCAT(
    'SHOW GRANTS FOR ''', user, '''@''', host, ''';'
    ) AS query FROM mysql.user" | mysql $@ | sed 's/\(Grants for.*\)/#\1/g'

