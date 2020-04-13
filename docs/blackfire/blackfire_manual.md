# Blackfire

[Installation](https://blackfire.io/docs/up-and-running/installation)

## Erreurs

* *Are You Authorized to Profile this Page? Probe Not Found or Invalid signature.*
    * `sudo /etc/init.d/blackfire-agent restart` relance l'agent.
    * `php -m` montre les extensions installées. Vérifier qu'il y a *blackfire*.
    * `blackfire-agent -d` affiche la configuration de blackfire. Vérifier que `server-id` et `server-token` sont bien remplis. Sinon, `blackfire-agent -register` pour enregistrer les identifiants perso.

## Avec Windows

* Utilisation avec le navigateur
    1. Lancer le programme `blackfire-agent.exe`
    2. Lancer blackfire via l'extension du navigateur (firefox ou chrome)
* Utilisation avec curl
    1. Lancer le programme `blackfire-agent.exe`
    2. Exécuter `blackfire curl http://example.com/`