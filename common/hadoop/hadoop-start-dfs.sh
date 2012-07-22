#!/bin/bash -e
# hadoop-start-dfs.sh

. common/hadoop/hadoop-constants.sh

su $HADOOP_USER -c "$HADOOP_HOME/bin/start-dfs.sh"

