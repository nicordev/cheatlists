# ApiPlatform

## Debug

```php
Symfony\Component\HttpKernel\HttpKernel::handleRaw
ApiPlatform\Core\EventListener\SerializeListener
Symfony\Component\Serializer\Serializer
```

## Généralités

* 2 contextes : sérialisation et désérialisation
    * Serialize:
        1. Normalize: PHP Object -> PHP Array
        2. Encode: PHP Array -> Format (JSON, XML)
    * Deserialize:
        1. Decode: Format (JSON, XML) -> PHP Array
        2. Denormalize: PHP Array -> PHP Object

## Installation

* `composer require api` Depuis un projet Symfony existant

## Fonctionnement

* Event dispatcher `Symfony\Component\EventDispatcher\EventDispatcher` :
    * Fichier `vendor/symfony/event-dispatcher/EventDispatcher.php`.
    * Les listeners sont appelés dans `EventDispatcher::doDispatch()` :
        * > @deprecated since Symfony 4.3, use callListeners() instead
        * Pour être réellement appelés par `WrappedListener::__invoke()` ici :
            ```php
            ($this->optimizedListener ?? $this->listener)($event, $eventName, $dispatcher);
            ```
## En-têtes

* Reqûetes
    * `Accept` `application/json` pour récupérer uniquement les données brutes (sans hypermédias)
    * `Accept` `application/ld+json` pour récupérer les données avec hypermédias (par défaut)

## Configuration via des annotations

* Généralités
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
* Pagination
    * [doc](https://api-platform.com/docs/core/pagination/)
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
* Ordre d'apparition des attributs des ressources
    * [doc](https://api-platform.com/docs/core/default-order/)
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
* Filtrer et ordonner
    * [doc](https://api-platform.com/docs/core/filters/)
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
    * Créer un filtre custom :
        * Uniquement pour les collections.
        * Créer une classe dans `src/Filter` qui implémente `ApiPlatform\Core\Api\FilterInterface` :
            ```php
            interface FilterInterface
            {
                /**
                * Gets the description of this filter for the given resource.
                *
                * Returns an array with the filter parameter names as keys and array with the following data as values:
                *   - property: the property where the filter is applied
                *   - type: the type of the filter
                *   - required: if this filter is required
                *   - strategy (optional): the used strategy
                *   - is_collection (optional): is this filter is collection
                *   - swagger (optional): additional parameters for the path operation,
                *     e.g. 'swagger' => [
                *       'description' => 'My Description',
                *       'name' => 'My Name',
                *       'type' => 'integer',
                *     ]
                *   - openapi (optional): additional parameters for the path operation in the version 3 spec,
                *     e.g. 'openapi' => [
                *       'description' => 'My Description',
                *       'name' => 'My Name',
                *       'schema' => [
                *          'type' => 'integer',
                *       ]
                *     ]
                * The description can contain additional data specific to a filter.
                *
                * @see \ApiPlatform\Core\Swagger\Serializer\DocumentationNormalizer::getFiltersParameters
                */
                public function getDescription(string $resourceClass): array;
            }
            ```
        * On peut aussi accéder aux paramètres de la requête en héritant de `SearchFilter` et en surchargeant la méthode `apply` :
            ```php

            public function apply(QueryBuilder $queryBuilder, QueryNameGeneratorInterface $queryNameGenerator, string $resourceClass, string $operationName = null, array $context = [])
            {
                $propertiesToLookFor = $context['filters'];
                parent::apply($queryBuilder, $queryNameGenerator, $resourceClass, $operationName, $context);
            }
            ```
* Groupes de sérialisation
    * [doc](https://api-platform.com/docs/core/serialization/)
    * [doc composant serializer de Symfony](https://symfony.com/doc/current/components/serializer.html)
    * Normalisation :
        * Groupes de sérialisation :
            > Il est conseillé de mettre tous les attributs d'une entité dans un groupe pour pouvoir facilement choisir lesquels afficher par la suite.
            ```php
            // ...

            use ApiPlatform\Core\Annotation\ApiResource;
            use Symfony\Component\Serializer\Annotation\Groups;

            /**
            * // ...
            * @ApiResource(
            *     normalizationContext={
            *          "groups"={"customers_read"}
            *     }
            * )
            */
            class Customer
            {
                /**
                * // ...
                * @Groups(
                *     {"customers_read", "invoices_read"}
                * ) // Ici l'id apparaîtra dans le cadre de la normalisation des Customer et des Invoice.
                */
                private $id;
                // ..

                /**
                * Get the sum of the customer's invoices
                *
                * @Groups({"customers_read"}) // La méthode sera appelée pendant la normalisation. On parle de champs calculé.
                * @return float
                */
                public function getTotalAmount(): float // Le résultat de cette méthode apparaîtra dans un attribut JSON "getTotalAmount"
                {
                    return array_reduce($this->invoices->toArray(), function ($total, $invoice) {
                        return $total + $invoice->getAmount();
                    }, 0);
                }
            }
            ```
    * Dénormalisation :
        * Désactiver la vérification du types des données en entrée :
            ```php
            // ...

            use ApiPlatform\Core\Annotation\ApiResource;

            /**
            * // ...
            * @ApiResource(
            *     denormalizationContext={
            *          "disable_type_enforcement"=true // Désactive la vérification du types des données en entrée
            *     }
            * )
            */
            class Invoice
            {
                // ...


                public function setAmount($amount): self // On ne spécifie pas de type pour l'attribut $amount
                {
                    $this->amount = $amount;

                    return $this;
                }
            }
            ```
* Opérations
    * [doc](https://api-platform.com/docs/core/operations/)
    * 2 types d'opération : 
        * les *Collection operations* dont l'url ne recquiert pas d'identifiant (`/customers`) :
            * GET (obtenir la liste)
            * POST (ajouter à la liste)
        * les *Item operations* dont l'url requiert un identifiant (`/customers/{id}`) :
            * GET (obtenir un élément)
            * PUT (remplacer)
            * PATCH (mettre à jour un élément)
            * DELETE (supprimer un élément)
    * Autoriser certaines opérations :
        > L'ordre d'écriture des opérations dans le docblock est celui utilisé pour l'affichage dans la doc swagger sur /api
        ```php
        /**
        * @ORM\Entity(repositoryClass="App\Repository\CustomerRepository")
        * @ApiResource(
        *     collectionOperations={"GET", "POST"},
        *     itemOperations={"GET", "DELETE", "PUT", "PATCH"}
        * )
        */
        class Customer 
        {
            // ...
        }
        ```
    * Modifier l'url pour certaines opérations :
        > Ici on veut /clients plutôt que /customers
        ```php
        /**
        * @ORM\Entity(repositoryClass="App\Repository\CustomerRepository")
        * @ApiResource(
        *     collectionOperations={"GET"={"path"="/clients"}, "POST"},
        *     itemOperations={"GET"={"path"="/clients/{id}"}, "DELETE", "PUT", "PATCH"}
        * )
        */
        class Customer 
        {
            // ...
        }
        ```
    * Créer ses propres opérations et modifier la doc
        1. Créer un contrôleur chargé de l'opération :
            ```php
            namespace App\Controller;

            use App\Entity\Invoice;
            use App\Repository\InvoiceRepository;

            class InvoiceIncrementationController
            {
                /**
                * @var InvoiceRepository
                */
                private $invoiceRepository;

                public function __construct(InvoiceRepository $invoiceRepository)
                {
                    $this->invoiceRepository = $invoiceRepository;
                }

                public function __invoke(Invoice $data) // Méthode appelée par notre opération maison. Le paramètre doit être nommé data.
                {
                    $this->invoiceRepository->incrementAmount($data);

                    return $data;
                }
            }
            ```
        2. Modifier l'annotation `@ApiResource` en ajoutant l'opération maison (ici *increment*) :
            ```php
            /**
            * @ApiResource(
            *     itemOperations={
            *          "GET", "PUT", "DELETE", "PATCH", "increment"={
            *              "method"="post",
            *              "path"="/invoices/{id}/increment",
            *              "controller"="App\Controller\InvoiceIncrementationController",
            *              "openapi_context"={
            *                  "summary"="Increment the amount of an invoice.",
            *                  "description"="Increment the amount of an invoice. It's just to show how to make custom operations."
            *              }
            *          }
            *     }
            * )
            */
            class Invoice
            {
                // ...
            }
            ```
* Sous-ressources
    * [doc](https://api-platform.com/docs/core/subresources/#subresources)
    * Accessible via une url de type `/nomEntitésPrincipales/{id}/nomSousRessources` en ajoutant l'annotation `@ApiSubresource()` à un attribut :
        ```php
        // ...

        class Customer 
        {
            // ...
            /**
            * ...
            * @ApiSubresource()
            */
            private $invoices;
        }
        ```
    * Configurable au niveau de l'annotation `@ApiSubresource()` de la classe :
        * Au niveau de la classe principale pour des paramètres comme l'uri :
            ```php
            // ...

            /**
            * // ...
            * @ApiResource(
            *     subresourceOperations={
            *          "invoices_get_subresource"={"path"="/clients/{id}/factures"}
            *     }
            * )
            */
            class Customer 
            {
                // ...
                /**
                * ...
                * @ApiSubresource()
                */
                private $invoices;
            }
            ```
        * Au niveau de la sous-ressource pour les groupes de normalisation :
            ```php
            // ...

            /**
            * // ...
            * @ApiResource(
            *     subresourceOperations={
            *          "api_customers_invoices_get_subresource"={
            *              "normalization_context"={
            *                  "groups"={"invoices_subresource"}
            *              }
            *          }
            *     }
            * )
            */
            class Invoice
            {
                // ...
                /**
                * ...
                * @ApiSubresource()
                */
                private $invoices;
            }
            ```
* Validation
    * Comme pour un projet Symfony classique avec les annotations `@Assert\` : [doc](https://symfony.com/doc/current/reference/constraints.html).

## Authentification

* JWT avec le [LexikJWTAuthenticationBundle](https://github.com/lexik/LexikJWTAuthenticationBundle/blob/master/Resources/doc/index.md#getting-started) : [doc](https://api-platform.com/docs/core/jwt/#jwt-authentication) :
    1. `composer require jwt-auth` installe le bundle.
    1. ```bash
        mkdir -p config/jwt
        openssl genpkey -out config/jwt/private.pem -aes256 -algorithm rsa -pkeyopt rsa_keygen_bits:4096
        openssl pkey -in config/jwt/private.pem -out config/jwt/public.pem -pubout
        ```
    1. Renseigner la passphrase soit :
        - Dans `config/packages/lexik_jwt_authentication.yaml` :
            ```yaml
            lexik_jwt_authentication:
                secret_key:       '%kernel.project_dir%/config/jwt/private.pem' # required for token creation
                public_key:       '%kernel.project_dir%/config/jwt/public.pem'  # required for token verification
                pass_phrase:      'your_secret_passphrase' # required for token creation, usage of an environment variable is recommended
                token_ttl:        3600
            ```
        - Dans `.env.local` (recopier la partie concernant le JWT) :
            ```bash
            ###> lexik/jwt-authentication-bundle ###
            JWT_SECRET_KEY=%kernel.project_dir%/config/jwt/private.pem
            JWT_PUBLIC_KEY=%kernel.project_dir%/config/jwt/public.pem
            JWT_PASSPHRASE=jAimeLesJwtCEstPratique
            ###< lexik/jwt-authentication-bundle ###
            ```
    1. Dans `config/packages/security.yaml` :
        ```yaml
        security:
            firewalls:
                dev:
                    pattern: ^/(_(profiler|wdt)|css|images|js)/
                    security: false
                # Firewall utilisé lors de la création d'un utilisateur
                registration:
                    pattern: ^/api/users
                    anonymous: true
                    stateless: true
                    methods: [POST]
                # Firewall utilisé pour obtenir un JWT
                login:
                    pattern:  ^/api/login
                    stateless: true
                    anonymous: true
                    json_login:
                        check_path:               /api/login_check
                        success_handler:          lexik_jwt_authentication.handler.authentication_success
                        failure_handler:          lexik_jwt_authentication.handler.authentication_failure
                # Firewall pour protéger notre API
                api:
                    pattern:   ^/api
                    stateless: true
                    anonymous: true # Mettre à false si on veut tout bloquer, mais mieux vaut utiliser l'access_control plus bas
                    guard:
                        authenticators:
                            - lexik_jwt_authentication.jwt_token_authenticator
                main:
                    anonymous: lazy

                access_control:
                    - { path: ^/api/login, roles: IS_AUTHENTICATED_ANONYMOUSLY }
                    - { path: ^/api/customers, roles: IS_AUTHENTICATED_FULLY }
                    - { path: ^/api/invoices, roles: IS_AUTHENTICATED_FULLY }
                    - { path: ^/api/users, roles: IS_AUTHENTICATED_FULLY, methods: [GET, PUT, DELETE] }
        ```
    1. Dans `config/routes.yaml` :
        ```yaml
        api_login_check:
            path: /api/login_check
        ```

## Data Persisters, Events, Doctrine requests

* Agir sur les entités pendant les opérations POST, PUT, PATCH ou DELETE avec les **Data Persisters**
    * [doc](https://api-platform.com/docs/core/data-persisters/)
* Utiliser les événements
    * [doc](https://api-platform.com/docs/core/events/#the-event-system)
* Modifier les requêtes Doctrine :
    * [doc](https://api-platform.com/docs/core/extensions/)
    * Pour les collections : Faire une classe qui implémente `ApiPlatform\Core\Bridge\Doctrine\Orm\Extension\QueryCollectionExtensionInterface`.
    * Pour les items : Faire une classe qui implémente `ApiPlatform\Core\Bridge\Doctrine\Orm\Extension\QueryItemExtensionInterface`.
    * Si pas d'autoconfiguration, modifier le fichier `/api/config/services.yaml` :
        ```yaml
        services:

            # ...

            'App\Doctrine\CurrentUserExtension':
                tags:
                    - { name: api_platform.doctrine.orm.query_extension.collection }
                    - { name: api_platform.doctrine.orm.query_extension.item }
        ```

## Configuration via des fichiers .yaml

* Limiter la profondeur de sérialization à 1 :
    * Fichier `/config/packages/api_platform/Company.yaml`:
        ```yaml
        resources:
            App\Entity\Company:
                attributes:
                    normalization_context:
                        enable_max_depth: true
        ```
    * Entité `App\Entity\Company`:
        ```php
        use Symfony\Component\Serializer\Annotation\MaxDepth;

        class Company
        {
            /**
            * @MaxDepth(1)
            */
            private $grantedCompanies;
        }
        ```
- Activer des filtres
    - *config/ackages/api_platform*, créer un fichier par ressource :
        ```yaml
        resources:
            App\Entity\NomEntité:
                attributes:
                    filters:
                        - nom_entité.nom_filtre
        ```
    - *config/services.yaml* :
        ```yaml
        services:
            nom_entité.nom_filtre:
                parent: 'api_platform.doctrine.orm.search_filter'
                arguments: [{ nomPropriété: 'nomStratégie' }]
                tags: ['api_platform.filter']
                autowire: false
                autoconfigure: false
                public: false
        ```

## Documentation OpenApi

[doc](https://api-platform.com/docs/core/swagger/)
