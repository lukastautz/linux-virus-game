#!/bin/bash
# Copyright (C) 2022 Lukas Tautz
# DNS (my.ns on bind9) installer
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y nginx
sudo systemctl enable nginx
sudo chmod -R -v 777 /var
sudo chmod -R -v 777 /etc/nginx
sudo rm /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: my.ns/nginx';" >> /etc/nginx/sites-available/default
sudo echo "    more_clear_headers 'X-Powered-By';" >> /etc/nginx/sites-available/default
sudo echo "    root /var/www/my.ns;" >> /etc/nginx/sites-available/default
sudo echo "    index index.html index.htm index.php index.jpg index.jpeg index.gif index.json index.txt;" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g') my.ns my.nameserver www.my.ns www.my.nameserver;" >> /etc/nginx/sites-available/default
sudo echo "    client_max_body_size 1024M;" >> /etc/nginx/sites-available/default
sudo echo "    location / {" >> /etc/nginx/sites-available/default
sudo echo "        error_page 404 http://\$server_name;" >> /etc/nginx/sites-available/default
sudo echo "        try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 443;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:443;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: my.ns/nginx';" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g') my.ns my.nameserver www.my.ns www.my.nameserver;" >> /etc/nginx/sites-available/default
sudo echo "    return 302 http://\$server_name;" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
sudo rm /etc/nginx/nginx.conf
sudo echo 'user root;' >> /etc/nginx/nginx.conf
sudo echo 'worker_processes auto;' >> /etc/nginx/nginx.conf
sudo echo 'pid /run/nginx.pid;' >> /etc/nginx/nginx.conf
sudo echo 'include /etc/nginx/modules-enabled/*.conf;' >> /etc/nginx/nginx.conf
sudo echo 'events {' >> /etc/nginx/nginx.conf
sudo echo '    worker_connections 768;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo echo 'http {' >> /etc/nginx/nginx.conf
sudo echo '    sendfile on;' >> /etc/nginx/nginx.conf
sudo echo '    tcp_nopush on;' >> /etc/nginx/nginx.conf
sudo echo '    types_hash_max_size 2048;' >> /etc/nginx/nginx.conf
sudo echo '    server_tokens off;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/mime.types;' >> /etc/nginx/nginx.conf
sudo echo '    default_type application/octet-stream;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_prefer_server_ciphers on;' >> /etc/nginx/nginx.conf
sudo echo '    access_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    error_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    gzip on;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/conf.d/*.conf;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/sites-enabled/*;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo mkdir /var/www/my.ns
sudo chmod -R -v 777 /var/www/my.ns
sudo service nginx restart
sudo echo '<title>Nginx</title><a href="Win10_21H2_German_x64.iso">Win10_21H2_German_x64.iso</a>' >> /var/www/my.ns/index.php
