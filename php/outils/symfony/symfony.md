# Symfony

## Installation

* [Download](https://symfony.com/download)
* `wget https://get.symfony.com/cli/installer -O - | bash` installe Symfony sous Linux.

## Nouveau projet

* `composer create-project symfony/website-skeleton my_project_name` créé un projet complet via composer
* `composer create-project symfony/skeleton my_project_name` créé un projet minimal via composer
* `symfony new nameOfTheProjectHere --full` créé un projet complet avec l'exécutable Symfony
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

* Dans un controller héritant de AbstractController
    * `$this->getUser()`
* Via un objet Security
    * `$security->getUser()`
* Via un objet implémentant TokenInterface
    * `$token->getUser()`

## Evénements lancés par le kernel

1. kernel.request
1. kernel.controller
1. kernel.controller_arguments
1. kernel.view
1. kernel.response
1. kernel.finish_request
1. kernel.terminate
1. kernel.exception