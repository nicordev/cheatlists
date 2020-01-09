# PHP - Installation et configuration

## Ubuntu

* Installer une version spécifique :
    * [PHP 7.3](https://computingforgeeks.com/how-to-install-php-7-3-on-ubuntu-18-04-ubuntu-16-04-debian/)
        1. `sudo add-apt-repository ppa:ondrej/php` ajoute le repository
        2. `sudo apt-get update`
        3. `sudo apt-get install php7.3` installe php 7.3
* Installer des extensions : `sudo apt-get install php-nomExtensionDésirée`
    * xdebug :
        1. `sudo apt-get install php-xdebug` installe xdebug
        2. Ajouter au `php.ini` :
            ```
            [xdebug]
            zend_extension="/usr/lib/php/modules/xdebug.so"
            xdebug.remote_enable=on
            xdebug.profiler_enable=off
            xdebug.profiler_enable_trigger=off
            xdebug.remote_autostart=on
            xdebug.remote_connect_back=on
            xdebug.remote_host = localhost
            ```
    * `sudo apt-get install php-xml` installe l'extension *xml* nécessaire pour composer.
    * `sudo apt-get install php-curl` installe l'extension *curl* utile pour composer.
    * `sudo apt-get install php-mysql` installe l'extension nécessaire pour mysql et mariadb.

## Configuration

* Configuration via le fichier `php.ini` situé dans `/etc/php/numéro_version/apache2/` et dans `/etc/php/numéro_version/cli/`.
* Sélectionner une version
    * `sudo update-alternatives --set php /usr/bin/php7.3` sélectionne la version PHP 7.3 pour la CLI

## xDebug

1. `sudo apt-get install php-xdebug` installe xdebug
2. Ajouter au `php.ini` :
    ```
    [xdebug]
    zend_extension="/usr/lib/php/modules/xdebug.so"
    xdebug.remote_enable=on
    xdebug.profiler_enable=off
    xdebug.profiler_enable_trigger=off
    xdebug.remote_autostart=on
    xdebug.remote_connect_back=on
    xdebug.remote_host = localhost
    ```