#!/bin/bash -e
# hadoop-environment.sh

. common/hadoop/hadoop-constants.sh

common/tools/reset-var-in-file.sh JAVA_HOME $JAVA_HOME /etc/environment
common/tools/reset-var-in-file.sh HADOOP_HOME $HADOOP_HOME /etc/environment
common/tools/reset-var-in-file.sh PATH $JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH /etc/environment
common/tools/reset-var-in-file.sh JAVA_HOME $JAVA_HOME /home/$HADOOP_USER/.bashrc
common/tools/reset-var-in-file.sh HADOOP_HOME $HADOOP_HOME /home/$HADOOP_USER/.bashrc
common/tools/reset-var-in-file.sh PATH $JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH /home/$HADOOP_USER/.bashrc

