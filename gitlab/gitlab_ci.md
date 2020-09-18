# GitLab CI/CD

[Documentation](https://docs.gitlab.com/ee/ci/introduction/index.html)

[Variables d'environnements prédéfinies](https://docs.gitlab.com/12.10/ee/ci/variables/predefined_variables.html#variables-reference)

## Utilisation

1. Créer un repository dans GitLab.
1. Créer un fichier `.gitlab-ci.yml` à la racine du projet contenant les commandes à exécuter.
    
    > [Documentation](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_four.html)

    GitLab va détecter ce fichier et lancer GitLab Runner pour exécuter les commandes.

    Exemple de fichier `.gitlab-ci.yml` :
    ```yaml
    before_script:
        - echo 'Hello world!'
        
        run-zog:
            script:
                - echo 'zogzog'
    ```

### Exemples de fichier `.gitlab-ci.yml`

* Pour lancer phpstan :
    ```yaml
    phpstan:
        tags: # Ce tag permet d'affecter un runner. C'est parfois nécessaire.
            - docker
        image: jakzal/phpqa
        stage: tests # Par défaut le stage est test au singulier.
        script: phpstan analyse --level 8 src tests
        allow_failure: true # Optionel : pour que ce job ne soit pas bloquant
    ```

## Jobs

Ignorer un job :

Préfixer le nom du job par un point :

```yaml
.hidden_job:
  script:
    - run test
```

## Paramètres globaux

Les clés `default` et `variables` contiennent les paramètres communs à tous les jobs.

On peut filtrer les clés communes avec `inherit` :

```yaml
default:
  clé1: valeur1
  clé2: valeur2
  clé3: valeur3

variables:
  NOM_VARIABLE1: valeur1
  NOM_VARIABLE2: valeur2
  NOM_VARIABLE3: valeur3

nom_job1:
  inherit:
    default: true # Utilise les clés de default
    variables: false # Ignore les clés de variables

nom_job2:
  inherit:
    default: [clé1, clé2] # Utilise uniquement clé1 et clé2
    variables: [NOM_VARIABLE1, NOM_VARIABLE2] # Utilise uniquement NOM_VARIABLE1 et NOM_VARIABLE2
  clé: valeur
```

## Héritage

> Privilégier `include` et `extends`.

- `include` :

    Insère le contenu d'un fichier yaml dans un autre.

    `local` : indique que le fichier se trouve dans le projet. Le chemin est absolu.

    ```yaml
    include:
      - local: '/cheminVers/nomFichier.yml'
    ```

- `extends` :

    Récupère les clés d'un job pour les placer dans un autre.

    ```yaml
    nom_job1:
        clé1: valeur1
        clé2: valeur2
        clé3: valeur3

    nom_job2:
        extends: nom_job1
        clé2: autre_valeur # Ecrase clé2 de nom_job1
    ```

- Ancres YAML :

    - Valable dans un unique fichier.
    - On peut écraser les clés d'une ancre.

    ```yaml
    .job_template: &job_definition
        script:
            - test project
        tags:
            - dev

    .postgres_services:
        services: &postgres_definition
            - postgres
            - ruby

    .mysql_services:
        services: &mysql_definition
            - mysql
            - ruby

    test:postgres:
        <<: *job_definition
        services: *postgres_definition
        tags:
            - postgres

    test:mysql:
        <<: *job_definition
        services: *mysql_definition
    ```
