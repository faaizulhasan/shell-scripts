#!/bin/sh

sudo apt update
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
sudo apt install nodejs -y
sudo apt install npm -y
node -v

#installing PM2
sudo npm install pm2 -g
sudo pm2 startup systemd
pm2 save

#INSTALLING NGINX

sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl status nginx
sudo systemctl enable nginx 


sudo yum install epel-release -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
