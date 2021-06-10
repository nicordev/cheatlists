# PHPStan

> [Dépôt GitHub](https://github.com/phpstan/phpstan)

## Installation

- Via Composer :
  1. ```bash
     composer require --dev phpstan/phpstan
     ```
  1. `vendor/bin/phpstan` lance phpstan.
- Via Docker :
  > [Documentation](https://phpstan.org/user-guide/docker)
  1. `docker pull phpstan/phpstan` récupère la dernière image de phpstan.
     - Pour ajouter des extensions PHPStan :
       1. Créer une nouvelle image qui étend de `phpstan/phpstan` et lancer un `composer require` dans le `Dockerfile` de l'image. Exemple de `Dockerfile` pour l'extension `phpstan/phpstan-phpunit` :
          ```
          FROM phpstan/phpstan:latest
          RUN composer global require phpstan/phpstan-phpunit
          ```
       1. Mettre à jour le fichier `phpstan.neon` pour utiliser l'extension :
          ```
          includes:
              - /composer/vendor/phpstan/phpstan-phpunit/extension.neon
          ```
     - Pour ajouter des extensions PHP :
       - Créer une nouvelle image qui étend de `phpstan/phpstan` et récupérer les extensions dans le `Dockerfile`. Exemple où on ajoute `soap` et `intl` :
         ```
         FROM phpstan/phpstan:latest
         RUN apk --update --progress --no-cache add icu-dev libxml2-dev \
             && docker-php-ext-install intl soap
         ```
       - L'image de PHPStan utilise l'image officielle `php:cli-alpine`. Exécuter `docker run --rm php:cli-alpine -m` pour voir les modules installés dans cette image.
  1. Créer l'alias suivant dans le `~/.bashrc` pour pouvoir lancer phpstan dans le répertoire courant :
     ```bash
     alias phpstan='docker run -v $PWD:/app --rm phpstan/phpstan'
     ```
- En utilisant l'image docker [jakzal/phpqa](https://hub.docker.com/r/jakzal/phpqa) :
  - Contient déjà des extensions de phpstan.
  - Contient d'autres outils comme phpunit et infection.

## Intégration dans GitLab CI/CD

Configurer un job dans le fichier `.gitlab-ci.yml` :

```yaml
phpstan:
  tags:
    - docker
  image: jakzal/phpqa
  stage: tests
  script: phpstan analyse --level 8 src tests
  allow_failure: true # A mettre à false pour que l'analyse de phpstan bloque la MR si le code contient des erreurs.
```

## Utilisation

> Rappel : si vous utilisez composer, remplacer `phpstan` par `vendor/bin/phpstan`.

### Analyse

PHPStan utilise [9 niveaux d'exigence](https://phpstan.org/user-guide/rule-levels). Le principe est de lancer l'analyse pour chaque niveau en commençant par le plus faible et en corrigeant les erreurs détectées entre chaque analyse.

[Liste des niveaux d'exigence :](https://phpstan.org/user-guide/rule-levels)

- **Niveau 0 :** basic checks, unknown classes, unknown functions, unknown methods called on \$this, wrong number of arguments passed to those methods and functions, always undefined variables
- **Niveau 1 :** possibly undefined variables, unknown magic methods and properties on classes with **call and **get
- **Niveau 2 :** unknown methods checked on all expressions (not just \$this), validating PHPDocs
- **Niveau 3 :** return types, types assigned to properties
- **Niveau 4 :** basic dead code checking - always false instanceof and other type checks, dead else branches, unreachable code after return; etc.
- **Niveau 5 :** checking types of arguments passed to methods and functions
- **Niveau 6 :** report missing typehints
- **Niveau 7 :** report partially wrong union types - if you call a method that only exists on some types in a union type, level 6 starts to report that; other possibly incorrect situations
- **Niveau 8 :** report calling methods and accessing properties on nullable types

Pour lancer une analyse :

```bash
phpstan analyse  \
    [--configuration NomFichierConfiguration.neon] \ # Alias -c. Sélectionne le fichier de configuration à utiliser
    [--level NuméroNiveauExigence] \ # Alias -l. Sélectionne le niveau d'exigence.
    [NomDossier1 NomDossier2 ...] # Sélectionne les dossiers à analyser.
```

Les paramètres `--level` et `NomDossier1 NomDossier2` peuvent être définis dans le fichier de configuration.

Si le paramètre `--configuration` est omis, la commande va chercher dans l'ordre les fichiers :

1. `phpstan.neon`
1. `phpstan.neon.dist`
1. Aucun fichier de configuration utilisé.

### Baseline

Il est possible d'ignorer des erreurs qu'on ne souhaite pas traiter en créant une `baseline` avec le paramètre `--generate-baseline` :

```
phpstan analyse --generate-baseline [NomFichier]
```

La commande va alors générer un fichier `.neon` décrivant les erreurs à ignorer (si le paramètre `NomFichier` est omis, le fichier se nommera `phpstan-baseline.neon`).

Ce fichier devra alors être défini dans le fichier de configuration de l'analyse :

```yaml
# Fichier de configuration de l'analyse, par défaut phpstan.neon
includes:
	- phpstan-baseline.neon

parameters:
	# ...
```

## Configuration

> [Documentation](https://phpstan.org/config-reference)

Un fichier de configuration doit utiliser le format neon, similaire au yaml.

- Préciser le niveau d'exigence :
  ```yaml
  parameters:
    level: 8
  ```
- Préciser les dossiers à analyser :
  ```yaml
  parameters:
    path:
      - src
      - tests
  ```
- Exclure certains fichiers de l'analyse :
  ```yaml
  parameters:
    excludes_analyse:
      - src/Migrations/*
  ```
- Combiner plusieurs fichiers de configuration avec le paramètre `include` :

  ```yaml
  includes:
  1
  - nomFichierConfigurationParent2
  - ...

  parameters:
      # ...
  ```

- PhpDoc :
  - Désactiver l'analyse stricte des types :
    ```yaml
    parameters:
      treatPhpDocTypesAsCertain: false
    ```
- Ignorer des erreurs :
  > Il est préférable d'utiliser une Baseline comme expliqué plus tôt.
  - Version basique :
    ```yaml
    parameters:
      ignoreErrors:
        - '#Call to an undefined method [a-zA-Z0-9\\_]+::doFoo\(\)#'
        - '#Call to an undefined method [a-zA-Z0-9\\_]+::doBar\(\)#'
    ```
  - Avec messages d'erreur et limité à certains fichiers :
    ```yaml
    parameters:
      ignoreErrors:
        - message: '#Call to an undefined method [a-zA-Z0-9\\_]+::doFoo\(\)#'
          path: some/dir/SomeFile.php
        - message: '#Call to an undefined method [a-zA-Z0-9\\_]+::doBar\(\)#'
          paths:
            - some/dir/*
            - other/dir/*
        - "#Other error to ignore everywhere#"
    ```

## Problèmes possibles

- `Class PHPUnit\Framework\TestCase not found and could not be autoloaded.`
  - Modifier le fichier de configuration :
    ```yaml
    parameters:
      autoload_directories:
        - bin/.phpunit/phpunit-8.3-0/src/Framework
    ```
- `Class PHPUnit\Exception not found and could not be autoloaded.`
  - Modifier le fichier de configuration :
    ```yaml
    parameters:
      autoload_files:
        - bin/.phpunit/phpunit-8.3-0/src/Exception.php
        - bin/.phpunit/phpunit-8.3-0/src/Framework/Exception/Exception.php
    ```

## Corriger les erreurs

- `Parameter #1 $argument of class ReflectionClass constructor expects class-string<T of object>|T of object, string given.`

  Se produit lorsqu'on utilise une chaîne de caractère pour instancier une classe.

  `class-string` correspond à une chaîne de caractère dont on a préalablement vérifié qu'elle correspond à un nom de classe.

  Pour qu'une `string` devienne une `class-string` :

  - Préciser `class-string` dans un phpdoc :
    ```php
    /**
    * @var class-string
    */
    ```
  - Utiliser `class_exists()` :
    ```php
    if (!class_exists($filterClass)) {
        throw new \InvalidArgumentException("$filterClass is not a valid class name.");
    }
    ```

- `Cannot call method nomMéthode() on nomNamespace\nomClasse|null.`
  - Vérifier que l'objet n'est pas nul avant d'appeler la méthode :
    ```php
    if (null !== $nomObjet) {
        $nomObjet->nomMéthode();
    }
    ```
  - Dans les tests, faire des `$this->assertNotNull($nomVariable);`

- Problème de type de retour :
  - Utiliser `@return mixed` dans la phpdoc.

- Il coince sur une méthode absente d'une interface alors que j'ai bien typehint la variable en commentaire :

  vérifier le type de la variable avant d'appeler la méthode :
  ```php
  /* @var MyAwesomeMessage $message */
  $message = $messageWrapper->getMessage();

  if (!$message instanceof MyAwesomeMessage) {
      return;
  }
  ```

## Ajouter des règles personnalisées

> - [Documentation](https://phpstan.org/developing-extensions/rules)
> - [Exemples](https://github.com/phpstan/phpstan-src/tree/master/src/Rules)

1. Créer une classe héritant de `PHPStan\Rules\Rule`
1. Spécifier cette classe dans le fichier de configuration :
   ```yaml
   services:
     - class: NomNamespace\NomNouvelleRègle
       tags:
         - phpstan.rules.rule
   ```
