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





ssh_menu()
{
echo "......................................................................"
echo ".                       Enter Server Details                         ."
echo "......................................................................"
  
echo "[1] Add Master Machine details"
echo "[2] Add CheckPoint Machine Details  (If different than Master Machine)"
echo "[3] Add Job Tracker Machine deatils (If different than Master Machine)"
echo "[4] Add Slave Machines to cluster"
echo "[5] Go Back"
echo "[6] Exit"
echo "......................................................................"

echo "Enter the option"
read option
case $option in
1)add_master;;
2)add_checkpoint;;
3)add_jobtracker;;
4)add_slaves;;
5)bin/cluster_fully.sh;;
6)exit 0;;
*)echo "Wrong selection";echo "Press any key to continue...";read;ssh_menu;;
esac
}


add_master()
{
echo "Resetting all the configuration files"
echo " "
echo " "
cat /dev/null>conf/masters
cat /dev/null>conf/slaves
cat /dev/null>conf/jobtracker
cat /dev/null>conf/checkpoint
cat /dev/null>conf/sshlist
echo -e "\033[31m Please Note:There should be same username for all tha machines in the hadoop cluster \033[0m"
echo "Enter the username "
read master_username
echo "Enter the ip address of master machine"
read master_ip
echo "Enter the hostname of the machine"
read master_hostname
while [ "$master_hostname" == "localhost" ]
do
echo "Enter the hostname other than localhost"
read master_hostname
done
echo "master" $master_username $master_ip>>conf/sshlist
echo $master_ip "master" $master_hostname>conf/masters
ssh_menu
}

add_checkpoint()
{
cat /dev/null>conf/checkpoint
echo "Enter the username of checkpoint machine"
read checkpoint_username
echo "Enter the ip address of checkpoint machine"
read checkpoint_ip
echo "Enter the hostname of the machine"
read checkpoint_hostname
while [ "$checkpoint_hostname" == "localhost" ]
do
echo "Enter the hostname other than localhost"
read checkpoint_hostname
done
ssh-copy-id -i $HOME/.ssh/id_rsa.pub $checkpoint_username@$checkpoint_ip
nc=`echo $?`
if [ $nc -eq 0 ]; then
temp_ipc=$(awk '{ print $1 }' conf/masters)
temp_hostnamec="$(awk '{ print $3 }' conf/masters)"
temp_servernamec="$(awk '{ print $2 }' conf/masters)"
	if [ "$checkpoint_ip" == "$temp_ipc" ]; then 
	echo $temp_ipc "$temp_servernamec" $temp_hostnamec>conf/checkpoint
	else
	echo "checkpoint" $checkpoint_username $checkpoint_ip>>conf/sshlist
	echo $checkpoint_ip "checkpoint" $checkpoint_hostname>conf/checkpoint
	fi
fi
ssh_menu
}

add_jobtracker()
{
cat /dev/null>conf/jobtracker
echo "Enter the username of job tracker machine"
read jobtracker_username
echo "Enter the ip address of job tracker machine"
read jobtracker_ip
echo "Enter the hostname of the machine"
read jobtracker_hostname
while [ "$jobtracker_hostname" == "localhost" ]
do
echo "Enter the hostname other than localhost"
read jobtracker_hostname
done

ssh-copy-id -i $HOME/.ssh/id_rsa.pub $jobtracker_username@$jobtracker_ip
nj=`echo $?`
if [ $nj -eq 0 ]; then
echo "check"
temp_ipj[1]="$(awk '{ print $1 }' conf/masters)"
temp_ipj[2]="$(awk '{ print $1 }' conf/checkpoint)"
temp_hostnamej[1]="$(awk '{ print $3 }' conf/masters)"
temp_hostnamej[2]="$(awk '{ print $3 }' conf/checkpoint)"
temp_servernamej[1]="$(awk '{ print $2 }' conf/masters)"
temp_servernamej[2]="$(awk '{ print $2 }' conf/checkpoint)"
j=0
k=0
while [ $k -lt 1 ]
do
for j in 1 2
do 
	if [ "$jobtracker_ip" == "${temp_ipj[j]}" ]; then
	echo "${temp_ipj[j]} ${temp_servernamej[j]} ${temp_hostnamej[j]}">>conf/jobtracker;break 2
	fi
done
	echo "jobtracker" $jobtracker_username $jobtracker_ip>>conf/sshlist
	echo $jobtracker_ip "jobtracker" $jobtracker_hostname>>conf/jobtracker;break
done
fi
ssh_menu
}


add_slaves()
{
temp=`expr $temp + 1`
echo "Enter the username of the remote machine "
read slave_username
echo "Enter the ip address"
read slave_ip
echo "Enter the hostname of the machine"
read slave_hostname
while [ "$slave_hostname" == "localhost" ]
do
echo "Enter the hostname other than localhost"
read slave_hostname
done

sl=$slave_ip
ssh-copy-id -i $HOME/.ssh/id_rsa.pub $slave_username@$slave_ip
ns=`echo $?`
rep=`sed -n 's/'$sl'/&/p' conf/slaves`
if [ $ns -eq 0 ]; then

temp_iparr[1]="$(awk '{ print $1 }' conf/masters)"
temp_iparr[2]="$(awk '{ print $1 }' conf/checkpoint)"
temp_iparr[3]="$(awk '{ print $1 }' conf/jobtracker)"
temp_servername[1]="$(awk '{ print $2 }' conf/masters)"
temp_servername[2]="$(awk '{ print $2 }' conf/checkpoint)"
temp_servername[3]="$(awk '{ print $2 }' conf/jobtracker)"
temp_hostname[1]="$(awk '{ print $3 }' conf/masters)"
temp_hostname[2]="$(awk '{ print $3 }' conf/checkpoint)"
temp_hostname[3]="$(awk '{ print $3 }' conf/jobtracker)"
i=0
l=0
while [ $l -lt 1 ]
do
for i in 1 2 3
do
echo "$slave_ip"
	if [ "$slave_ip" == "${temp_iparr[i]}" ]; then	
		if [ "$rep" != "" ]; then
        	echo "The slave is already present.Please enter another slave"; break 2
        	else
        	echo "${temp_iparr[i]} ${temp_servername[i]} ${temp_hostname[i]}">>conf/slaves; break 2
		fi
	fi
done	

	if [ "$rep" != "" ]
	then
	echo "The slave is already present.Please enter another slave"; break
	else
	echo "slave" $slave_username $slave_ip>>conf/sshlist
	echo $slave_ip "slave$temp" $slave_hostname>>conf/slaves ;break
	fi 
done
fi
ssh_menu
}



clear
echo " "
echo -e "\033[31m /* Please make sure that JAVA_HOME variable is set in $HOME/.bash_profile on all the machines in the cluster */"
echo -e -n "\033[0m "
echo " "
echo " "
echo "Creating a passphraseless ssh key with type rsa"
ssh-keygen -t rsa -P ""
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod 644 $HOME/.ssh/authorized_keys


clear
content_master="$(awk '{ print $0 }' conf/masters)"
content_sshlist="$(awk '{ print $0 }' conf/sshlist)"
content_slaves="$(awk '{ print $0 }' conf/slaves)"

if [ "$content_master" == "" -a "$content_sshlist" == "" -a "$content_slaves" == "" ];then
echo -e "\033[31m No Server Details found in the configuartion files,Please enter your server details"
echo -e -n "\033[0m "
else
echo -e "\033[31m Your Previous Configuration is as shown below"
echo -e -n "\033[0m "
echo " "
echo "......................................................................................................................"
echo "master:"
awk '{ print $0 }' conf/masters
echo " "
echo "......................................................................................................................"
echo "checkpoint:"
content_checkpoint="$(awk '{ print $0 }' conf/checkpoint)"
if [ "$content_checkpoint" == "" ];then
awk '{ print $0 }' conf/masters
else
awk '{ print $0 }' conf/checkpoint
fi
echo " "
echo "......................................................................................................................"
echo "jobtracker:"
content_jobtracker="$(awk '{ print $0 }' conf/jobtracker)"
if [ "$content_jobtracker" == "" ];then
awk '{ print $0 }' conf/masters
else
awk '{ print $0 }' conf/jobtracker
fi
echo " "
echo "......................................................................................................................"
echo "slaves:"
awk '{ print $0 }' conf/slaves
echo "......................................................................................................................"
echo " "
echo " "
echo -e "\033[31m If you want to change your configuration plz enter your choice"
echo -e -n "\033[0m "
fi

export temp
ssh_menu

