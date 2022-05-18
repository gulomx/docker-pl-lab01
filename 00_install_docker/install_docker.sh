#!/bin/bash
# install docker on Ubuntu
echo "Run as sudo/root"
sudo apt install docker-compose git docker.io -y
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh get-docker.sh
systemctl start docker
sleep 5
sudo docker swarm init
sudo usermod -aG docker $SUDO_USER