# practica-02-IAW
### En esta ptráctica haremos lo mismo pero desde una máquina de Red Hat Enterprises

### Para ello primero debemos lanzar la instancia nueva en amaazon con nuestro Red Hat
![Captura 1](https://github.com/JoseFco04/practica-02-IAW/assets/145347148/4978d515-4458-4def-a212-38488444cae0)

### El tipo de instancia le ponemos medium y el tipo de clave elegimos vockey que va a ser nuestra clave para conectarnos por ssh en el visual studio code
![Captura 2 ](https://github.com/JoseFco04/practica-02-IAW/assets/145347148/ce367d35-a252-4116-8984-32ed34505f79)

### Le permitimos el tráfico http y https para que añada a las reglas de entrada a la instancia 
![capt 3](https://github.com/JoseFco04/practica-02-IAW/assets/145347148/5af802b0-11a1-475b-8226-0f4554a87581)

### Le asignamos una ip elastica con la que vamos a poder ver nuestra pagina web en nuestro navegador y se nos quedaria asi la instancia.
![Cap 4](https://github.com/JoseFco04/practica-02-IAW/assets/145347148/7c0e449a-a1b5-42c3-a460-b8346630551f)

### Tenemos 3 scripts para llevar a cabo esta práctica, el primero es el install_lamp en el cual vamos a seguir estos pasos para instalar apache, mysql y php :

### Configuramos el script para que se muestren los comandos que se ejecutan 
set -x

### Actualizamos los paquetes 
dnf update -y 

### Instalamos el servidor web  Apache
### --------------------------------------------------------------------
dnf install httpd -y 

### Iniciamos el servicio de apache 
systemctl start httpd 

### Configuramos para que el servicio se inicie automaticamente
systemctl enable httpd 

### Instalamos Mysql server
### ----------------------------------------------------------------------
dnf install mysql-server -y

### iniciamos el servicio de MySQL
systemctl start mysqld

### Configuramos el servicio para que se inicie automaticamente en cada reinicio
systemctl enable mysqld

### Instalamos PHP
### ------------------------------------------------------------------------
dnf install php -y 

### Instalamos la extensión de PHP para MySQL
dnf install php-mysqlnd -y 

### Reiniciamos el servicio de Apache
systemctl restart httpd

### Copiamos el archivo info.php en /var/www/html
cp ../php/info.php /var/www/html

### Cambiamos el propietario y el grupo del directorio /var/www/html
chown -R apache:apache /var/www/html

## Una vez hecho y ejecutado este script tenemos que ejecutar otro script que es el install_tools para instalar phpmyadmin: 

