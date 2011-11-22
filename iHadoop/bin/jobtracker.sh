echo "configuring ssh requirements"
echo "Creating a passphraseless ssh key with type rsa"
ssh-keygen -t rsa -P ""
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod 644 $HOME/.ssh/authorized_keys



echo "Please ehter the version of hadoop"
read version
export HADOOP_HOME=$HOME/hadoop-"$version"
cd $HADOOP_HOME
echo -e "\033[31m configuring ssh for master machine \033[0m"
master="$(awk '{ print $0 }' conf/masters)"
ssh-copy-id -i $HOME/.ssh/id_rsa.pub $master
exec 8>&0
exec<conf/slaves
   while read line
   do
                echo -e "\033[31m configuring ssh for $line machine \033[0m"
		ssh-copy-id -i $HOME/.ssh/id_rsa.pub $line
   done
exec 0<&8 8<&-

echo "starting mapred daemons......"
bin/start-mapred.sh
