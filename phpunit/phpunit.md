# PHPUnit

## Installation pour Symfony

* Exécuter `composer require --dev symfony/phpunit-bridge`
* Exécuter `./vendor/bin/simple-phpunit` pour installer phpunit

## Exécution

* Pour Symfony 4
    * Exécuter `php bin/phpunit`
* Pour Symfony 3
    * Exécuter `./vendor/bin/simple-phpunit`

### Exécuter des tests en particulier

* `php bin/phpunit --filter=testNomMethodeATester`

### Exécuter les tests d'un fichier ou d'un dossier de tests particulier

* Ajouter le chemin du fichier ou du dossier à la commande
    * Exemple : `php bin/phpunit tests/Controller/ProductControllerTest`

## Utiliser les assertions de phpunit ailleurs

* Utiliser les méthodes statiques de `PHPUnit\Framework\Assert`

## Code coverage

* `./bin/phpunit --coverage-html nomDossierDestination` génère un rapport du coverage

## Tests fonctionnels avec phpunit

* On peut visualiser la page demandée par un test en faisant un `echo $client->getResponse()->getContent();` dans la méthode de test et en redirigeant la sortie vers un fichier `.html` en exécutant `./bin/phpunit --filter nomMethodeTest > nomFichierDestination.html`

### Ajouter des headers perso dans la requête

Préfixer l'intitulé du header par `HTTP_`

```
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