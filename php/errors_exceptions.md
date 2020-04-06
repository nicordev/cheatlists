# Error, warning, notice et exceptions

* Taire les erreurs :
    * `@nomFonction();` le `@` va taire toutes les erreurs (et warnings et notices) que la fonction peut lever.
    * [doc](https://www.php.net/manual/fr/language.operators.errorcontrol.php)
* Attraper et lancer une exception maison :
    * Dans le code :
        ```php
        try {
            // Du code pouvant générer des erreurs ou exceptions.
        } catch (Exception $exception) {
            // Du code exécuté en cas d'exception. Ici on relance une exception custom qui contient l'exception attrapée
            throw new NomExceptionCustom('Game over.', 1987, $exception);
        } finally {
            // Du code qui sera exécuté quoiqu'il arrive.
        }
        ```
    * Classe `NomExceptionCustom` d'un projet Symfony par exemple :
        ```php
        namespace App\Exception;

        class NomExceptionCustom extends \Exception {}
        ```