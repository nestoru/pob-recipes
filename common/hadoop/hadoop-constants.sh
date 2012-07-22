#!/bin/bash -e
# hadoop-constants.sh

export HADOOP_USER=hadoop
export HADOOP_VERSION=1.0.3
export HADOOP_BASE_DIR=/usr/local
export HADOOP_HOME=${HADOOP_BASE_DIR}/hadoop

export MASTER_HOSTNAME=hadoop-master
export SLAVES_HOSTNAMES_ARRAY=( hadoop-slave1 hadoop-slave2 )
export SLAVES_HOSTNAMES_SPACE_SEP="${SLAVES_HOSTNAMES_ARRAY[*]}"
OLD_IFS=$IFS
IFS=$'\n'
export SLAVES_HOSTNAMES_LINEFEED_SEP="${SLAVES_HOSTNAMES_ARRAY[*]}"
IFS=$OLD_IFS
#export SLAVES_HOSTNAMES_LINEFEED_SEP=`echo $SLAVES_HOSTNAMES_SPACE_SEP | tr ' ' '\n'`
export SLAVES_NUMBER=${#SLAVES_HOSTNAMES_ARRAY[@]}

# only needed if no DNS
export MASTER_IP=192.168.56.10
export SLAVES_IPS_ARRAY=( 192.168.56.11, 192.168.56.12 )
export JAVA_HOME=/opt/jdk
