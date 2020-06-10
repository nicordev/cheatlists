# Composer

## Installation

* [ici](https://getcomposer.org/download/)
* ```
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'baf1608c33254d00611ac1705c1d9958c817a1a33bce370c0595974b342601bd80b92a3f46067da89e3b06bff421f182') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    ```
* `sudo mv composer.phar /usr/local/bin/composer` déplace le fichier de composer pour utiliser la commande `composer`.

## Configuration

* `~/.config/composer/config.json` fichier de configuration de composer :
    ```json
    {
        "config": {
            "secure-http": true 
        },
        "repositories": {
            "packagist": {
                "type": "composer",
                "url": "packagist.org"
            }
        }
    }
    ```
    * `"secure-http": true` active https pour communiquer avec packagist. Par défaut à `true`.

## Utilisation

* Soit via la commande `composer` si composer est installé globalement, soit via `php composer.phar` si on a le fichier `composer.phar` dans le dossier du projet.
* `compsoer intall` lit le fichier `composer.json`, créé un fichier `composer.lock` et installe les paquets.
* `composer update` met à jour les paquets installés selon le fichier `composer.json` et met à jour le fichier `composer.lock`.
* `composer require nomPackage [--dev]` ajoute un paquet au fichier `composer.json`.
    * Ajouter `--dev` pour que le paquet soit utilisé dans la partie développement `require-dev` du fichier `composer.json`.
    * `composer require nomUtilisateur/nomPackage:numéroVersion` spécifie une version. Par exemple : `nicordev/phprocks:^0.3.2`
* `composer dump-autoload` recré l'autoload de composer.

## Versions

```
"require": {
    "vendor/package": "1.3.2", // exactly 1.3.2

    // >, <, >=, <= | specify upper / lower bounds
    "vendor/package": ">=1.3.2", // anything above or equal to 1.3.2
    "vendor/package": "<1.3.2", // anything below 1.3.2

    // * | wildcard
    "vendor/package": "1.3.*", // >=1.3.0 <1.4.0

    // ~ | allows last digit specified to go up
    "vendor/package": "~1.3.2", // >=1.3.2 <1.4.0
    "vendor/package": "~1.3", // >=1.3.0 <2.0.0

    // ^ | doesn't allow breaking changes (major version fixed - following semver)
    "vendor/package": "^1.3.2", // >=1.3.2 <2.0.0
    "vendor/package": "^0.3.2", // >=0.3.2 <0.4.0 // except if major version is 0
}
```

## Optimisation

* `composer dump-autoload --optimize` ou `-o` convert PSR-0/4 autoloading to classmap to get a faster autoloader. This is recommended especially for production, but can take a bit of time to run so it is currently not done by default.