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

## Utilisation

> Rappel : si vous utilisez composer, remplacer `phpstan` par `vendor/bin/phpstan`.

### Analyse

PHPStan utilise [9 niveaux d'exigence](https://phpstan.org/user-guide/rule-levels). Le principe est de lancer l'analyse pour chaque niveau en commençant par le plus faible et en corrigeant les erreurs détectées entre chaque analyse.

[Liste des niveaux d'exigence :](https://phpstan.org/user-guide/rule-levels)
- **Niveau 0 :** basic checks, unknown classes, unknown functions, unknown methods called on $this, wrong number of arguments passed to those methods and functions, always undefined variables
- **Niveau 1 :** possibly undefined variables, unknown magic methods and properties on classes with __call and __get
- **Niveau 2 :** unknown methods checked on all expressions (not just $this), validating PHPDocs
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

Il est possible d'ignorer des erreurs en créant une `baseline` avec le paramètre `--generate-baseline` :
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

On peut combiner plusieurs fichiers de configuration avec le paramètre `include`.