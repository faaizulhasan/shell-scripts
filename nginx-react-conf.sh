#!/bin/sh

PN=$1
DOMAIN=$2
PORT=$3

sudo cat >/etc/nginx/conf.d/$PN.txt <<EOL
server {
    listen 80;
    server_name $DOMAIN;
    root /srv/$PN/build;

add_header X-Frame-Options "SAMEORIGIN";
add_header X-XSS-Protection "1; mode=block";
add_header X-Content-Type-Options "nosniff";

index index.html;

charset utf-8;

location / {
  if (!-e $request_filename){
    rewrite ^(.*)$ /index.html break;
  }
}

location = /favicon.ico { access_log off; log_not_found off; }
location = /robots.txt  { access_log off; log_not_found off; }

#error_page 404 /index.php;

location ~ /\.(?!well-known).* {
    deny all;
}
}
EOL
cat /etc/nginx/conf.d/$PN.txt
