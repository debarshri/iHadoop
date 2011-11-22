#
#Author: Debarshi.basak@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#
starters()
{
echo "CLUSTER INITIATOR"
echo "Are you starting the cluster for the first time?(y/n)"
read option
case $option in
y)bin/hadoop namenode -format;echo "Starting full mode..";echo " ";echo  " ";bin/start-dfs.sh;;
n)echo "Starting full mode...";bin/start-dfs.sh;;
*)echo "Invalid option";echo "Press any key to proceed...";read;starters;;
esac
}




clear
exp="`pwd`"
echo " "
echo " "
#export JAVA_HOME=/usr/java/jdk1.6.0_25
echo " " 
echo " "
#echo "Your hadoop home is $HADOOP_HOME"
echo " "
if  [ $HADOOP_HOME ]
then
cd $HADOOP_HOME
else
echo "Enter the version of hadoop"
read version
export HADOOP_HOME=$HOME/hadoop-"$version"
cd $HADOOP_HOME
fi
echo -e "\033[31m Note:"
echo -e "1)Please set export JAVA_HOME in $HADOOP_HOME/conf/hadoop-env.sh in all the machines"
echo -e "2)Please copy the contents of $exp/conf/masters in /etc/hosts file by logging into root in all the machines."
echo -e "3)Please copy the contents of $exp/conf/checkpoint(if not empty) in /etc/hosts file by logging into root in all the machines."
echo -e "4)Please copy the contents of $exp/conf/jobtracker(if not empty) in /etc/hosts file by logging into root in all the machines."
echo -e "5)Please copy the contents of $exp/conf/slaves in /etc/hosts file by logging into root in all the machines."
echo -e -n "\033[0m "
echo "Please press enter once done"
read
starters

