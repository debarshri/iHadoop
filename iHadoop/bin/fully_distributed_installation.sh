#!/bin/sh
#
#Author: vanshish.mehra@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#



main_hadoop()
{
echo "..............................................................."
echo ".                    Installation Menu                        ."
echo "..............................................................."


echo "1)Look for available version of hadoop tar file in the machine"
echo "2)Install Hadoop"
echo "3)Back"
echo "4)Exit"
echo "..............................................................."

echo "Please enter your choice"
read main_hadoop_opt 
case $main_hadoop_opt in
1)version_hadoop;;
2)install_hadoop;;
3)bin/cluster_fully.sh;;
4)exit 0;;
*)echo "Wrong selection";echo "Press any key";read;main_hadoop;;
esac
}





install_hadoop()
{

echo "Installing hadoop-"$version" on all the machines..."
exec 6>&0
exec<conf/sshlist
   while read line
   do
		machine=$(echo $line | awk '{ print $1 }')
		username=$(echo $line | awk '{ print $2 }')
		ip=$(echo $line | awk '{ print $3 }')
		case $machine in
		master)echo -e "\033[31m installing hadoop on master machine \033[0m";cd $HOME;tar -xvzf hadoop-"$version".tar.gz;cd $older_path;;
		checkpoint)echo -e "\033[31m installing hadoop on checkpoint machine \033[0m";scp -r $HOME/hadoop-"$version" $username@$ip:/home/$username;;
		jobtracker)echo -e "\033[31m installing hadoop on jobtracker machine \033[0m";scp -r $HOME/hadoop-"$version" $username@$ip:/home/$username;;
		slave)echo -e "\033[31m installing hadoop on slave machine \033[0m";scp -r $HOME/hadoop-"$version" $username@$ip:/home/$username;;
		esac
	    echo $line;
   done
echo "Installation done"
echo ""
echo ""
echo ""
exec 0<&6 6<&-

bin/cluster_fully.sh
}

version_hadoop()
{
export older_path="`pwd`"
cd $HOME
ls -l hadoop*.tar.gz
echo " "
echo " "
echo "Enter the version you want to install"
read version
export hadex="`find hadoop-"$version".tar.gz|wc -l`"
#while [ cond -eq 0]
#do
if test $hadex -eq 0
then
echo "The version does not exist in the local system......"
echo " "
echo " "
echo "Press any key to continue..."
read
main_hadoop
else
cd $HOME
echo "Please select option 2 to continue with installation"
export HADOOP_HOME=$HOME/hadoop-"$version"
cd $older_path
main_hadoop

fi
}
clear
main_hadoop
