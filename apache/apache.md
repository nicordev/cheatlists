# Apache

Avoir plusieurs sites web sur le même serveur :
- dans un fichier `nomSite.conf` :

    ```
    <VirtualHost *:80>

        Define server_name nomSite.local
        Define basedocroot  /var/www/html/
        Define docrootweb   ${basedocroot}/public
        Define logdir   /var/log/apache2/
        
        ServerName ${server_name}
        DocumentRoot ${docrootweb}
        ErrorLog ${logdir}/error.log
        CustomLog ${logdir}/access.log Combined

        Undefine server_name
        Undefine basedocroot
        Undefine docrootweb
        Undefine logdir
    </VirtualHost>
    ```

- dans docker-compose.yml :

    ```
    version: "3"

    services:
        application:
            image: php:8.0-apache
            volumes:
            - ./docker/vhosts:/etc/apache2/sites-enabled
            - ./:/var/www/html
    ```

Activer la gestion des tokens d'autorisation :
- Fichier `httpd.conf` :

    ```
    SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
    ```