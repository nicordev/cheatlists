# PHPUnit

## Installation pour Symfony

* Exécuter `composer require --dev symfony/phpunit-bridge`
* Exécuter `./vendor/bin/simple-phpunit` pour installer phpunit

## Utilisation

* Pour Symfony 4
    * Exécuter `php bin/phpunit`
* Pour Symfony 3
    * Exécuter `./vendor/bin/simple-phpunit`

### Exécuter des tests en particulier

* Ajouter `--filter=testNomMethodeATester` après la commande

### Exécuter les tests d'un fichier ou d'un dossier de tests particulier

* Ajouter le chemin du fichier ou du dossier à la commande
    * Exemple : `php bin/phpunit tests/Controller/ProductControllerTest``

## Utiliser les assertions de phpunit ailleurs

* Utiliser les méthodes statiques de `PHPUnit\Framework\Assert`