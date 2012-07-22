#!/bin/bash -e
# hadoop-authorize-master-public-ssh-key.sh

. common/hadoop/hadoop-constants.sh

common/tools/ssh-copy-id-uniq.sh $HADOOP_USER $HADOOP_USER $MASTER_HOSTNAME /home/$HADOOP_USER/.ssh/id_rsa.pub /home/$HADOOP_USER/.ssh/id_rsa

for SLAVE_HOSTNAME in "${SLAVES_HOSTNAMES_ARRAY[@]}"
do
  echo $SLAVE_HOSTNAME
  common/tools/ssh-copy-id-uniq.sh $HADOOP_USER $HADOOP_USER $SLAVE_HOSTNAME  /home/$HADOOP_USER/.ssh/id_rsa.pub /home/$HADOOP_USER/.ssh/id_rsa
done

