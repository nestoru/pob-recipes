#!/bin/bash -e
# hadoop-start-mapred.sh

. common/hadoop/hadoop-constants.sh

su $HADOOP_USER -c "$HADOOP_HOME/bin/stop-mapred.sh"

