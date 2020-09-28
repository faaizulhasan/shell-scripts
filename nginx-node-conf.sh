#!/bin/sh

PN=$1
DOMAIN=$2
PORT=$3
HTTP_UPGRADE=$http_upgrade
HOST=$host
sudo cat >/etc/nginx/conf.d/$PN.conf <<EOL
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
        proxy_set_header Upgrade "$http_upgrade";
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host "$host";
        proxy_cache_bypass "$http_upgrade";
       }
}
EOL
cat /etc/nginx/conf.d/$PN.conf