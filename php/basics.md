# Basics

## CLI

* [Documentation](https://www.php.net/manual/en/features.commandline.php)
* `php -S 127.0.0.1:8000 -t public/` lance un serveur local
* `env PATH="C:\wamp64\bin\php\php7.2.18:$PATH" php bin/console doctrine:schema:create` change la version de php pour l'exécution d'une commande
* `php -r "echo md5(\"Hello world!\");"` exécute une ligne de code php
* `php -a` exécuter du code php dans le terminal intéractif

## HTTP protocol

* `http_response_code(404);` set the http response code
* `header('Content-Type: text/html');` set a header

## Arrays

* `array_values ( array $array ) : array` converti un tableau associatif en tableau à clés numériques [doc](https://www.php.net/manual/en/function.array-values.php)
* `array_keys ( array $array , mixed $search_value [, bool $strict = FALSE ] ) : array` récupére les clés d'un tableau [doc](https://www.php.net/manual/fr/function.array-keys.php)
* `reset ( array &$array ) : mixed` retourne le premier élément d'un tableau et place le pointeur interne dessus
* `current ( array $array ) : mixed` retourne l'élément courant d'un tableau, soit le premier élément par défaut [doc](https://www.php.net/manual/fr/function.current.php)
* `array_unshift ( array &$array [, mixed $élementsAAjouter... ] ) : int` ajoute un ou plusieurs éléments au début d'un tableau. Toutes les clés numériques seront modifiées afin de commencer à partir de zéro, tandis que les clés littérales ne seront pas touchées.
* ` array_flip ( array $array ) : array` retourne un tableau dont les clés sont les valeurs du précédent tableau array, et les valeurs sont les clés

## String

* `ord('a')` retourne le code du caractère
* `chr(97)` retourne le caractère correspondant au code

## xDebug

* `sudo apt-get install php-xdebug`