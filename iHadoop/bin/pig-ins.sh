#
#Author: Debarshi.basak@tcs.com, CoE Hadoop,TCS
#
#© TATA consultancy Services Ltd, 2011
#
#This file is licensed under the Apache License, Version 2.0 (the "License"); You may obtain a copy of the License at  #http://www.apache.org/licenses/LICENSE-2.0. You may not use this file except in compliance with the License. See the #License for the specific language governing permissions and limitations under the License
#
#THIS SOFTWARE AND ALL OF THE INFORMATION IT CONTAINS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, WHETHER EXPRESS #OR IMPLIED. ALL IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A #PARTICULAR PURPOSE, AND NONINFRINGEMENT, ARE HEREBY EXPRESSLY DISCLAIMED
#
clear
echo "|- _          ____  "
echo "|   \   |    /      "
echo "|   |   |   |    __  "
echo "|_ /    |   |      \  "
echo "|       |    \     /  "
echo "|             \_ _/  "
echo " "
echo " "
echo " "
echo " "
main_pig()
{
echo "[1]Install pig"
echo "[2]Check the versions available in the file system"
echo "[3]Back"
echo "[4]Exit"
echo "Enter choice.."
read pig_choice 
case $pig_choice in
1)inst_pig;;
2)check_pig;;
3)bin/startsh.sh;;
4)exit 0;;
*)echo "Wrong selection";echo "Press any key to continue...";read;main_pig;;
esac
}
check_pig()
{
export older_path_pig="`pwd`"
cd $HOME
export piggy="`find hadoop-*.tar.gz | wc -l`"
if test $piggy -eq 0
then
echo "No installation files present"
echo " "
echo "Enter any key to continue..."
read
cd $older_path_pig
main_pig
else
find pig-*.tar.gz
echo "Enter a key to continue.."
echo " " 
read
cd $older_path_pig
main_pig
fi

}
inst_pig()
{
echo "Enter the version you want to install"
read version

export ex="`find hadoop-"$version".tar.gz | wc -l`"

if test $ex -eq 0
then
echo "The version does not exist in the local system......"
echo " "
echo " "
echo "(Hint: You can check the available version with the second option)"
echo "Press any key to continue..."
read 
main_pig

else
echo "Installing pig..."
export new_pig_path=`pwd`
cd ..
tar -xvzf $HOME/pig-"$version".tar.gz
echo " "
echo " "
echo " "
cd $new_pig_path
echo "Press any key to continue..."
read 
export PIG_HOME=$HOME/hive-"$version"/
export PIG_CLASSPATH=$HADOOP_HOME/conf
fi
}
main_pig
