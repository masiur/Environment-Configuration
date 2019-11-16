#!/bin/bash

echo "Welcome LAMP Stack Setup (Ubuntu 18.04) 1.1"

echo "Steap:1 [System Update]"
echo "Update Starts....."
sudo apt-get update
echo -e "System Update Completed Successfully\n"

echo "Step:2 [Install Apache2]"
sudo apt-get install -y apache2
echo -e "NGINX Installation Completed Successfully\n"

echo "Step:3 [Install MySQL]"
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev
echo -e "MySQL Installation Completed Successfully\n"

echo "Step:4 [Install PHP7.2]"
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y 
sudo apt-get -y update
sudo apt-get install -y php7.2
sudo apt-cache search php7.2
sudo apt-get install -y php7.2-cli php7.2-fpm php7.2-mysql php7.2-curl php7.2-json php7.2-cgi libphp7.2-embed libapache2-mod-php7.2 php7.2-zip php7.2-mbstring php7.2-xml php7.2-intl

echo -e "PHP 7.2 Installation Completed Successfully\n"

echo "Step:5 [Install PHPmyadmin]"
sudo apt-get install -y phpmyadmin
echo -e "PHPmyadmin Installation Completed Successfully\n"

sudo systemctl restart apache2

sudo apachectl -t
sudo systemctl reload apache2

echo "Step:6 [Install curl]"
sudo apt-get install -y curl
echo -e "curl Installation Completed Successfully\n"

echo "Step:7 [Install Git]"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y git
echo -e "Git Installation Completed Successfully\n"


echo "Step:9 [Install Composer]"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo -e "Composer Installation Completed Successfully\n"


echo "Thanks  !!! ~ Your LAMP config has been successfully done"
