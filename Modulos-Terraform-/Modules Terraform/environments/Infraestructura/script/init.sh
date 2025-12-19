#!/bin/bash

sudo update -y
sudo upgrade -y

sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

sudo dnf install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

#sudo reboot
