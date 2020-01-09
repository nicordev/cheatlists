# ApiPlatform

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

## En-têtes

* Reqûetes
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

### Ordre d'apparition des attributs des ressources

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

### Groupes de sérialisation

* Normalisation :
    > Il est conseillé de mettre tous les attributs d'une entité dans un groupe pour pouvoir facilement choisir lesquels afficher par la suite.
    ```php
    <?php

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

### Opérations

> [doc](https://api-platform.com/docs/core/operations/)

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
        <?php

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


### Sous-ressources

> [doc](https://api-platform.com/docs/core/subresources/#subresources)

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
