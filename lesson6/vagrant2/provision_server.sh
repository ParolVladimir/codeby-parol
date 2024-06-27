   #!/bin/bash

   # Установка OpenSSH Server
   sudo apt-get update
   sudo apt-get install -y openssh-server

   # Создание пользователя vagrant если он не существует
   id -u vagrant &>/dev/null || sudo useradd -m -s /bin/bash vagrant

   # Создание директории .ssh и добавление публичного ключа
   mkdir -p /home/vagrant/.ssh
   echo "your-public-key-here" > /home/vagrant/.ssh/authorized_keys
   chown -R vagrant:vagrant /home/vagrant/.ssh
   chmod 600 /home/vagrant/.ssh/authorized_keys
   
