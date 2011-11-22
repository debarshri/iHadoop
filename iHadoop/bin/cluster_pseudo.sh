#
#Author: Debarshi.basak@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#



pseudo_exit_menu()
{
echo "[1] Reset the configurations"
echo "[2] Go back"
echo "[3] Exit"
read pseudo_exit_option
case $pseudo_exit_option in
1)bin/cluster_pseudo.sh;;
2)bin/hadoop-ins.sh;;
3)exit 0;;
*) echo "Invalid option";read;pseudo_exit_menu;;
esac
}


echo "PSEUDO-DISTRIBUTED MODE"

rolling_back()
{


bin/hadoop_deconf.sh
pseudo_exit_menu
}




start_pseudo()
{
echo "Do you want to start the pseudo mode?(y/n)"
read cond
case $cond in
y)bin/start_cluster.sh;; 
n)rolling_back;;
*)echo "Wrong option";echo "Press any key to continue...";read;start_pseudo;;
esac      
}


clear
exp="`pwd`"
if  [ $HADOOP_HOME ]
then
echo " " 
echo " "
echo "Your HADOOP_HOME is $HADOOP_HOME"
echo " "
echo " "
cd $HADOOP_HOME/conf
else 
echo "Your HADOOP_HOME env variable is not set"
echo " "
echo "Enter the version of hadoop"
read version
export HADOOP_HOME=$HOME/hadoop-$version
cd $HADOOP_HOME
mkdir hadoopdfs
cd $HADOOP_HOME/conf
fi

echo "Enter the default port number for hdfs" 
read port
export port_0="$port"
echo "Enter the port number for mapreduce"
read port1
export port_1="$port1"
echo "Enter the host name (if null then assumes localhost)"
read host
export host1="$host"
echo "Setting configuartions"
if  [ $host1 ]
then
echo "host name is $host"
else
export host1="localhost"
echo $host1
fi 
echo $JAVA_HOME
sed -i 's|# export JAVA_HOME=/usr/lib/j2sdk1.5-sun|export JAVA_HOME='$JAVA_HOME'|' hadoop-env.sh

sed -i 's_<configuration>_<configuration>\n<property>\n<name>fs.default.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs</value>\n</property>\n<property>\n<name>fs.default.name</name>\n<value>hdfs://'$host1':'$port_0'/</value>\n</property>\n_' core-site.xml

sed -i 's_<configuration>_<configuration>\n<property>\n<name>dfs.name.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/name</value>\n</property>\n<property>\n<name>dfs.data.dir</name>\n<value>'$HADOOP_HOME'/hadoopdfs/data</value>\n</property>_' hdfs-site.xml

sed -i 's_<configuration>_<configuration>\n<property>\n<name>mapred.job.tracker</name>\n<value>'$host':'$port_1'</value>\n</property>\n_' mapred-site.xml

sed -i 's_localhost_'$host1'_' slaves

sed -i 's_localhost_'$host1'_' masters

export CLASSPATH="$CLASSPATH":"$HADOOP_HOME"
cd $exp
echo "Press any key to continue..." 
read

start_pseudo

