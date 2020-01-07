# ApiPlatform

## Installation

* `composer require api` Depuis un projet Symfony existant

## En-têtes

* `Accept` `application/json` pour récupérer uniquement les données brutes (sans hypermédias)
* `Accept` `application/ld+json` pour récupérer les données avec hypermédias (par défaut)

## Configuration

* 3 niveaux de configuration :
    1. Le fichier de configuration api_platform.yaml donne des configurations pour toutes nos ressources
    1. L'annotation @ApiResource() permet de configurer au cas par cas nos ressources
    1. Les paramètres qu'on passe à une requête HTTP peuvent encore préciser certaines choses 
* La configuration générale se situe dans le fichier `/config/packages/api_platform.yaml`.
* L'annotation `@ApiResource()` permet de modifier la configuration au cas par cas. Les paramètres à modifier deviennent une suite de termes reliés par des `_` en guise de clé :
    > ```
    > /**
    >  * @ApiResource(
    >  *     attributes={
    >  *          "pagination_enabled"=true
    >  *     }
    >  * )
    >  */
    > ```
    > va modifier le paramètre `pagination: enabled: true` du fichier de configuration

### Pagination

[https://api-platform.com/docs/core/pagination/](https://api-platform.com/docs/core/pagination/)

* Pagination automatique par défaut. Renvoie 30 items par page par défaut.
* Configuration via `/config/packages/api_platform.yaml` :
    ```yaml
    api_platform:
        # ...
        collection:
            pagination:
                enabled: false # Désactive la pagination pour toutes les ressources
                items_per_page: 17 # Indique combien d'items par page
                client_enabled: true # Permet aux clients de l'API d'activer ou de désactiver la pagination via un paramètre dans l'URL (par défaut ?pagination=true)
                client_items_per_page: true # Permet aux clients de l'API de modifier le nombre d'items par page via un paramètre dans l'URL (par défaut ?itemsPerPage=10)
    ```

### Ordre d'apparition des attributes des ressources

* [https://api-platform.com/docs/core/default-order/](https://api-platform.com/docs/core/default-order/)
* Exemple :
    ```php
    /**
    * @ApiResource(
    *     attributes={
    *          "order": {"sentAt": "desc"}
    *     }
    * )
    */
    ```

### Filtrer et ordonner

* [https://api-platform.com/docs/core/filters/](https://api-platform.com/docs/core/filters/)
* L'annotation `@ApiFilter` permet de filtrer ou d'ordonner :
    * `SearchFilter` avec 3 attributs et 2 stratégies de filtrage (utilisable avec le paramètre `?nomAttribut=valeurCible`) :
        ```php
        /**
        * @ApiFilter(
        *     SearchFilter::class,
        *     properties={"firstName": "start", "lastName": "partial", "company", "user.firstName": "exact"}
        * )
        */
        ```
    * `OrderFilter` avec ou sans l'attribut `properties` (utilisable avec le paramètre `?order[nomAttribut]=desc` ou `asc`) :
        ```php
        /**
        * @ApiFilter(
        *     OrderFilter::class,
        *     properties={"amount", "sentAt"}
        * )
        */
        ```

