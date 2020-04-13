# GitLab CI/CD

[Documentation](https://docs.gitlab.com/ee/ci/introduction/index.html)

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