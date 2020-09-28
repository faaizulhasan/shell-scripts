#!/bin/sh

#PHP-FPM
sudo dnf install php-fpm php-mysqlnd -y
sudo dnf install php-cli php-json php-opcache php-xml php-gd php-curl php-mbstring php-pecl-zip -y
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
printf "====================\n-Chnage ownership\n-Path /etc/php-fpm.d/www.conf\n-Restart Nginx\n====================\n"