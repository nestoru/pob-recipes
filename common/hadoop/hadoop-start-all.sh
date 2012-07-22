#!/bin/bash -e
#
# Restarts hadoop

. common/hadoop/hadoop-constants.sh

su $HADOOP_USER -c  'start-all.sh'

