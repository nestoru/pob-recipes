#!/bin/bash -e
# hadoop-config.sh

USAGE="Usage: `basename $0` <fsDefaultName> <mapredJobTracker> <blockReplication>"

fsDefaultName=$1
mapredJobTracker=$2
blockReplication=$3

if [ $# -ne "3" ] 
then
	echo $USAGE
  exit 1 
fi

. common/hadoop/hadoop-constants.sh

cat > $HADOOP_HOME/conf/core-site.xml <<DELIM1
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>fs.default.name</name>
    <value>$fsDefaultName</value>
  </property>
</configuration>
DELIM1

cat > $HADOOP_HOME/conf/hdfs-site.xml <<DELIM2
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>$blockReplication</value>
  </property>
</configuration>
DELIM2

cat > $HADOOP_HOME/conf/mapred-site.xml <<DELIM3
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>mapred.job.tracker</name>
    <value>$mapredJobTracker</value>
  </property>
</configuration>
DELIM3

chown $HADOOP_USER $HADOOP_HOME/conf/core-site.xml
chown $HADOOP_USER $HADOOP_HOME/conf/hdfs-site.xml
chown $HADOOP_USER $HADOOP_HOME/conf/mapred-site.xml
HEADER_HIGHLIGHT="-----------------------------"
for i in $HADOOP_HOME/conf/*site.xml; do echo $HEADER_HIGHLIGHT; echo "$i"; echo $HEADER_HIGHLIGHT; cat "$i"; done


