# Behaviour Driven Development avec Behat

## Installation

* Exécuter `composer require --dev behat/behat`
* Exécuter `./vendor/bin/behat --init`

## Installation de behat/mink

* Exécuter `composer require --dev behat/mink`
    * Erreur possible : `Fatal error: Allowed memory size of 1610612736 bytes exhausted (tried to allocate 4096 bytes) in phar`
        * Modifier `memory_limit = 2G` dans le fichier `php.ini` utilisé par l'exécutable php utilisé par la CLI
* Installer les drivers
    * Headless browser emulator `composer require --dev behat/mink-goutte-driver`
    * Browser controller `composer require --dev behat/mink-selenium2-driver`

## Utilisation des assertions de PHPUnit dans un projet Symfony dans la classe FeatureContext de Behat

* Ajouter `require_once __DIR__ . "/../../vendor/bin/.phpunit/phpunit-7.5/vendor/autoload.php";` dans le fichier `features/bootstrap/FeatureContext.php`

## Configuration

* Créer un fichier `behat.yaml` à la racine du projet ou dans un répertoire `/config/`
