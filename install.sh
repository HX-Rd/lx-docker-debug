#!/usr/bin/env bash

apt-get update
apt-get install git -y
apt-get install vim -y
apt-get install powershell -y
apt-get install unzip -y

mkdir /root/lx-docker-debug
git clone https://github.com/HX-Rd/lx-docker-debug.git /root/lx-docker-debug
find /root/lx-docker-debug/ -type f -iname "*.sh" -exec chmod +x {} \;
/root/lx-docker-debug/setup.sh

curl -s https://ohmyposh.dev/install.sh | bash -s

rm -rf /root/lx-docker-debug
