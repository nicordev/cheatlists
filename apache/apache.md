# Apache

Pour activer la gestion des tokens d'autorisation :
- Fichier `httpd.conf` :

    ```
    SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
    ```