#!/bin/sh

PN=$1
DOMAIN=$2

#sudo touch /etc/nginx/conf.d/$PN.conf
sudo cat >/etc/nginx/conf.d/$PN.txt <<EOL
server {
    listen 80;
    server_name $DOMAIN;
    root /srv/$PN;

add_header X-Frame-Options "SAMEORIGIN";
add_header X-XSS-Protection "1; mode=block";
add_header X-Content-Type-Options "nosniff";

index index.php;

charset utf-8;

location / {
    try_files \$uri \$uri/ /index.php?\$query_string;
}

location ~ \.php$ {
                try_files \$uri /index.php =404;
                fastcgi_pass unix:/var/run/php-fpm/www.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                include fastcgi_params;
        }

location = /favicon.ico { access_log off; log_not_found off; }
location = /robots.txt  { access_log off; log_not_found off; }

error_page 404 /index.php;

location ~ /\.(?!well-known).* {
    deny all;
}
}

EOL
cat /etc/nginx/conf.d/$PN.txt