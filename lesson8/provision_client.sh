#!/bin/bash

# Добавление записи в /etc/hosts
echo "192.168.56.10 parol.local www.parol.local" >> /etc/hosts

# Установка curl для проверки
apt-get update
apt-get install -y curl

# Копирование сертификата с сервера и добавление его в доверенные
# Установка sshpass для автоматизации scp с использованием пароля vagrant
apt-get install -y sshpass
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.56.10:/etc/apache2/ssl/parol.local.crt /usr/local/share/ca-certificates/parol.local.crt
update-ca-certificates

