#!/bin/bash -e
#hadoop-master.sh

common/hadoop/hadoop-common-master.sh
common/hadoop/hadoop-namenode-format.sh
common/hadoop/hadoop-generate-ssh-public-key.sh
common/hadoop/hadoop-authorize-master-public-ssh-key.sh
  
common/hadoop/hadoop-stop-mapred.sh
common/hadoop/hadoop-stop-dfs.sh
common/hadoop/hadoop-start-dfs.sh
common/hadoop/hadoop-start-mapred.sh

common/hadoop/hadoop-status.sh
common/hadoop/hadoop-environment.sh


