#!/bin/bash

###################################################################
#         Author: Masiur Rahman Siddiki
#           Link: http://github.com/masiur/Environment-Configuration
#    Description: Install LAMP stack and PHPMyAdmin/Adminer For Debian based systems.
###################################################################

# GENERATE PASSOWRDS
# sudo apt -qy install openssl # openssl used for generating a truly random password
PASS_MYSQL_ROOT=`openssl rand -base64 8` # this you need to save 
PASS_PHPMYADMIN_APP=`openssl rand -base64 8` # can be random, won't be used again
PASS_PHPMYADMIN_ROOT="${PASS_MYSQL_ROOT}" # Your MySQL root pass

systemUpdate
installApache
allowFirewall
installingPHP
installingMySQL
securingMySQL
installingPHPMyadmin
restartApache
configTest
intallGit
installComposer

systemUpdate() {
    echo "Steap:1 [System Update]"
    echo "Update Starts....."
    sudo apt-get update
    echo -e "System Update Completed Successfully\n"
}

installApache() {
    echo "Installing Apache2"
    sudo apt-get install -y apache2
    echo -e "Apache Installation Completed Successfully\n"
}

allowFirewall() {
    sudo ufw allow 22
    sudo ufw allow 80
    sudo ufw allow 443
    sudo ufw enable
}

installingPHP() {

    echo "Now Installing PHP 7.4"
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:ondrej/php -y 
    sudo apt-get -y update
    sudo apt install php7.4 libapache2-mod-php php7.4-mysql php7.4-fpm php7.4-curl php7.4-cgi php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl -y
    echo -e "PHP 7.4 Installation Completed Successfully\n"
}

installingMySQL() {
    echo "Installing MySQL"
    sudo apt install -y mysql-server
    echo -e "MySQL Installation Completed Successfully\n"
}

securingMySQL() {
	# secure MySQL install
	echo -e "\n ${Cyan} Securing MySQL.. ${Color_Off}"
	
	mysql --user=root --password=${PASS_MYSQL_ROOT} << EOFMYSQLSECURE
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOFMYSQLSECURE

# NOTE: Skipped validate_password because it'll cause issues with the generated password in this script
}

installingPHPMyadmin() {
	# PHPMyAdmin
	echo -e "Installing PHPMyAdmin.."
	
	# set answers with `debconf-set-selections` so you don't have to enter it in prompt and the script continues
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" # Select Web Server
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true" # Configure database for phpmyadmin with dbconfig-common
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password ${PASS_PHPMYADMIN_APP}" # Set MySQL application password for phpmyadmin
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password ${PASS_PHPMYADMIN_APP}" # Confirm application password
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password ${PASS_MYSQL_ROOT}" # MySQL Root Password
	sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/internal/skip-preseed boolean true"

	DEBIAN_FRONTEND=noninteractive sudo apt -qy install phpmyadmin
}



installingPHPMyadmin() {
    echo "Now Install PHPmyadmin"
    sudo apt-get install -y phpmyadmin
    echo -e "PHPmyadmin Installation Completed Successfully\n"
}

restartApache() {
    sudo systemctl restart apache2
}

configTest(){
    sudo apachectl -t
    sudo systemctl reload apache2
}
intallGit() {
    echo "Installing Git"
    sudo apt-get install -y git
    echo -e "Git Installation Completed Successfully\n"
}
installComposer() {
    echo "Step:9 [Install Composer]"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    echo -e "Composer Installation Completed Successfully\n"
}


echo -e "Thanks  !!! ~ Your LAMP config has been successfully done. MySQL password is: ${PASS_MYSQL_ROOT}"
