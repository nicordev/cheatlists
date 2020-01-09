# xDebug

## Installation

* `sudo apt-get install php-xdebug` installe xdebug sur debian et dérivés.
* `pecl install xdebug` installe xdebug via pecl.

## php.ini

Ajouter les lignes suivantes au fichier `php.ini` de la version de php utilisée :
* Linux
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
* Windows
    ```
    [xdebug]
    zend_extension="c:/wamp64/bin/php/php7.3.5/zend_ext/php_xdebug-2.7.2-7.3-vc15-x86_64.dll"
    xdebug.remote_enable = On
    xdebug.profiler_enable = On
    xdebug.profiler_enable_trigger = On
    xdebug.profiler_output_name = cachegrind.out.%t.%p
    xdebug.profiler_output_dir ="c:/wamp64/tmp"
    xdebug.show_local_vars = Off
    xdebug.remote_autostart = on
    xdebug.remote_connect_back = on
    ```

## Utilisation dans Postman

* Ajouter `XDEBUG_SESSION_START=PHPSTORM` comme paramètre de l'URL de la requête : `http://localhost:8000/monUri?XDEBUG_SESSION_START=PHPSTORM`