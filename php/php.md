# PHP

## Astuces

* Surcharger une méthode en y ajoutant un paramètre supplémentaire :
    * Donner une valeur par défaut au paramètre :
        ```php
        public function nomMéthode($nomParamètreHérité, $nomParamètreAjouté = 'valeurParDéfaut') { /* ... */ }
* Après une boucle `foreach` utilisant des références, toujours `unset` la variable de la boucle :
    ```php
    foreach ($someValues as &$value) { }
    unset($value);
    foreach ($someValues as $value) { }
    ```
    Sinon `$value` pointerait toujours sur le dernier élément de `$someValues` et le second `foreach` modifierait le dernier élément de `$someValues`.

## CLI

* [Documentation](https://www.php.net/manual/en/features.commandline.php)
* `php -r "echo \"Hello world!\";"` exécute une ligne de code php
* `php -a` exécuter du code php dans le terminal intéractif
* `$argv` contient tous les arguments passés au script php. Le premier élément du tableau est le nom du fichier du script.
* `$argc` contient le nombre d'arguments passés au script php.
* `php -S 127.0.0.1:8000 -t public/` lance un serveur local
* `env PATH="C:\wamp64\bin\php\php7.2.18:$PATH" php bin/console doctrine:schema:create` change la version de php pour l'exécution d'une commande
* `php -m` affiche les modules (extensions) installés.

### Exécution de script shell

[doc](https://www.php.net/manual/fr/language.operators.execution.php)

* `` $resultat = `du code shell genre ls -al`; `` exécute le code shell entre `` ` `` et assigne le résultat à `$resultat`
* `shell_exec ( string $cmd ) : string` est la fonction équivalente à l'utilisation des `` ` ``

## Input / Output

> Un flux est un fichier.
> Une ressource est une variable spéciale, contenant une référence vers une ressource externe. Une ressource peut être un fichier.

* `STDIN` Un flux déjà ouvert vers stdin. Ceci évite de l'ouvrir explicitement avec `$stdin = fopen('php://stdin', 'r');`
* `STDOUT` Un flux déjà ouvert vers stdout. Ceci évite de l'ouvrir explicitement avec `$stdout = fopen('php://stdout', 'r');`
* `STDERR` Un flux déjà ouvert vers stderr. Ceci évite de l'ouvrir explicitement avec `$stderr = fopen('php://stderr', 'r');`
* `fgets ( resource $file [, int $length ] ) : string` récupère la ligne courante sur laquelle se trouve le pointeur du fichier.
    * `fgets(STDIN)` lit la ligne entrée au clavier.

## Variables

* Type
    * `gettype($maVariable)` retourne le type de la variable
* Variables super globales
    * `filter_input ( int $type , string $variable_name [, int $filter = FILTER_DEFAULT [, mixed $options ]] ) : mixed` récupère une variable externe et la filtre avec `$type` parmi `INPUT_GET`, `INPUT_POST`, `INPUT_COOKIE`, `INPUT_SERVER` ou `INPUT_ENV`.

## Binary

* `base_convert ( string $number , int $frombase , int $tobase ) : string` retourne une chaîne contenant l'argument `number` représenté dans la base tobase. La base de représentation de `number` est donnée par frombase. frombase et tobase doivent être compris entre 2 et 36 inclus. Les chiffres supérieurs à 10 des bases supérieures à 10 seront représentés par les lettres de A à Z, avec A = 10 et Z = 35. Le casse des lettres n'a pas d'importance, c'est à dire `number` est interprété de façon insensible à la casse.
* `decbin ( int $number ) : string` retourne une chaîne contenant la représentation binaire de l'entier number donné en argument.
* `bindec ( string $binary_string ) : number` retourne la conversion d'un nombre binaire représenté par la chaîne binary_string en décimal.
* `bin2hex ( string $str ) : string` retourne la chaîne `$str` dont tous les caractères sont représentés par leur équivalent hexadécimal. La chaîne retournée est une chaîne ASCII. La conversion supporte les caractères binaires, et utilise les bits de poids forts en premier.
* `hex2bin ( string $data ) : string` convertit une chaîne binaire encodée en hexadécimal.

## Numbers

* `number_format ( float $number [, int $decimals = 0 ] ) : string` formate un nombre pour l'affichage
* `round ( float $val [, int $precision = 0 [, int $mode = PHP_ROUND_HALF_UP ]] ) : float` arrondit un nombre à virgule flottante
* `ceil ( float $value ) : float` retourne l'entier supérieur du nombre value.

## Arrays

* `compact ( mixed $varname1 [, mixed $... ] ) : array` crée un tableau à partir de variables et de leur valeur.
* `unset ( mixed $var [, mixed $... ] ) : void` détruit un élément d'un tableau ou n'importe quelle autre variable
* `array_reduce ( array $array , callable $callback [, mixed $initial = NULL ] ) : mixed` applique itérativement la fonction `callback` aux éléments du tableau `array`, de manière à réduire le tableau à une valeur simple.
* `array_values ( array $array ) : array` converti un tableau associatif en tableau à clés numériques [doc](https://www.php.net/manual/en/function.array-values.php)
* `array_keys ( array $array , mixed $search_value [, bool $strict = FALSE ] ) : array` récupére les clés d'un tableau [doc](https://www.php.net/manual/fr/function.array-keys.php)
* `array_count_values ( array $array ) : array` retourne un tableau contenant les valeurs du tableau array comme clés et leur fréquence comme valeurs.
* `reset ( array &$array ) : mixed` retourne le premier élément d'un tableau et place le pointeur interne dessus
* `current ( array $array ) : mixed` retourne l'élément courant d'un tableau, soit le premier élément par défaut [doc](https://www.php.net/manual/fr/function.current.php)
* `next ( array &$array ) : mixed` avance le pointeur interne du tableau d'un élément, avant de retourner la valeur de l'élément. Cela signifie qu'il retourne la prochaine valeur du tableau et avance le pointeur interne d'un élément.
* `prev ( array &$array ) : mixed` se comporte exactement comme next(), mais elle fait reculer le pointeur plutôt que de l'avancer.
* `array_shift ( array &$array ) : mixed` extrait la première valeur du tableau `array` et la retourne, en raccourcissant `array` d'un élément, et en déplaçant tous les éléments vers le bas. Toutes les clés numériques seront modifiées pour commencer à zéro pendant que les clées litérale ne seront pas affectées. 
* `array_unshift ( array &$array [, mixed $élementsAAjouter... ] ) : int` ajoute un ou plusieurs éléments au début d'un tableau. Toutes les clés numériques seront modifiées afin de commencer à partir de zéro, tandis que les clés littérales ne seront pas touchées.
* `array_flip ( array $array ) : array` retourne un tableau dont les clés sont les valeurs du précédent tableau array, et les valeurs sont les clés
* `array_combine ( array $keys , array $values ) : array` crée un tableau, dont les clés sont les valeurs de keys, et les valeurs sont les valeurs de values.
* Opérateur `+` ajoute le tableau de droite au tableau de gauche. Si des clés sont communes, seules les valeurs du tableau de gauche seront conservées
* `array_unique ( array $array [, int $sort_flags = SORT_STRING ] ) : array` extrait du tableau array les valeurs distinctes, et supprime tous les doublons.
* `array_key_exists ( mixed $key , array $array ) : bool` retourne TRUE s'il existe une clé du nom de key dans le tableau array. key peut être n'importe quelle valeur valide d'index de tableau. Diffère de `isset()` :
    * `isset ( mixed $var [, mixed $... ] ) : bool` détermine si une variable est déclarée et est différente de `NULL`.

## Generator

* `iterator_to_array ( Traversable $iterator [, bool $use_keys = TRUE ] ) : array` copie les éléments d'un itérateur dans un tableau.

## String

* `PHP_EOL` renvoie une chaine correspondant au saut de ligne sur la plateforme (LF, \n ou #10 sur Unix, CRLF, \r\n ou #13#10 sur Windows).
* `ord('a')` retourne le code du caractère.
* `chr(97)` retourne le caractère correspondant au code.
* `strpos(string $haystack, $needle [, int $offset = 0]): int` cherche la position numérique de la première occurrence de needle dans la chaîne de caractères haystack.
* `strrpos(string $haystack, $needle [, int $offset = 0]): int` cherche la position numérique de la dernière occurrence de needle dans la chaîne de caractères haystack.
* `substr(string $string, int $start [, int $length ]): string` retourne le segment de string défini par start et length.
* `substr_replace(mixed $string, mixed $replacement, mixed $start [, mixed $length ]): mixed` remplace un segment de la chaîne string par la chaîne replacement. Le segment est délimité par start et éventuellement par length.
* `substr_count(string $haystack, string $needle [, int $offset = 0 [, int $length ]]): int` retourne le nombre d'occurrences de needle dans la chaîne haystack. Notez que needle est sensible à la casse.
* `str_repeat ( string $input , int $multiplier ) : string` retourne la chaîne `$input` répétée `$multiplier` fois.

## Serialize, deserialize

* `serialize ( mixed $value ) : string` transforme (linéarise) une variable en string (serialize). La string produite est similaire à celle utilisée dans les bases de données (exemple : type array de doctrine).
* `unserialize ( string $str [, array $options ] ) : mixed` prend une variable linéarisée et la convertit en variable PHP. 

## Dates

* `(new DateTime())->format("Y-m-d HH:ii:ss")` génère une string MySQL représentant la date et l'heure courante.
* `(new DateTime())->format("W")` génère une string représentant le numéro de la semaine courante.
* `(new DateTime())->getTimestamp();` retourne le timestamp actuel.
- `$date = new DateTime("@$timestamp");` construit un objet DateTime à partir d'un timestamp

## break

```php
for ($i = 0; $i < 20; $i++) {
    switch ($i) {
        case 5:
            echo "At 5<br />\n";
            break 1;  /* Termine uniquement le switch. */
        case 10:
            echo "At 10; quitting<br />\n";
            break 2;  /* Termine le switch et la boucle for. */
    }
}
```

## Constantes

> [Documentation](https://www.php.net/manual/fr/reserved.constants.php)

- `PHP_SAPI` décrit le type d'interface utilisée par PHP :
    - `cli` Common Line Interface
    - `cgi` Common Gateway Interface
    - `cli-server` php built-in webserver
    - `srv` hhvm

    Fonction pour récupérer la valeur de cette constante :

    ```php
    php_sapi_name();
    ```
- `PHP_EOL` indique le symbole de retour à la ligne `\n` ou `\r\n`.
- `PHP_INT_MAX`
- `PHP_INT_MIN`