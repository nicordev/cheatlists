# Infection

> [Documentation](https://infection.github.io/guide/index.html#Covered-Code-Mutation-Score-Indicator)

> [Théorie](http://crestweb.cs.ucl.ac.uk/resources/mutation_testing_repository/theory.php)

## Conseils

- Cibler un fichier à la fois pour éviter d'avoir un fichier de log trop long.

## Problèmes

- Un test coince alors que je ciblais un fichier qui n'a rien à voir :

    La valeur du paramètre filter est peut-être mal écrite. On doit écrire un nom de fichier avec son extension.

## Installation

```bash
wget https://github.com/infection/infection/releases/download/0.16.0/infection.phar
wget https://github.com/infection/infection/releases/download/0.16.0/infection.phar.asc
chmod +x infection.phar # pour le fun
```

## Utilisation

## En local

Utiliser tous les threads disponibles :

```sh
php ./infection.phar --threads=$(nproc)
```
    
Se focaliser uniquement sur les fichiers testés :

```sh
php ./infection.phar --only-covered
```

Utiliser un rapport de coverage existant :

> Pratique pour utiliser `--filter`

1. Préparer un rapport de coverage en amont :

    ```sh
    php bin/phpunit --coverage-xml='nomDossierCoverage/coverage-xml' --log-junit='nomDossierCoverage/junit.xml'
    ```

1. Lancer infection avec `--coverage`

    ```sh
    php ./infection.phar --coverage='nomDossierCoverage/'
    ```

Cibler des fichiers source spécifiques :

- > *La suite de tests complète sera lancée en amont pour générer le coverage.*

    ```sh
    php ./infection.phar --filter=NomFichier1.php,NomFichier2.php
    ```

- Utilisation avec un rapport de coverage existant :

    ```sh
    php ./infection.phar --coverage='nomDossierCoverage/' --filter=NomFichier1.php,NomFichier2.php
    ```

Lire les résultats dans le fichier `infection.log`

### Dans la CI

> [Documentation](https://infection.github.io/guide/using-with-ci.html)

Appliquer un seuil minimum :
- Pour le MSI :

    ```sh
    php ./infection.phar --min-msi=nombreEntierEntre0Et100
    ```

- Pour le Covered Code MSI :
    ```sh
    php ./infection.phar --min-msi=nombreEntierEntre0Et100
    ```

## Indicateurs

- Mutation Score Indicator (MSI) :

    ```js
    TotalDefeatedMutants = KilledCount + TimedOutCount + ErrorCount;
    MSI = (TotalDefeatedMutants / TotalMutantsCount) * 100;
    ```

- Mutation Code Coverage (MCC) :

    Indique la proportion de mutants couverts par les tests par rapport à ceux qui ne le sont pas.

    Doit être du même ordre de grandeur que le code coverage classique.

    ```js
    TotalCoveredByTestsMutants = TotalMutantsCount - NotCoveredByTestsCount;
    CoveredRate = (TotalCoveredByTestsMutants / TotalMutantsCount) * 100;
    ```

- Covered Code Mutation Score Indicator :

    MSI uniquement pour le code couvert par des tests.

    ```js
    TotalCoveredByTestsMutants = TotalMutantsCount - NotCoveredByTestsCount;
    TotalDefeatedMutants = KilledCount + TimedOutCount + ErrorCount;

    CoveredCodeMSI = (TotalDefeatedMutants / TotalCoveredByTestsMutants) * 100;
    ```
