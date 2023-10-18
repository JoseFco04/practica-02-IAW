#!/bin/bash

# Configuramos el script para que se muestren los comandos que se ejecutan 
set -x

# Importamos el script de varuables de  entorno 
source .env

# Actualizamos los paquetes
dnf update -y

#Instalamos los modulos de php necesarios para phpMyAdmin.
sudo dnf install php-mbstring php-zip php-json php-gd php-fpm php-xml -y

#Despues de la inctalacion es necesario reinicoar el servicio de apache
systemctl restart httpd

# Instalamos la utilidad wget
dnf install wget -y 

#Eliminamos descargas previas de phpMyAdmin
rm -rf /tmp/phpMyAdmin-5.2.1-all-languages.zip

# Eliminamos instalaciones previad de phpMyAdmin
rm -rf /var/www/html/phpmyadmin

# Descargamos el codigo fuente de phpMyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.zip -P /tmp

#Instalamos la utilidad unzip 
dnf install unzip -y

# Descomprimimos el codigo fuente de phpMyAdmin en /var/www/html
unzip -u /tmp/phpMyAdmin-5.2.1-all-languages.zip -d /var/www/html

# Renombramos el directorio de phpMyAdmin
mv /var/www/html/phpMyAdmin-5.2.1-all-languages /var/www/html/phpmyadmin

# Actualizamos los permisos del directorio /var/www/html
chown -R apache:apache /var/www/html

# Creamos un archivo de configuracion a partir del archivo e ejemplo
cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php

# Eliminamos si existe alguna base de datos previa de phpMyadmin
mysql -u root <<< "DROP DATABASE IF EXISTS phpmyadmin"

# Importamos el script de la base de datos de phpMyAdmin
mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql

# Creamos el usuario para la base de datos y le asignamos privolegios 
sudo mysql -u root <<< "DROP USER IF EXISTS $PMA_USER@'%'"
sudo mysql -u root <<< "CREATE USER $PMA_USER@'%' IDENTIFIED BY '$PMA_PASS'"
sudo mysql -u root <<< "GRANT ALL PRIVILEGES ON $PMA_DB.* TO $PMA_USER@'%'"