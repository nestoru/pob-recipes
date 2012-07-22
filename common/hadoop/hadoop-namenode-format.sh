#!/bin/bash -e
#hadoop-namenode-format.sh

. common/hadoop/hadoop-constants.sh

su $HADOOP_USER -c 'echo "Y" | $HADOOP_HOME/bin/hadoop namenode -format'

