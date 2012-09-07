#!/bin/bash -e
# assert-user-quota-not-exceeded.sh
# author: Nestor Urquiza
# date: 20120907
# description: Returns in stderr those user quotas which have exceeded maximum percentage parameter

maxPercentage=$1

USAGE="Usage: `basename $0` <maxPercentage>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1
fi
res=`/usr/sbin/repquota -a|awk -v maxP=$maxPercentage '{if($4+0>0 && (($3/$4)*100) > maxP){print $0 " " ($3/$4)*100 "%"}}'`
if [ "$res" ]
then
  echo "User            used    soft    hard  grace    used  soft  hard  grace percentage" 1>&2
  printf "%s\n" "$res" 1>&2
  exit 1
fi

