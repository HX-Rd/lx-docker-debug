#!/usr/bin/env bash
echo "Setting up environment"
echo "Checking distro version"
distro=""
centos=$(cat /etc/*-release | grep "centos")
if [ ! -z "$centos" ]
then
    distro="centos"
fi
files=$(\ls -a $HOME/lx-pref)
backup_folder=$HOME/env-backup
mkdir root/env-backup
blacklist=(
    '.'
    '..'
    '.git'
    'setup.sh'
    'install.sh'
    'scripts'
)
for file in $files
do
    if [ -f $HOME/$file ] || [ -d $HOME/$file ]
    then
        if [[ ! " ${blacklist[@]} " =~ " ${file} " ]]
        then
            mv /root/$file $backup_folder/$file
        fi
    fi
    if [[ ! " ${blacklist[@]} " =~ " ${file} " ]]
    then
        mv /root/lx-docker-debug/$file /root/$file
    fi

done
echo "Done setting up environment"
