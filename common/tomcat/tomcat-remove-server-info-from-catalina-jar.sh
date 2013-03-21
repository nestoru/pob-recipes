#!/bin/bash -e
# common/tomcat/tomcat-remove-server-info-from-catalina-jar.sh
# This takes care of just catalina.jar. Changes in server.xml 8080 and 8009 connectors are also needed but for those you should be OK maintaining the config files on svn and deploy them from another recipe
USAGE="Usage: `basename $0` <catalinaHome>"

if [ $# -ne "1" ]
then
  echo $USAGE
  exit 1
fi

catalinaHome=$1
topPackageDomain=org
serverInfoProperties=$topPackageDomain/apache/catalina/util/ServerInfo.properties

cd $catalinaHome/lib
#extract in temporary directory (starting with the top package domain) the properties file
jar xf catalina.jar $serverInfoProperties
#Comment the previous configuration
sed -i "s/\(^server.info.*\)/#\1/g" $serverInfoProperties
sed -i "s/\(^server.number.*\)/#\1/g" $serverInfoProperties
sed -i "s/\(^server.built.*\)/#\1/g" $serverInfoProperties
#Add less explicit configuration detail
echo >> $serverInfoProperties
echo "server.info=Apache" >> $serverInfoProperties
echo "server.number=" >> $serverInfoProperties
echo "server.built=" >> $serverInfoProperties
jar uf catalina.jar $serverInfoProperties
chown `logname`:`logname` catalina.jar
#remove temporary directory
rm -fr $topPackageDomain
service tomcat restart