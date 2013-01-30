#!/bin/bash -e
# common/apache/google-pagespeed-install.sh

USAGE="Usage: `basename $0` <nfsPath> <binaryFile>"

nfsPath=$1
binaryFile=$2
binaryLocalPath=/tmp/google-pagespeed-install

common/umount-path.sh $binaryLocalPath
common/mount-nfs.sh $nfsPath $binaryLocalPath

if [ $# -ne "2" ] 
then
  echo $USAGE
  exit 1 
fi

echo "Installing Google pagespeed module"
cd $binaryLocalPath
sudo dpkg -i $binaryFile
sed -i 's/^\([^#]*\)#.*\(ModPagespeedEnableFilters rewrite_javascript,rewrite_css\)/\1\2/g' /etc/apache2/mods-enabled/pagespeed.conf 
sed -i 's/^\([^#]*\)#.*\(ModPagespeedEnableFilters collapse_whitespace,elide_attributes\)/\1\2/g' /etc/apache2/mods-enabled/pagespeed.conf 
sed -i 's/^\([^#]*\)#.*\(ModPagespeedEnableFilters canonicalize_javascript_libraries\)/\1\2/g' /etc/apache2/mods-enabled/pagespeed.conf 
echo "New Google pagespeed module configuration:"
grep ModPagespeedEnableFilters /etc/apache2/mods-enabled/pagespeed.conf 
service apache2 restart