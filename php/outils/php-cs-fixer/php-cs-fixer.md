# PHP CS Fixer

- [Documentation](https://github.com/FriendsOfPhp/PHP-CS-Fixer)
- [Règles](https://mlocati.github.io/php-cs-fixer-configurator/#version:2.18)

## Installation

* Globalement :
    * `composer global require friendsofphp/php-cs-fixer` installe via composer.
    * `wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O php-cs-fixer` télécharge le fichier avec `wget`.
    * `curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o php-cs-fixer` télécharge le fichier avec `curl`.
    * Pour `curl` et `wget` :
        ```bash
        $ sudo chmod a+x php-cs-fixer
        $ sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer
        ```

## Utilisation

* `php-cs-fixer fix nomDossier/aCorriger` corrige un dossier (par défaut PSR1 et PSR2 sont appliquées) :
    * `--verbose` affiche les règles à appliquer.
    * `--rules=@Symfony,-@PSR1,-blank_line_before_statement,strict_comparison` sélectionne les règles à appliquer, ici les règles précédées d'un `-` ne seront pas appliquées.
    * `--dry-run` affiche les modifications sans les appliquer.
    * `--diff` affiche les modifications apportées.