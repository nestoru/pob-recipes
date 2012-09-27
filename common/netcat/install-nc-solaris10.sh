#!/bin/bash -e
# name: install-nc-solaris10.sh
# date: 20120927
# author: Nestor Urquiza

rm -f nc-110-sol10-x86-local.gz
/usr/sfw/bin/wget http://www.sunfreeware.com/intel/10/nc-110-sol10-x86-local.gz
export sha256="57cb5adf8d2c951608172832d9002a922c7b564213d5865599abdefb358e3280"
digest -a sha256  nc-110-sol10-x86-local.gz |  grep "$sha256" ||  exit 1
gunzip -f nc-110-sol10-x86-local.gz
echo yes | pkgadd -d nc-110-sol10-x86-local all
rm -fr nc-110-sol10-x86-local
/usr/local/bin/nc -h

