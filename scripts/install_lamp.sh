#!/bin/bash

# Configuramos el script para que se muestren los comandos que se ejecutan 
set -x

# Actualizamos los paquetes 
dnf update -y 

# Instalamos el servidor we  Apache
dnf install httpd -y 

# Iniciamos el servicio de apache 
systemctl start httpd 

# Configuramos para que el servicio se inicie automaticamente
systemctl enable httpd 
