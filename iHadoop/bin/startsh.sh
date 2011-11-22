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


main_menu()
{

echo "................................................................. "
echo ".                        Main Menu                              .   "
echo "................................................................. "

echo ".[1] Install Hadoop                                             .  "
echo ".[2] Install Pig Latin                                          .   "
echo ".[3] Install Hive                                               .  "
echo ".[4] Help                                                       .  "
echo ".[5] Exit                                                       . "
echo "................................................................."


echo -n "Enter your choice"
read choice
echo " "
echo " "
#individual shells for hadoop,pig and hive
case $choice in
1) bin/hadoop_ins_v1.sh;; 
2) bin/pig-ins.sh;;
3) bin/hive-ins.sh  ;;
4) bin/help_main.sh;;
5) exit 0;;
*)echo "Wrong selection";echo "press any key to proceed...";read; main_menu;;

esac


}


#logic for welcoming
clear
temph=`date | cut -c12-13`
if [ $temph -lt 12 ]
then
    mess="Good Morning $LOGNAME"
fi
if [ $temph -gt 12 -a $temph -le 16 ]
then
    mess="Good Afternoon $LOGNAME"
fi
if [ $temph -gt 16 -a $temph -le 18 ]
then
    mess="Good Evening $LOGNAME"
fi
if [ $temph -gt 18 -a $temph -le 23 ]
then
   mess="You are working really later Mr.$LOGNAME"
fi


echo -e "\033[31m                   $mess"

echo "   "
echo -e "\033[0m*****************************************************************"
echo -e "\033[32m                       Welcome to iHadoop " 
echo -e "\033[0m*****************************************************************"
echo " "
echo " "
echo -e "\033[0m"
echo "  "
echo "  "

main_menu

