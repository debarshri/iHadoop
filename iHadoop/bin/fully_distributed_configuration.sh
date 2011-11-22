#!/bin/bash 
#
#Author: vanshish.mehra@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#





loop()
{
echo ".................................................."
echo ".     Configuring Hadoop on all the machines     ."
echo ".................................................."
exec 7>&0
exec<conf/sshlist
value=0;
while read line
   do
                machine=$(echo $line | awk '{ print $1 }')
                username=$(echo $line | awk '{ print $2 }')
                ip=$(echo $line | awk '{ print $3 }')
                case $machine in
                master)echo "configuring Hadoop on master machine";;
                checkpoint)echo "configuring Hadoop on checkpoint machine";scp -r $HADOOP_HOME/conf $username@$ip:$HADOOP_HOME/;;
                jobtracker)echo "configuring Hadoop on jobtracker machine";scp -r $HADOOP_HOME/conf $username@$ip:$HADOOP_HOME/;;
                slave)value=`expr $value + 1`;echo "configuring Hadoop on slave$value machine";scp -r $HADOOP_HOME/conf $username@$ip:$HADOOP_HOME/;;
                esac
            echo $line;
   done
exec 0<&7 7<&-
echo " "
bin/cluster_fully.sh
}
clear
if [ $HADOOP_HOME ]
then
echo "Your Hadoop Home is $HADOOP_HOME"
else
echo "please enter the version"
read version1
export ves=$version1
export HADOOP_HOME=$HOME/hadoop-"$ves"
echo $HADOOP_HOME
fi


echo "Enter the default port number for namenode" 
read port
export port_0="$port"
echo "Enter the port number for mapreduce"
read port1
export port_1="$port1"
echo "Enter the host name for namenode(Other than localhost)"
read hostn
while [ "$hostn" == "localhost" ]
do 
echo "Please change hostname (other than localhost)"
read hostn
done
export host1="$hostn"
echo "Enter the host name for jobtracker(other than localhost)"
read hostj
while [ "$hostj" ==  "localhost" ]
do
echo "Please change hostname for jobtracker(other than localhost)"
read hostj
done
export host2="$hostj"
flag=0
while [ "$flag" == "0" ]
do
echo "Please enter the replication factor for the cluster"
read repli
slaves_replication="`cat conf/slaves|wc -l`"
if [ "$repli" -le "$slaves_replication" ] ;then  
export replication="$repli"
flag=1 
else
echo "Replication factor should be less than equal to number of slaves in the cluster"
fi
done
echo "Setting configuartions"
export JAVA_HOME=/usr/java/jdk1.6.0_25
echo $JAVA_HOME
#echo "">$HADOOP_HOME/conf/hadoop-env.sh
echo " ">$HADOOP_HOME/conf/core-site.xml
echo " ">$HADOOP_HOME/conf/hdfs-site.xml
echo " ">$HADOOP_HOME/conf/mapred-site.xml
echo "">$HADOOP_HOME/conf/masters
echo "">$HADOOP_HOME/conf/slaves
sed -i 's|# export JAVA_HOME=/usr/lib/j2sdk1.5-sun|JAVA_HOME=$JAVA_HOME|' $HADOOP_HOME/conf/hadoop-env.sh

sed -i 's_ _<?xml version="1.0"?>\n<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>\n\n<configuration>\n\n<property>\n<name>fs.default.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs</value>\n</property>\n\n<property>\n<name>fs.default.name</name>\n<value>hdfs://master:'$port_0'/</value>\n</property>\n\n</configuration>_' $HADOOP_HOME/conf/core-site.xml

sed -i 's_ _<?xml version="1.0"?>\n<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>\n\n<configuration>\n\n<property>\n<name>dfs.name.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/dfs/name</value>\n</property>\n\n<property>\n<name>dfs.data.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/dfs/data</value>\n</property>\n\n<property>\n<name>dfs.http.address</name>\n<value>master:50070</value>\n</property>\n\n<property>\n<name>dfs.replication</name>\n<value>'$replication'</value>\n</property>\n\n</configuration>_' $HADOOP_HOME/conf/hdfs-site.xml

sed -i 's_ _<?xml version="1.0"?>\n<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>\n\n<configuration>\n\n<property>\n<name>mapred.job.tracker</name>\n<value>jobtracker:'$port_1'</value>\n</property>\n\n</configuration>_' $HADOOP_HOME/conf/mapred-site.xml

cat conf/slaves|awk '{ print $2 }'>$HADOOP_HOME/conf/slaves
#sed -i 's_localhost_'cat conf/slaves|awk '{ print $1 }''_' $HADOOP_HOME/conf/slaves

cat conf/masters|awk '{print $2 }'>$HADOOP_HOME/conf/masters
#sed -i 's_localhost_'$host1' _' $HADOOP_HOME/conf/masters
checkpoint_hostname=$(cat conf/checkpoint|awk '{ print $3 }')
if [ "$checkpoint_hostname" != "$host1" ]
then
echo "check point=a,$checkpoint_hostname"
echo "host=$host1"
cat conf/checkpoint|awk '{print $3 }'>>$HADOOP_HOME/conf/masters
fi

export CLASSPATH="$CLASSPATH":"$HADOOP_HOME"
#cd $exp
echo "Press any key to continue..." 



loop
