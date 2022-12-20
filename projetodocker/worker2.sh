#!/bin/bash
sudo apt-get install nfs-common -y
sudo docker volume create projeto
sudo showmount -e 10.10.10.100
sudo mount 10.10.10.100:/var/lib/docker/volumes/projeto/_data /var/lib/docker/volumes/projeto/_data