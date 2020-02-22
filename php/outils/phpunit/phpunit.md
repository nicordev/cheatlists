# PHPUnit

## Installation pour Symfony

* `composer require --dev symfony/phpunit-bridge` installe juste phpunit
* `composer require --dev symfony/browser-kit symfony/css-selector` installe le nécessaire pour faire des tests fonctionnels
* `composer require --dev symfony/test-pack` installe tout le bazar d'un coup
* Exécuter `./vendor/bin/simple-phpunit` pour installer phpunit

## Utilisation

* Pour Symfony 4
    * Exécuter `php bin/phpunit`
* Pour Symfony 3
    * Exécuter `./vendor/bin/simple-phpunit`
* `php bin/phpunit --verbose` ou `-v` détaille les problèmes.
* `php bin/phpunit --coverage-html nomDossierDestination` génère un rapport du coverage
* `php bin/phpunit --filter=testNomMethodeATester` exécute certains tests seulement
* `php bin/phpunit chemin/vers/fichierATester/nomfichierOuDossier` exécute les tests d'un fichier ou d'un dossier

### Utiliser les assertions de phpunit ailleurs

* Utiliser les méthodes statiques de la classe `PHPUnit\Framework\Assert`

### Tests fonctionnels avec phpunit

* On peut visualiser la page demandée par un test en faisant un `echo $client->getResponse()->getContent();` dans la méthode de test et en redirigeant la sortie vers un fichier `.html` en exécutant `./bin/phpunit --filter nomMethodeTest > nomFichierDestination.html`
* On peut ajouter des headers perso dans la requête en préfixant l'intitulé du header par `HTTP_`
    ```php
        $this->client->request(
            'GET',
            "/products/{$this->testProduct->getId()}",
            [],
            [],
            [
                "HTTP_X-AUTH-TOKEN" => "test_token"
            ]
        );
    ```