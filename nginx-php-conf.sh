#!/bin/sh

PN=$1
DOMAIN=$2

#VALIDATION
if ![ $PN ]
then echo "[1]Project Name is required"; exit 0
else if ![ $DOMAIN ]
then echo "[2]Domain Name is required"; exit 0
fi

#sudo touch /etc/nginx/conf.d/$PN.conf
sudo cat  <<EOF > /etc/nginx/conf.d/$PN.conf
#THIS IS AUTOMATED GENERATED FILE DO NOT EDIT!!!!!
server {
    listen 80;
    server_name $DOMAIN;
    root        /srv/$PN;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.php;
    include /etc/nginx/default.d/*.conf;
    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    error_page 404 /index.php;


    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

