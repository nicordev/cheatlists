# PHP - Installation et configuration

## Ubuntu

* [PHP 7.3](https://computingforgeeks.com/how-to-install-php-7-3-on-ubuntu-18-04-ubuntu-16-04-debian/)
    1. `sudo add-apt-repository ppa:ondrej/php` ajoute le repository
    2. `sudo apt-get update`
    3. `sudo apt-get install php7.3` installe php 7.3

## Configuration via php.ini

Fichier situé dans `/etc/php/numéro_version/apache2/` et dans `/etc/php/numéro_version/cli/`

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