#!/bin/bash

echo "Welcome automated LEMP Stack Setup (Ubuntu 18.04) 1.2"

echo "Step:1 [System Update]"
echo "Update Starts....."
sudo apt update && sudo apt upgrade
echo -e "System Update Completed Successfully\n"

echo "Step:2 [Install NGINX]"
sudo apt install -y nginx
echo -e "NGINX Installation Completed Successfully\n"


echo "Step:3 [Allow SSH in Firewall]"
sudo ufw allow OpenSSH
echo -e "Done."

echo "Step:4 [Allow nginx in Firewall]"
sudo ufw allow in "Nginx Full"
echo -e "Done."

echo "Copying IP of this server"
ip=`curl -s https://api.ipify.org`

echo "Step:4 [Allow nginx in Firewall]"
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev
echo -e "MySQL Installation Completed Successfully\n"

echo "Step:5 [Install PHP7.2]"
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y 
sudo apt-get -y update
sudo apt-get install -y php7.2
sudo apt-cache search php7.2
sudo apt-get install -y php7.2-cli php7.2-fpm php7.2-mysql php7.2-curl php7.2-json php7.2-cgi libphp7.2-embed libapache2-mod-php7.2 php7.2-zip php7.2-mbstring php7.2-xml php7.2-intl

echo -e "PHP 7.2 Installation Completed Successfully\n"

sudo systemctl start php7.2-fpm
sudo systemctl enable php7.2-fpm

echo "Step:5 [Install PHPmyadmin]"
sudo apt-get install -y phpmyadmin
echo -e "PHPmyadmin Installation Completed Successfully\n"

sudo systemctl restart nginx

echo "Remove the default symlink in sites-enabled directory"
sudo rm /etc/nginx/sites-enabled/default


sudo echo 'server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www;
    index index.php index.html index.htm index.nginx-debian.html;
    server_name '$ip';
    location / {
        try_files $uri $uri/ =404;
    }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }
    location ~ /\.ht {
        deny all;
    }
}' > /etc/nginx/sites-available/default

sudo nginx -t
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enable/
sudo systemctl reload nginx

echo -e "Downloading latest Adminer\n"
cd /var/www/html
sudo wget -q -O db.php https://www.adminer.org/latest-mysql-en.php
echo -e "Dowloaded and Renamed Successfully\n"

echo "Creating a Configuration File for Adminer in sites-enabled directory"
cd /etc/nginx/sites-available
sudo wget https://raw.githubusercontent.com/masiur/Environment-Configuration/master/src/db-adminer
sudo ln -s /etc/nginx/sites-available/db-adminer /etc/nginx/sites-enabled/
sudo systemctl reload nginx
sudo ufw allow 50
cd ~

sudo cat > /var/www/index.html <<END
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx! Looks like your Server is Ready</h1>
<br/>
<a href="http://$ip/info.php">Php - info</a>.<br/>
<br/>
<a href="http://$ip:50">Database</a>.<br/>
</body>
</html>
END

sudo cat > /var/www/info.php <<END
<?php
phpinfo();
?>
END

echo "Configuration File Ready"

echo "Step:6 [Install curl]"
sudo apt-get install -y curl
echo -e "curl Installation Completed Successfully\n"

echo "Step:7 [Install Git]"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install -y git
echo -e "Git Installation Completed Successfully\n"

echo "Step:8 [Install php-fpm]"
sudo service php7.2-fpm restart
sudo systemctl restart nginx
echo -e "mcrypt Installation and enable rewrite Completed Successfully\n" 

echo "Step:9 [Install Composer]"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo -e "Composer Installation Completed Successfully\n"

echo "+-------------------------------------------+"
echo "|    ${b}${A}Finish Auto Install and Setup LEMP${R}     |"
echo "|                                           |"
echo "| Web Site: http://$ip/"
echo "|                                           |"
echo "| Database Adminer: http://$ip:50"
echo "| User:${E}root${R} || Pass:${E}$pass${R}"
echo "|                                           |"
echo "| Test PHP:http://$ip/info.php"
echo "|                                           |"
echo "|        ${E}Warning:Delete info.php${R}            |"
echo "|                                           |"
echo "+-------------------------------------------+"

echo "Thanks  !!! ~ Your Lemp config has been successfully done"
