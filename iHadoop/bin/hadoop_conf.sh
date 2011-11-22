#
#Author: Debarshi.basak@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#

echo "Enter the default port number for hdfs" 
read port
echo "Enter the port number for mapreduce"
read port1 
echo "Setting configuartions"
#sed -i "s/.*<configuration>.*/&\n<property>\n<name>fs.default.name</name>\n<value>$HOME/hadoopdfs<//value>\n<//property>/g" core-site.xml
             
sed -i 's_<configuration>_<configuration>\n<property>\n<name>fs.default.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs</value>\n</property>\n<property>\n<name>fs.default.name</name>\n<value>localhost:'$port'</value>\n</property>\n_' core-site.xml

sed -i 's_<configuration>_<configuration>\n<property>\n<name>dfs.name.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/name</value>\n</property>\n<property>\n<name>dfs.data.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/data</value>\n</property>_' hdfs-site.xml
    
sed -i 's_<configuration>_<configuration>\n<property>\n<name>mapred.job.tracker</name>\n<value>localhost:'$port1'</value>\n</property>\n_' mapred-site.xml

export CLASSPATH="$CLASSPATH":"$HADOOP_HOME"
cd $exp
echo "Press any key to continue..." 
read
