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

echo ":::    ::    ::::  ::: :     :::::    :::::   ::::       "
echo ":::    ::   :  ::  ::   ::  ::   ::  ::   ::  ::  ::     " 
echo ":::::::::  ::::::  ::   ::  ::   ::  ::   ::  :::::      "
echo ":::    ::  ::  ::  ::   ::  ::   ::  ::   ::  ::         "
echo ":::    ::  ::  ::  :::::     :::::    :::::   ::        "
echo " "
echo " "


main_hadoop()
{
echo "[1]Install hadoop"
echo "[2]Check the available version"
echo "[3]Cluster modes"
echo "[4]Back"
echo " "
echo " "
echo "Enter the option"
read opt
case $opt in 
1)inst-hadoop;;
2)check-hadoop;;
3)cluster-hadoop;;
4)bin/startsh.sh;;
*)echo "Wrong selection...";echo "Press any key...";read;main_hadoop;;
esac
}

inst-hadoop()
{
export older_path="`pwd`"
cd $HOME
echo "Enter the version you want to install"
read version
export hadex="`find hadoop-"$version".tar.gz|wc -l`"
if test $hadex -eq 0
then
echo "The version does not exist in the local system......"
echo " "
echo " "

echo "(Hint: You can check the available version with the second option)"
echo "Press any key to continue..."
read
main_hadoop
else
cd $HOME
echo "Installing hadoop..."
tar -xvzf hadoop-"$version".tar.gz
echo " "
echo " "
echo " "
echo "Press any key to continue..."
read
export HADOOP_HOME=$HOME/hadoop-"$version"
cd $older_path
main_hadoop

fi
}

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

check-hadoop()
{
export older_path_pig="`pwd`"
cd $HOME
echo " "
echo " "
export hadooper="`find hadoop-*.tar.gz|wc -l`"
if test $hadooper -eq 0
then
echo "No installation files present"
echo " "
echo "Enter any key to continue..."
read
cd $older_path_pig
main_hadoop
else
find hadoop-*.tar.gz
echo "Enter a key to continue.."
echo " " 
read
cd $older_path_pig
main_hadoop
fi
}

help_cluster()
{
echo " "
echo " Help"
echo "Press any key to return..."
read
cluster-hadoop
}

main_hadoop
