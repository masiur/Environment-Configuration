#!/bin/bash

echo "Welcome to Lightweight Database UI Management (Adminer for PHP) Setup on LEMP Stack Setup (Ubuntu 16.04)"

echo "Steap:1 [System Update]"
echo "Update Starts....."
sudo apt-get update
echo -e "System Update Completed Successfully\n"

echo -e "Downloading latest Adminer\n"
sudo wget https://www.adminer.org/latest-mysql-en.php
sudo mv latest-mysql-en.php db.php
echo -e "Dowloaded and Renamed Successfully\n"

echo "Creating a Configuration File for Adminer in sites-enabled directory"
cat > /etc/nginx/sites-enabled/db-adminer <<EOF

server {
  listen 51;
  listen [::]:51;
 
  root /var/www/html/;
  index db.php

  location / {
    try_files $uri $uri/ =404;
  }

  error_page 404 /404.html;
  error_page 500 502 503 504 /50x.html;

  location = /50x.html {
    root /usr/share/nginx/html;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    #fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    #include fastcgi_params;
    #include snippets/fastcgi-php.conf;
  }

  location ~ /\.ht {
    deny all;
  }
}

EOF

sudo nginx -t
sudo systemctl reload nginx


echo "Thanks  !!! ~ Your DB Management istallation has been successfully done. Visit to YOURIP:51 or YOURDOMAIN:51"
