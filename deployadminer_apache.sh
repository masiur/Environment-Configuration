#!/bin/bash

echo "Welcome to Lightweight Database UI Management (Adminer for PHP) Setup on LEMP Stack Setup (Ubuntu 16.04)"

echo "Steap:1 [System Update]"
echo "Update Starts....."
sudo apt-get update
echo -e "System Update Completed Successfully\n"

echo -e "Downloading latest Adminer\n"
cd /var/www/html
sudo wget -q -O db.php https://www.adminer.org/latest-en.php
echo -e "Dowloaded and Renamed Successfully\n"

echo "Creating a Configuration File for Adminer in sites-enabled directory"
cd /etc/apache2/sites-available
sudo wget https://raw.githubusercontent.com/masiur/Environment-Configuration/master/src/adminer_apache.conf
sudo systemctl reload apache2
cd ~
echo "Configuration File Ready"

sudo apachectl configtest
sudo systemctl reload apache2


echo "Thanks  !!! ~ Your DB Management istallation has been successfully done. Visit to YOURIP:50 or YOURDOMAIN:50"