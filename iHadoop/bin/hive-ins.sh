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
echo "*       *     *   *         *  * * * * *           "
echo "*       *     *   *         *  *              " 
echo "*       *     *    *       *   *                 "
echo "* * * * *     *     *     *    * * * * *             "
echo "*       *     *      *   *     *                   " 
echo "*       *     *       * *      *                     "
echo "*       *     *        *       * * * * *             "

echo " "
echo " "


main_hive_menu()
{
echo "1.Install hive"
echo "2.Check the available hive version"
echo "3.Back"
echo "4.Exit"
echo " "
echo " "
echo "Enter the option"
read hive_check
#function calls for hive installation,checking the hive version and returning back
case $hive_check in
1)hive-inst;;
2)hive-check;;
3)bin/startsh.sh;;
4)exit 0;;
*)echo "Wrong selection";echo "press any key to proceed...";read;main_hive_menu;; 
esac

}


hive-inst()
{
echo "Enter the version you want to install"
read version
#concating the version ver the term "hive" and locating
find hive-"$version".tar.gz
export ex="`find hadoop-"$version".tar.gz | wc -l`"
#checking the existance of the requested hive version
if test $ex -eq 0
then
echo "The version does not exist in the local system......"
echo " "
echo " "
echo "(Hint: You can check the available version with the second option)"
echo "Press any key to continue..."
read y
main_hive_menu
else
export new_path=`pwd`
cd ..
echo "Installing hive...."
tar -xvzf hive-"$version".tar.gz
echo " "
echo " "
echo " "
cd $new_path
echo "Press any key to continue..."
read y
#setting the environment variables
export HIVE_HOME=$HOME/hive-"$version"/
export HIVE_CLASSPATH=$HADOOP_HOME/conf
fi
}


hive-check()
{
#going to the home directory and back
export older_path="`pwd`"
cd $HOME 
find hive*.tar.gz
export hiver="`find hadoop-*.tar.gz | wc -l`"`
cd $older_path
if test $hiver -eq 0
then
echo "No installation files present"
echo " "
echo "Enter any key to continue..."
read
main_hive_menu
else 
echo "Press any key to continue..."
read
main_hive_menu
fi
}

main_hive_menu
