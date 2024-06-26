#!/bin/bash

# Установка Apache
apt-get update
apt-get install -y apache2

# Создание SSL директории и сертификатов
mkdir /etc/apache2/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/parol.local.key -out /etc/apache2/ssl/parol.local.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=parol.local"

# Настройка Apache для использования SSL
cat <<EOT > /etc/apache2/sites-available/parol.local.conf
<VirtualHost *:80>
    ServerName parol.local
    ServerAlias www.parol.local
    Redirect permanent / https://parol.local/
</VirtualHost>

<VirtualHost *:443>
    ServerName parol.local
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/parol.local.crt
    SSLCertificateKeyFile /etc/apache2/ssl/parol.local.key

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOT

a2enmod ssl
a2ensite parol.local.conf
a2dissite 000-default.conf
systemctl restart apache2

