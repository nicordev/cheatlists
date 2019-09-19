## Symfony

### Problèmes

* Faire un `dd($maVariable)` pour débugger (dump and die)
* 404 alors que les routes sont bien annotées sur un serveur Apache
    * Installer le `symfony/apache-pack`
* Erreur en prod et pas en dev
    * Vider le cache
    * Changer `$kernel = new Kernel($_SERVER['APP_ENV'], (bool) $_SERVER['APP_DEBUG']);` en `$kernel = new Kernel($_SERVER['APP_ENV'], true);` dans `index.php` pour identifier l'erreur

### CLI

* `php bin/console debug:router` afficher toutes les routes
* `php bin/console debug:autowiring` afficher tous les services disponibles
* `php bin/console debug:event-dispatcher nomEvenement` avec `nomEvenement` en option (exemple : `kernel.controller`), afficher tous les listeners avec leur priorité

### Récupérer un utilisateur

* Dans un controller héritant de AbstractController
    * `$this->getUser()`
* Via un objet Security
    * `$security->getUser()`
* Via un objet implémentant TokenInterface
    * `$token->getUser()`

### Créer un système de connexion

Merci la CLI !
`php bin/console make:auth`
`php bin/console make:user`
`php bin/console make:voter`

### Configurer son serveur

[Documentation](https://symfony.com/doc/current/setup/web_server_configuration.html)

Le dossier `public/` est la racine. Le virtual host doit donc pointer vers ce dossier.

#### Apache

Installer *symfony/apache-pack* en exécutant `composer require symfony/apache-pack`
>Installe au passage un `.htaccess` dans le dossier `public\`

### Utiliser Webpack Encore

[Documentation](https://symfony.com/doc/current/frontend.html)

Prérequis :
* Installer [yarn](https://yarnpkg.com/fr/)

#### Installation

Exécuter `composer require encore` puis `yarn install`

#### Utilisation

Exécuter `yarn encore dev` pour compiler les *assets* (fichiers situés dans le dossier `assets/` situé à la racine du projet).

Exécuter `yarn encore dev --watch` pour recompiler automatiquement les fichiers si on fait des modifications.

#### Configuration

Voir dans le fichier `webpack.config.js` situé à la racine du projet.
>Si vous avez exécuté `yarn encore dev --watch` alors il faudra l'arrêter et le relancer après vos modifications.

### Modifier PHP

* Dans `bin/console` : 
```
// On modifie des parties de php.ini
ini_set('date.timezone', 'UTC');
ini_set('display_errors', (int) $debug);
ini_set('memory_limit', -1);

if ($debug) {
    Debug::enable(E_ERROR); // On change la sensibilité des erreurs, warnings...
}
```

### Tests fonctionnels avec phpunit

#### Installation

* Exécuter `composer require --dev symfony/phpunit-bridge`

#### Utilisation

* Pour lancer tous les tests, exécuter `./bin/phpunit` dans le dossier du projet
* Pour lancer que certains tests, exécuter `./bin/phpunit --filter nomDesMethodesTestsAExecuter` (exécutera uniquement les méthodes de test dont le nom est `nomDesMethodesTestsAExecuter`)
* On peut visualiser la page demandée par un test en faisant un `echo $client->getResponse()->getContent();` dans la méthode de test et en redirigeant la sortie vers un fichier `.html` en exécutant `./bin/phpunit --filter nomMethodeTest > nomFichierDestination.html`
* On peut récupérer un rapport du coverage avec `./bin/phpunit --coverage-html nomDossierDestination`

#### Ajouter des headers perso dans la requête

Préfixer l'intitulé du header par `HTTP_`

```
    $this->client->request(
        'GET',
        "/products/{$this->testProduct->getId()}",
        [],
        [],
        [
            "HTTP_X-AUTH-TOKEN" => "test_token"
        ]
    );
```

## Utiliser le serveur de développement

* Lancer le serveur avec la commande `symfony server:start`
    * On peut ajouter `-d` pour faire tourner le serveur en arrière plan
* Activer https avec la commande `symfony server:ca:install`
* Voir les logs avec la commande `symfony server:log`
* Utiliser une version particulière de php en créant un fichier `.phpversion` contenant le numéro de version
    * `echo "7.2" > .php-version`
* Créer un fichier `php.ini` personnalisé à la racine du projet pour modifier la configuration de php du serveur

## Différences Symfony 3 et 4

* Choix de l'environnement prod ou dev
    * sf4 : remplir `APP_ENV=prod ou dev` dans le fichier `.env.local`
    * sf3 : modifier la ligne `$kernel = new AppKernel('prod ou dev', false);` dans `web/app.php`
* Aborescence
    * sf4 :
        * `config/`     contient les fichiers de configuration
        * `src/`        contient les services, controleurs, entités, repository...
        * `public/`     contient `index.php`, `css/`, `js/`
        * `templates/`  contient les fichiers twig
    * sf3 : 
        * `app/`    contient :
            * les fichiers de configuration dans `app/config/`
            * les ficheirs twig dans `app/Resources/views/`
        * `src/`    contient le dossier `AppBundle` contenant les controleurs, entités, repository...
        * `web/`    contient `index.php`, `css/`, `js/`