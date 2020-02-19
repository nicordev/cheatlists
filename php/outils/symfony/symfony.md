# Symfony

## Installation

* [Download](https://symfony.com/download)
* `wget https://get.symfony.com/cli/installer -O - | bash` installe Symfony sous Linux.

## MakerBundle

* [doc](https://symfony.com/doc/current/bundles/SymfonyMakerBundle/index.html)
* `php bin/console list make` affiche les commandes possibles.

## Nouveau projet

* `composer create-project symfony/website-skeleton my_project_name` créé un projet complet via composer
* `composer create-project symfony/skeleton my_project_name` créé un projet minimal via composer
* `symfony new nameOfTheProjectHere --full` créé un projet complet avec l'exécutable Symfony
* `symfony new my_project_name --version=lts` sélectionne une version en particulier
* `symfony new nameOfTheProjectHere` créé un projet minimal avec l'exécutable Symfony

## Problèmes

* Faire un `dd($maVariable)` pour débugger (dump and die)
* 404 alors que les routes sont bien annotées sur un serveur Apache
    * Installer le `symfony/apache-pack`
* Erreur en prod et pas en dev
    * Vider le cache
    * Changer `$kernel = new Kernel($_SERVER['APP_ENV'], (bool) $_SERVER['APP_DEBUG']);` en `$kernel = new Kernel($_SERVER['APP_ENV'], true);` dans `index.php` pour identifier l'erreur
* On peut voir le moment où :
    * des infos sont stockés dans la session dans `Symfony\Component\HttpFoundation\Session\Attribute\AttributeBag::set()`
    * les classes sont chargées dans `Symfony\Component\ClassLoader\ClassLoader::loadClass()`

## Accéder à la requête

> [doc](https://symfony.com/doc/current/service_container/request.html)

Injecter `Symfony\Component\HttpFoundation\RequestStack $requestStack` et faire :
```php
$request = $this->requestStack->getCurrentRequest();
```

## Validation des données

* [doc](https://symfony.com/doc/current/reference/constraints.html)
* Utilisation
    ```php
    use Symfony\Component\Validator\Constraints as Assert;

    class MyAwesomeEntity
    {
        /**
         * @Assert\NomContrainte(paramètres)
         */
        private $myAwesomeProperty;
    }
    ```
* Quelques annotations
    * `@Assert\NotBlank` oblige à renseigner cette attribut.
        * Exemple : `@Assert\NotBlank(message="The customer's first name is mandatory.")`
    * `@Assert\Length` nécessite un nombre de caractère spécifique.
        * Exemple : `@Assert\Length(min=3, max=255, minMessage="Must be greater than 2", maxMessage="Must be lower than 256")`
    * `@Assert\Type` nécessite un type spécifique.
        * Exemple : `@Assert\Type(type="numeric", message="Must be numeric.")`
    * `@Assert\DateTime` nécessite un objet DateTime.
    * `@Assert\Choice` restreint les valeurs à une liste définie.
        * Exemples : 
            * `@Assert\Choice(choices={"Apple", "Banana", "Raspberry"}, message="Choose a valid choice from the list.")` où on définit la liste de choix directement dans l'annotation.
            * `@Assert\Choice(choices=FruitBasket::FRUITS)` où on utilise une constante contenant un tableau PHP.
            * `@Assert\Choice(callback={"App\Entity\FruitBasket", "getFruits"})` où on utilise une méthode pour obtenir la liste de choix.
                * `@Assert\Choice(callback="getFruits")` si la méthode requise est présente dans l'entité.
    * `@UniqueEntity` empêche que 2 entités soient identiques. [doc](https://symfony.com/doc/current/reference/constraints.html)
    

## Injecter des paramètres manuellement via la config et le fichier .env

* https://symfony.com/doc/current/service_container.html#manually-wiring-arguments
* https://symfony.com/doc/current/configuration.html#configuration-based-on-environment-variables 

Exemple sur le projet 7 de la formation OpenClassrooms :

*Fichier `services.yaml`*
```
App\EventListener\HttpCacheListener:
        arguments:
            $cacheExpiration: '%env(CACHE_EXPIRATION)%'
```
*Fichier `.env`*
```
CACHE_EXPIRATION='+10 minutes'
```

## Récupérer un utilisateur

* Dans un controller héritant de `AbstractController`
    * `$this->getUser()`
* Via un objet `Symfony\Component\Security\Core\Security`
    * `$security->getUser()`
* Via un objet implémentant `TokenInterface`
    * `$token->getUser()`

## Evénements lancés par le kernel

> [doc](https://symfony.com/doc/current/reference/events.html#kernel-events)

1. kernel.request
1. kernel.controller
1. kernel.controller_arguments
1. kernel.view
1. kernel.response
1. kernel.finish_request
1. kernel.terminate
1. kernel.exception