# CLI

## debug

* `php bin/console debug:router` afficher toutes les routes
* `php bin/console debug:container --show-private` afficher tous les services disponibles dans le conteneur de services
* `php bin/console debug:autowiring` afficher tous les services disponibles avec autowiring
* `php bin/console debug:event-dispatcher nomEvenement` avec `nomEvenement` en option (exemple : `kernel.controller`), afficher tous les listeners avec leur priorité

## make

* Créer des entités
    * `php bin/console make:entity`
* Générer un fichier de migration
    * **Important** exécuter d'abord `php bin/console doctrine:cache:clear-metadata`
    * `php bin/console make:migration` créé le fichier de migration
    * `php bin/console doctrine:migrations:migrate` exécute les migrations
* Créer un système de connexion
    * `php bin/console make:auth`
    * `php bin/console make:user`
    * `php bin/console make:voter`

## doctrine

* Charger des fixtures
    * *Nécessite le package composer `orm-fixtures`*
    * `php bin/console doctrine:fixtures:load` charge les fixtures
        * `php bin/console doctrine:fixtures:load --no-interaction` charge les fixtures sans poser de questions