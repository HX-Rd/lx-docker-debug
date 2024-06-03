#!/usr/bin/env bash
distro=""
centos=$(cat /etc/*-release | grep "centos")
ubuntu=$(cat /etc/*-release | grep "ubuntu")
if [ ! -z "$centos" ]
then
    distro="centos"
fi
if [ ! -z "$ubuntu" ]
then
    distro="ubuntu"
fi

if [ $distro == "centos" ]
then
    sudo yum install git -y
    sudo yum install vim -y
fi
if [ $distro == "ubuntu" ]
then
    sudo apt-get update
    sudo apt-get install git -y
    sudo apt-get install vim -y
    sudo apt-get install powershell -y
fi


mkdir /root/lx-docker-debug
git clone https://github.com/HX-Rd/lx-docker-debug.git /root/lx-docker-debug
find /root/lx-docker-debug/ -type f -iname "*.sh" -exec chmod +x {} \;
/root/lx-docker-debug/setup.sh

curl -s https://ohmyposh.dev/install.sh | bash -s

rm -rf /root/lx-docker-debug
