# Xampp

## Start in terminal

Execute `sudo /opt/lampp/lampp start`

## Start the GUI

Execute `sudo /opt/lampp/manager-linux-x64.run`

## php.ini

`/opt/lampp/etc/php.ini`

## php

php 7.3.8 situé ici : /opt/lampp/bin/php-7.3.8

## VirtualHosts

* Activer le bazar dans le fichier `/opt/lampp/etc/httpd.conf` en décommantant la ligne `#Include etc/extra/httpd-vhosts.conf` (en enlevant le `#`) en sudo
* Editer le fichier `/etc/hosts` en sudo en ajoutant l'ip du virtual host :
```
    127.0.0.1	localhost
    127.0.0.5	myawesomeproject.zog
```
* Editer le fichier `/opt/lampp/etc/extra/httpd-vhosts.conf` en ajoutant un bazar du genre :
```
<VirtualHost 127.0.0.5:80>
  DocumentRoot "/opt/lampp/htdocs/my-first-project/public"
  DirectoryIndex index.php

  <Directory "/opt/lampp/htdocs/my-first-project/public">
	Options All
	AllowOverride All
	Require all granted
  </Directory>
</VirtualHost>
```
* Relancer le serveur Apache
