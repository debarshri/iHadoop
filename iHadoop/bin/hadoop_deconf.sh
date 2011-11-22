#
#Author: Debarshi.basak@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#





old_roll_path="`pwd`"
cd $HADOOP_HOME/conf

echo " "
echo " "
echo "Resetting configurations"
echo " "
echo " "

sed -i 's_<property>_ _' core-site.xml
sed -i 's_<name>_ _' core-site.xml
sed -i 's_<value>_ _' core-site.xml
sed -i 's_</property>_ _' core-site.xml
sed -i 's_</value>_ _' core-site.xml
sed -i 's_</name>_ _' core-site.xml
sed -i 's_fs.default.dir_ _' core-site.xml
sed -i 's_'$HADOOP_HOME'/hadoopdfs_ _' core-site.xml
sed -i 's_fs.default.name_ _' core-site.xml
sed -i 's_hdfs://'$host1':'$port_0'/_ _' core-site.xml
sed -i 's_<property>_ _' hdfs-site.xml
sed -i 's_<name>_ _' hdfs-site.xml
sed -i 's_<value>_ _' hdfs-site.xml
sed -i 's_</property>_ _' hdfs-site.xml
sed -i 's_</value>_ _' hdfs-site.xml
sed -i 's_</name>_ _' hdfs-site.xml
sed -i 's_dfs.name.dir_ _' hdfs-site.xml
sed -i 's_dfs.data.dir_ _' hdfs-site.xml
sed -i 's_'$HADOOP_HOME'/hadoopdfs/name_ _' hdfs-site.xml
sed -i 's_'$HADOOP_HOME'/hadoopdfs/data_ _' hdfs-site.xml
sed -i 's_<property>_ _' mapred-site.xml
sed -i 's_<name>_ _' mapred-site.xml
sed -i 's_<value>_ _' mapred-site.xml
sed -i 's_</property>_ _' mapred-site.xml
sed -i 's_</value>_ _' mapred-site.xml
sed -i 's_</name>_ _' mapred-site.xml
sed -i 's_mapred.job.tracker_ _' mapred-site.xml
sed -i 's_hdfs://'$host1':'$port_1'/_ _' mapred-site.xml
sed -i 's|export JAVA_HOME=$JAVA_HOME|# export JAVA_HOME=/usr/lib/j2sdk1.5-sun|' hadoop-env.sh
sed -i 's_'$host1'_localhost_' slaves

sed -i 's_'$host1'_localhost_' masters
echo "Press any key to go back..."
read
cd $old_roll_path

