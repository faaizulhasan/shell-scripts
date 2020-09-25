#!/bin/sh

curl -L -o nodesource_setup.sh https://rpm.nodesource.com/setup_12.x
nano nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo yum clean all
sudo yum makecache
sudo yum install -y gcc-c++ make
sudo yum install -y nodejs
node -v

#installing PM2
sudo npm install pm2@latest -g
sudo pm2 startup systemd
pm2 save

#MARIADB
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb



#INSTALLING NGINX
sudo yum install epel-release -y
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
printf "====================\n-Disable Selinux\n-Path to disable selinux /etc/selinux/config\n-Insert config.d folder in nginx http block\n-Restart Server\n-mysql_secure_installation\n====================\n"





