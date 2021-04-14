#!/bin/bash

apt-get -y update
add-apt-repository -y ppa:ondrej/php
logger "Installing WordPress"

# Set up a silent install of MySQL
dbpass=$1

# Install the LAMP stack and WordPress
apt-get -y install apache2 php7.4 php7.4-mysql wordpress

# Setup WordPress
gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz
bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress -u itopsadm@demo-triple-mysql.mysql.database.azure.com -t demo-triple-mysql.mysql.database.azure.com -p $dbpass localhost

ln -s /usr/share/wordpress /var/www/html/wordpress
mv /etc/wordpress/config-localhost.php /etc/wordpress/config-default.php

# Restart Apache
apachectl restart

logger "Done installing WordPress; open /wordpress to configure"
