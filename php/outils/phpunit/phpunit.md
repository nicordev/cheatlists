# PHPUnit

## Principes

- Mock : simule un objet et ses méthodes tout en faisant des assertions 

## Méthodes utiles

- Mock partiel de la classe qu'on veut tester :
    ```php
    $openApiExportCommandRunner = $this->createPartialMock(
        OpenApiExportCommandRunner::class, 
        ['run'] // Tableau contenant les noms des méthodes qu'on veut mock
    );
    $openApiExportCommandRunner->expects(self::once())
        ->method('run')
        ->with($application, $arguments)
        ->willReturn($commandOutput)
    ;
    $result = $openApiExportCommandRunner->fetchDocumentation($application, $arguments);
    ```

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

## Configuration

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!-- https://phpunit.de/manual/current/en/appendixes.configuration.html -->
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://schema.phpunit.de/6.5/phpunit.xsd"
         backupGlobals="false"
         colors="true"
         bootstrap="config/bootstrap.php"
>
    <php>
        <ini name="error_reporting" value="-1"/>
        <server name="APP_ENV" value="test"/>
        <server name="SHELL_VERBOSITY" value="-1"/>
        <server name="DATABASE_URL" value="pgsql://postgres:postgres@postgresql:5432/test_database_name_here"/>
        <server name="SYMFONY_DEPRECATIONS_HELPER" value="disabled" />
        <server name="SYMFONY_PHPUNIT_VERSION" value="8.3" />
        <server name="KERNEL_CLASS" value="App\Kernel" />
    </php>

    <testsuites>
        <testsuite name="Project Test Suite">
            <directory>tests</directory>
        </testsuite>
    </testsuites>

    <filter>
        <whitelist>
            <directory>src</directory>
            <exclude>
                <directory>src/Migrations</directory>
                <directory>src/DataFixtures</directory>
                <file>src/Kernel.php</file>
            </exclude>
        </whitelist>
    </filter>

    <listeners>
        <listener class="Symfony\Bridge\PhpUnit\SymfonyTestsListener"/>
    </listeners>
</phpunit>
```