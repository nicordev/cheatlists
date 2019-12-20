# Apache

## .htaccess

* [Redirection vers HTTPS](https://www.blogdumoderateur.com/redirection-301-htaccess/)
    ```
    RewriteEngine On
    RewriteCond %{SERVER_PORT} 80
    RewriteCond %{REQUEST_URI} !
    RewriteRule ^(.*)$ https://adresse-de-mon-site.com/$1 [R=301,L]
    ```