# Code sniffer

[GitHub](https://github.com/squizlabs/PHP_CodeSniffer)

## Installation

* `composer global require "squizlabs/php_codesniffer=*"`
* `composer require --dev "squizlabs/php_codesniffer"`

## phpcs

Lancer en global : `phpcs /path/to/code/myfile.php`

## phpcbf

Lancer depuis un projet : `./vendor/bin/phpcbf nomDossier --standard=PSR12 -p`
Lancer en global : `phpcbf nomDossier --standard=PSR12 -p`