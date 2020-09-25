#!/bin/sh

PN=$1
DOMAIN=$2
PORT=$3

#VALIDATION
if ![ $PN ]
then echo "[1]Project Name is required"; exit 0
else if ![ $DOMAIN ]
then echo "[2]Domain Name is required"; exit 0
else if ![ $PORT ]
then echo "[3]PORT is required"; exit 0
fi

#sudo touch /etc/nginx/conf.d/$PN.conf
sudo cat  <<EOF > /etc/nginx/conf.d/$PN.conf
server {
        listen       80;
        listen       [::]:80;
        server_name  $DOMAIN;
        root         /srv/;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

      location / {
        proxy_pass http://localhost:$PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
       }

EOF