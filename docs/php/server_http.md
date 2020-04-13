# Serveur et HTTP

## Serveur PHP local via la CLI

* `php -S 127.0.0.1:8000` lance le serveur en utilisant le port 8000.
* `php -S localhost:8000 -t nomDossier/` lance le serveur depuis un dossier spécifique.

## HTTP protocol

* `http_response_code(404);` set the http response code
* `header('Content-Type: text/html');` set a header
* `get_headers ( string $url [, int $format = 0 [, resource $context ]] ) : array` retourne un tableau avec les en-têtes envoyés par le serveur en réponse à une requête HTTP.