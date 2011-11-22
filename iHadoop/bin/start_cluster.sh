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
y)bin/hadoop namenode -format;echo "Starting pseudo mode..";echo " ";echo  " ";bin/start-all.sh;jps;;
n)echo "Starting pseudo mode..."; bin/start-all.sh;jps;;
*)echo "Invalid option";echo "Press any key to proceed...";read;starters;;
esac
}
clear
exp="`pwd`"
echo " "
echo " "
echo "Your hadoop home is $HADOOP_HOME"
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
starters

