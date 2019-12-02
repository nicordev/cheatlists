# Composer

## Installation

* [ici](https://getcomposer.org/download/)

## Utilisation

* Soit via la commande `composer` si composer est installé globalement, soit via `php composer.phar` si on a le fichier `composer.phar` dans le dossier du projet.
* `compsoer intall` lit le fichier `composer.json`, créé un fichier `composer.lock` et installe les paquets.
* `composer update` met à jour les paquets installés selon le fichier `composer.json` et met à jour le fichier `composer.lock`
* `composer require nomPackage [--dev]` ajoute un paquet au fichier `composer.json`. Ajouter `--dev` pour que le paquet soit utilisé dans la partie développement `require-dev` du fichier `composer.json`.
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