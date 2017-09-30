#!/bin/bash -e
# crlf2lf.sh
# @author: Nestor Urquiza
# @date: 20170930
# description: quick replacement for dos2unix that avoids typing ^v^m to get a literal CR or ^M when using sed. 
#   Make sure you download this file.
#   If you copy and paste make sure you write ^M by typing ^v and then ^m

USAGE="Usage: `basename $0` <win_dos_file>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

sed -i.bak 's//\'$'\n/g' $1
