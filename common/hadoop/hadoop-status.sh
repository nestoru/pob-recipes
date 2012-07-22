#!/bin/bash -e
# hadoop-status.sh

. common/hadoop/hadoop-constants.sh

su $HADOOP_USER -c  'jps'