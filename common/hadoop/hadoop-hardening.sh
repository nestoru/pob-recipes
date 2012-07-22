#!/bin/bash -e
# hadoop-hardening.sh

. common/hadoop/hadoop-constants.sh

passwd -u $HADOOP_USER
pwd=`pwgen -s -y -N 1 20`
echo -e "$pwd\n$pwd" | passwd $HADOOP_USER
passwd -l $HADOOP_USER