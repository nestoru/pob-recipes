#!/bin/bash -e
#hadoop-full-distributed-config.sh

. common/hadoop/hadoop-constants.sh

common/hadoop/hadoop-config.sh "hdfs://hadoop-master:9000" "hadoop-master:9001" "$SLAVES_NUMBER"


