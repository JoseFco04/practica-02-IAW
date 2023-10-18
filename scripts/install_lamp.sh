#!/bin/bash

# Configuramos el script para que se muestren los comandos que se ejecutan 
set -x

# Actualizamos los paquetes 
dnf update -y 

# Instalamos el servidor web  Apache
#--------------------------------------------------------------------
dnf install httpd -y 

# Iniciamos el servicio de apache 
systemctl start httpd 

# Configuramos para que el servicio se inicie automaticamente
systemctl enable httpd 

#Instalamos Mysql server
#----------------------------------------------------------------------
dnf install mysql-server -y

# iniciamos el servicio de MySQL
systemctl start mysqld

# Configuramos el servicio para que se inicie automaticamente en cada reinicio
systemctl enable mysqld

# Instalamos PHP
#------------------------------------------------------------------------
dnf install php -y 

#Instalamos la extensión de PHP para MySQL
dnf install php-mysqlnd -y 

# Reiniciamos el servicio de Apache
systemctl restart httpd

# Copiamos el archivo info.php en /var/www/html
cp ../php/info.php /var/www/html

# Cambiamos el propietario y el grupo del directorio /var/www/html
chown -R apache:apache /var/www/html