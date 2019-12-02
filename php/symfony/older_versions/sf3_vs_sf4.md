## Différences Symfony 3 et 4

* Choix de l'environnement prod ou dev
    * sf4 : remplir `APP_ENV=prod ou dev` dans le fichier `.env.local`
    * sf3 : ajouter à l'URL `/app.php` pour le mode prod ou `/app_dev.php` pour le mode dev
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