#!/bin/bash

echo "Welcome to Easy LEMP Stack Setup (Ubuntu 20.04) 1.1"

echo "Steap:1 [System Update]"
echo "Update Starts....."
sudo apt-get update
echo -e "System Update Completed Successfully\n"

echo "Step:2 [Install NGINX]"
sudo apt-get install -y nginx
echo -e "NGINX Installation Completed Successfully\n"

echo "Step:3 [Install MySQL]"
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev
echo -e "MySQL Installation Completed Successfully\n"

echo "Step:4 [Install PHP7.4]"
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y 
sudo apt-get -y update
sudo apt-get install -y php7.4
sudo apt-cache search php7.4
sudo apt-get install -y php7.4-cli php7.4-fpm php7.4-mysql php7.4-curl php7.4-json php7.4-cgi libphp7.4-embed libapache2-mod-php7.4 php7.4-zip php7.4-mbstring php7.4-xml php7.4-intl

echo -e "PHP 7.4 Installation Completed Successfully\n"

sudo systemctl start php7.4-fpm
sudo systemctl enable php7.4-fpm

echo "Step:5 [Install PHPmyadmin]"
sudo apt-get install -y phpmyadmin
echo -e "PHPmyadmin Installation Completed Successfully\n"

sudo systemctl restart nginx

echo "Remove the default symlink in sites-enabled directory"
sudo rm /etc/nginx/sites-enabled/default
cat > /etc/nginx/sites-enabled/default <<EOF

server {
  listen 80;
  listen [::]:80;
  server_name localhost;
  root /usr/share/nginx/html/;
  index index.php index.html index.htm index.nginx-debian.html;

  location / {
    try_files $uri $uri/ =404;
  }

  error_page 404 /404.html;
  error_page 500 502 503 504 /50x.html;

  location = /50x.html {
    root /usr/share/nginx/html;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
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

echo "Step:6 [Install curl]"
sudo apt-get install -y curl
echo -e "curl Installation Completed Successfully\n"

echo "Step:7 [Install Git]"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y git
echo -e "Git Installation Completed Successfully\n"

echo "Step:8 [Install mcrypt and enable rewrite]"
sudo service php7.4-fpm restart
sudo systemctl restart nginx
echo -e "mcrypt Installation and enable rewrite Completed Successfully\n" 

echo "Step:9 [Install Composer]"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo -e "Composer Installation Completed Successfully\n"


echo "Thanks  !!! ~ Your Lemp config has been successfully done"
