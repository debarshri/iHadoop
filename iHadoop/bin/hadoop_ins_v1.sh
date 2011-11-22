# Licensed to the Tata Consultancy Services,Component Engineering Group Centre of Excellence for 
# Hadoop (TCS CEG-CoE Hadoop) under one or more
# contributor license agreements. You may contact TCS CEG-CoE Hadoop
# for additional information regarding copyright ownership.
# The TCS licenses this file to You under the TCS License,
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at TCS.
#
# 
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

clear
echo -e "\033[5m"
echo -e "\033[31m"
echo ":::    ::    ::::  ::: :     :::::    :::::   ::::       "
echo ":::    ::   :  ::  ::   ::  ::   ::  ::   ::  ::  ::     " 
echo ":::::::::  ::::::  ::   ::  ::   ::  ::   ::  :::::      "
echo ":::    ::  ::  ::  ::   ::  ::   ::  ::   ::  ::         "
echo ":::    ::  ::  ::  :::::     :::::    :::::   ::        "
echo " "
echo " "
echo -e -n "\033[0m"



cluster-hadoop()
{
echo " "
echo " "
echo "Select the mode you want to configure"
echo "[1]Pseudo-Distributed mode"
echo "[2]Fully Distributed mode"
echo "[3]Help"
echo "[4]Back"
echo "[5]Exit"


echo "Enter the option"
read opt_cluster
case $opt_cluster in
1)bin/cluster_pseudo.sh;;
2)bin/cluster_fully.sh;;
3)help_cluster;;
4)bin/startsh.sh;;
5)exit 0;;
*)echo "Wrong selection";echo "Press any key to continue...";read;main_hadoop;;
esac
}


help_cluster()
{
echo " "
echo " Help"
echo "Press any key to return..."
read
cluster-hadoop
}

cluster-hadoop
