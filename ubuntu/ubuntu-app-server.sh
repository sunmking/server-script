#!/bin/bash

GREENCOLOR='\033[1;32m'
YELLOWCOLOR='\033[1;33m'
NC='\033[0m'
sudo apt-get update

sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get -y autoremove
sudo service apache2 stop
sudo apt-get remove -y apache2*
sudo apt-get -y autoremove

printf "${GREENCOLOR}Nice And Clean,Let's Begin! ${NC} \n\n"

sudo apt-get update
sudo apt-get -y install zsh htop zip unzip

printf "${YELLOWCOLOR}Installing Nginx ${NC} \n"

sudo apt-get update
sudo apt-get -y install nginx-full
sudo service nginx start

printf "${GREENCOLOR}Successfully Added PPA For PHP7.2 ${NC} \n\n"

printf "${YELLOWCOLOR}Installing PHP7.2 And PHP7.2-FPM ${NC} \n"
sudo apt-get update
sudo apt-get -y install php7.2
sudo apt-get -y install php7.2-mysql
sudo apt-get -y install php7.2-fpm
sudo apt-get -y install php7.2-curl php7.2-xml php7.2-json php7.2-gd php7.2-mbstring php7.2-bcmath php7.2-gd
printf "${GREENCOLOR}Successfully Installed PHP7.1 And PHP7.1-FPM ${NC} \n\n"

printf "${YELLOWCOLOR}Configuring PHP7.2-FPM ${NC} \n"
sudo service php7.2-fpm restart

sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get remove -y apache2*
sudo apt-get -y autoremove

sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

printf "${YELLOWCOLOR}Installing Mysql5.7 ${NC} \n"

sudo apt-get install mysql-client-5.7 mysql-server-5.7

sudo service mysql restart

sudo systemctl enable mysql
sudo systemctl enable nginx
sudo systemctl enable php7.2-fpm

printf "${YELLOWCOLOR}Installing Composer ${NC} \n"

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

printf "${YELLOWCOLOR}Check Version ${NC} \n"

printf "${YELLOWCOLOR}--------------------${NC} \n"
composer --version
printf "${YELLOWCOLOR}--------------------${NC} \n"
mysql --version
printf "${YELLOWCOLOR}--------------------${NC} \n"
nginx --version
printf "${YELLOWCOLOR}--------------------${NC} \n"
php --version
printf "${YELLOWCOLOR}--------------------${NC} \n"

printf "${GREENCOLOR}Everything is all set! ${NC} \n\n"