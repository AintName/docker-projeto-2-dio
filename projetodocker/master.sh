#!/bin/bash
sudo docker swarm init --advertise-addr=10.10.10.100
sudo docker swarm join-token worker | grep docker > /vagrant/worker.sh
sudo apt-get install nfs-server -y
sudo sed -i '$s/$/\n/' /etc/exports
sudo sed -i '$i  /var/lib/docker/volumes/projeto/_data *(rw,sync,subtree_check)' /etc/exports
sudo exportfs -ar
sudo docker volume create projeto

sudo mkdir /scripts
cd /scripts
sudo cp /vagrant/docker-compose.yml /scripts/
sudo cp /vagrant/init.sql /scripts/
sudo docker-compose up -d
sudo cp /vagrant/index.php /var/lib/docker/volumes/projeto/_data
sudo docker service create --name projeto-docker --replicas 3 -dt -p 80:80 --mount type=volume,src=projeto,dst=/app/ webdevops/php-apache:alpine-php7
#sudo docker service update --force projeto-docker
