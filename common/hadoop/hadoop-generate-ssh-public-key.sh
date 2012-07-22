#!/bin/bash -e
# hadoop-generate-ssh-public-key.sh

. common/hadoop/hadoop-constants.sh
su - $HADOOP_USER -c "ssh-keygen -t rsa -N '' -f /home/$HADOOP_USER/.ssh/id_rsa"


