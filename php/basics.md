# Basics

## CLI

* [Documentation](https://www.php.net/manual/en/features.commandline.php)
* `php -S 127.0.0.1:8000 -t public/` launch a local server
* `env PATH="C:\wamp64\bin\php\php7.2.18:$PATH" php bin/console doctrine:schema:create` change PHP version to execute a command
* `php -r "echo md5(\"Hello world!\");"` execute a line of php code
* `php -a` execute php code with the interactive shell

## HTTP protocol

* `http_response_code(404);` set the http response code
* `header('Content-Type: text/html');` set a header

## Arrays

* `array_values ( array $array ) : array` convert an associative array to an array [doc](https://www.php.net/manual/en/function.array-values.php)
* `array_keys ( array $array , mixed $search_value [, bool $strict = FALSE ] ) : array` get array keys [doc](https://www.php.net/manual/fr/function.array-keys.php)
* `reset ( array &$array ) : mixed` return the first element of an array and set the internal pointer to it
* `current ( array $array ) : mixed` return the current element of the array, so the first element by default [doc](https://www.php.net/manual/fr/function.current.php)

## String

* `ord('a')` return the code
* `chr(97)` return the character