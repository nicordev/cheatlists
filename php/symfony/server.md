

## Configurer son serveur

[Documentation](https://symfony.com/doc/current/setup/web_server_configuration.html)

Le dossier `public/` est la racine. Le virtual host doit donc pointer vers ce dossier.

## Apache

Installer *symfony/apache-pack* en exécutant `composer require symfony/apache-pack`
>Installe au passage un `.htaccess` dans le dossier `public\`

## Utiliser le serveur de développement

* Lancer le serveur avec la commande `symfony server:start`
    * On peut ajouter `-d` pour faire tourner le serveur en arrière plan
* Activer https avec la commande `symfony server:ca:install`
* Voir les logs avec la commande `symfony server:log`
* Utiliser une version particulière de php en créant un fichier `.phpversion` contenant le numéro de version
    * `echo "7.2" > .php-version`
* Créer un fichier `php.ini` personnalisé à la racine du projet pour modifier la configuration de php du serveur
* Le fichier `php.ini` utilisé dans mon cas est situé dans `c/wamp64/bin/php/php7.3.5/`

## Modifier PHP

* Dans `bin/console` : 
    ```
    // On modifie des parties de php.ini
    ini_set('date.timezone', 'UTC');
    ini_set('display_errors', (int) $debug);
    ini_set('memory_limit', -1);

    if ($debug) {
        Debug::enable(E_ERROR); // On change la sensibilité des erreurs, warnings...
    }
    ```