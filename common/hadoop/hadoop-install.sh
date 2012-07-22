#!/bin/bash -e
# hadoop-install.sh

. common/hadoop/hadoop-constants.sh

grep $HADOOP_USER /etc/passwd || useradd -m $HADOOP_USER && usermod -s /bin/bash hadoop
cd $HADOOP_BASE_DIR
rm -fr $HADOOP_VERSION
curl -O http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
tar xvzf hadoop-${HADOOP_VERSION}.tar.gz 
rm -f hadoop
ln -s hadoop-$HADOOP_VERSION hadoop
#chown -R $HADOOP_USER hadoop-$HADOOP_VERSION
chown -RL $HADOOP_USER /usr/local/hadoop
sed "/HADOOP_HOME/d" ~/.bashrc > tmp && echo >> tmp && printf 'export HADOOP_HOME=/usr/local/hadoop\nexport PATH=$PATH:$HADOOP_HOME/bin' >> tmp && mv tmp ~/.bashrc
grep HADOOP_HOME_WARN_SUPPRESS $HADOOP_HOME/conf/hadoop-env.sh || printf 'HADOOP_HOME_WARN_SUPPRESS="TRUE"' >> $HADOOP_HOME/conf/hadoop-env.sh
rm -fr $HADOOP_VERSION
export JAVA_HOME=/opt/jdk
passwd -u $HADOOP_USER
echo "WARNING: Changing $HADOOP_USER password temporarily. Once keys are authorized run common/hadoop/hadoop-hardening.sh"
echo -e "secret\nsecret" | passwd $HADOOP_USER
$HADOOP_HOME/bin/hadoop version