#!/bin/bash
# common/tools/findClassInJars.sh
# author: Nestor Urquiza
# date: 20120117
# description: Find a class indentified



USAGE="Usage: `basename $0` <jarsParentDirectory> <classNamePattern>"

if [ $# -ne "2" ]
then
  echo $USAGE
  exit 1
fi

jarsParentDirectory=$1
classNamePattern=$2

for jar in $(find $jarsParentDirectory/ -name "*.jar")
do
	matches=$(jar -tvf $jar | grep $classNamePattern)
	if [ "$matches" != "" ]
	then
		echo "---------------------------------------------"
		echo "file: $jar"
		echo "---------------------------------------------"
		echo -e $matches
		echo
	fi
done
