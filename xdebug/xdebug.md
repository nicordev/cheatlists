# xDebug

## php.ini

Ajouter les lignes suivantes au fichier `php.ini` de la version de php utilisée :
```
[xdebug]
zend_extension="c:/wamp64/bin/php/php7.3.5/zend_ext/php_xdebug-2.7.2-7.3-vc15-x86_64.dll"
xdebug.remote_enable = off
xdebug.profiler_enable = off
xdebug.profiler_enable_trigger = Off
xdebug.profiler_output_name = cachegrind.out.%t.%p
xdebug.profiler_output_dir ="c:/wamp64/tmp"
xdebug.show_local_vars = off
xdebug.remote_autostart = on
xdebug.remote_connect_back = on
```

## Utilisation dans Postman

* Ajouter `XDEBUG_SESSION_START=PHPSTORM` comme paramètre de l'URL de la requête : `http://localhost:8000/monUri?XDEBUG_SESSION_START=PHPSTORM`