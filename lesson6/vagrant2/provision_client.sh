   #!/bin/bash

   # Генерация SSH ключа
   ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""

   # Добавление публичного ключа на сервер
   ssh-keyscan -H server >> /home/vagrant/.ssh/known_hosts

   # Создание команды для подключения к серверу
   echo 'ssh -i /home/vagrant/.ssh/id_rsa vagrant@server' > /home/vagrant/connect_to_server.sh
   chmod +x /home/vagrant/connect_to_server.sh
   
