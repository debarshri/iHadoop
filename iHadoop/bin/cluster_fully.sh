#
#Author: vanshish.mehra@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#


fully_distributed()
{
echo ".................................................."
echo ".    Fully Distributed Cluster Requirements      ."
echo ".................................................."

echo "Please select your option"
echo "[1]Setting Fully distributed mode Prequisites"
echo "[2]Installing Hadoop on all the nodes"
echo "[3]Configuring Hadoop on all the nodes"
echo "[4]Starting Fully distributed Hadoop cluster"
echo "[5]Go back"
echo "[6]Exit"
echo ".................................................."

read fully_distributed_option
case $fully_distributed_option in
1)bin/fully_distributed_prerequisites.sh;;
2)bin/fully_distributed_installation.sh;;
3)bin/fully_distributed_configuration.sh;;
4)start_fully;;
5)bin/hadoop_ins_v1.sh;;
6)exit 0;;
*)echo "Wrong option";echo "Press any key to continue...";read;fully_distributed;;
esac
}





echo "FULLY-DISTRIBUTED MODE"





start_fully()
{
echo "Do you want to start the full mode?(y/n)"
read cond
case $cond in
y)bin/start_cluster_full.sh;; 
n)fully_distributed;;
*)echo "Wrong option";echo "Press any key to continue...";read;start_pseudo;;
esac      
}


clear
echo " "
echo -e "\033[31m /*  If you are installing Hadoop Fully Distributed Cluster for the first time,Please execute all steps in the given sequence  */"
echo -e -n "\033[0m "
echo " "
echo " "

fully_distributed
