# Protocole HTTP

## Verbes HTTP

* `GET` récupération
* `POST` création
* `PUT` mise à jour ou remplacement "complet" d'un existant
* `PATCH` mise a jour partielle d'un existant
* `DELETE` suppression

> Selon [Wikipédia](https://fr.wikipedia.org/wiki/Hypertext_Transfer_Protocol)

* `GET` C'est la méthode la plus courante pour demander une ressource. Une requête GET est sans effet sur la ressource, il doit être possible de répéter la requête sans effet.
* `HEAD` Cette méthode ne demande que des informations sur la ressource, sans demander la ressource elle-même.
* `POST` Cette méthode est utilisée pour transmettre des données en vue d'un traitement à une ressource (le plus souvent depuis un formulaire HTML). L'URI fourni est l'URI d'une ressource à laquelle s'appliqueront les données envoyées. Le résultat peut être la création de nouvelles ressources ou la modification de ressources existantes. À cause de la mauvaise implémentation des méthodes HTTP (pour Ajax) par certains navigateurs (et la norme HTML qui ne supporte que les méthodes GET et POST pour les formulaires), cette méthode est souvent utilisée en remplacement de la requête PUT, qui devrait être utilisée pour la mise à jour de ressources.
* `OPTIONS` Cette méthode permet d'obtenir les options de communication d'une ressource ou du serveur en général.
* `CONNECT` Cette méthode permet d'utiliser un proxy comme un tunnel de communication.
* `TRACE` Cette méthode demande au serveur de retourner ce qu'il a reçu, dans le but de tester et effectuer un diagnostic sur la connexion.
* `PUT` Cette méthode permet de remplacer ou d'ajouter une ressource sur le serveur. L'URI fourni est celui de la ressource en question.
* `PATCH` Cette méthode permet, contrairement à PUT, de faire une modification partielle d'une ressource.
* `DELETE` Cette méthode permet de supprimer une ressource du serveur.

## Headers

* `Content-Type` indique le type MIME de la ressource demandée. 
    * [MDN](https://developer.mozilla.org/fr/docs/Web/HTTP/Headers/Content-Type)
    * Exemple : `Content-Type: text/html; charset=utf-8`
    * Types MIME :
        * `text` : `text/plain`, `text/html`, `text/css`, `text/javascript`, ...
        * `application` : `application/xml`, `application/json`, ...
        * `image` : `image/gif`, `image/png`, `image/jpeg`, `image/bmp`, `image/webp`, ...
        * `audio` : `audio/midi`, `audio/mpeg`, `audio/webm`, `audio/ogg`, `audio/wav`, ...
        * `video` : `video/webm`, `video/ogg`, ...