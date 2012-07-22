#!/bin/bash -e
# hadoop-authorize-slave-public-ssh-key.sh

. common/hadoop/hadoop-constants.sh

common/tools/ssh-copy-id-uniq.sh $HADOOP_USER $HADOOP_USER $MASTER_HOSTNAME /home/$HADOOP_USER/.ssh/id_rsa.pub /home/$HADOOP_USER/.ssh/id_rsa
