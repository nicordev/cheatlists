# Operateurs PHP

## Classe

[doc](https://www.php.net/manual/fr/language.operators.type.php)

`$monObjet instanceof MaClasse` retourne `true` si `$monObjet` est une instance de `MaClasse`.

## Arithmétiques

[doc](https://www.php.net/manual/fr/language.operators.arithmetic.php)

Exemple  | Nom            | Résultat
---------|----------------|---------
+$a      | Identité       | Conversion de $a vers int ou float, selon le plus approprié.
-$a      | Négation       | Opposé de $a.
$a + $b  | Addition       | Somme de $a et $b.
$a - $b  | Soustraction   | Différence de $a et $b.
$a * $b  | Multiplication | Produit de $a et $b.
$a / $b  | Division       | Quotient de $a et $b. int / int = int (ou double si division incomplète).
$a % $b  | Modulus        | Reste de $a divisé par $b.
$a ** $b | Puissance      | Résultat de l'élévation de $a à la puissance $b. Introduit en PHP 5.6.

Pour obtenir uniquement le quotient de la division, utiliser `intdiv($dividende, $diviseur)`.
Pour obtenir le reste de la division sous forme de double, utiliser `fmod($dividende, $diviseur)`.

## Comparaison

[doc](https://www.php.net/manual/fr/language.operators.comparison.php)

Exemple   | Nom               | Résultat
----------|-------------------|---------
$a == $b  | Egal              | TRUE si $a est égal à $b après le transtypage.
$a === $b | Identique         | TRUE si $a est égal à $b et qu'ils sont de même type.
$a != $b  | Différent         | TRUE si $a est différent de $b après le transtypage.
$a <> $b  | Différent         | TRUE si $a est différent de $b après le transtypage.
$a !== $b | Différent         | TRUE si $a est différent de $b ou bien s'ils ne sont pas du même type.
$a < $b   | Plus petit que    | TRUE si $a est strictement plus petit que $b.
$a > $b   | Plus grand        | TRUE si $a est strictement plus grand que $b.
$a <= $b  | Inférieur ou égal | TRUE si $a est plus petit ou égal à $b.
$a >= $b  | Supérieur ou égal | TRUE si $a est plus grand ou égal à $b.
$a <=> $b | Combiné           | Un entier inférieur, égal ou supérieur à zéro lorsque $a est respectivement inférieur, égal, ou supérieur à $b. Disponible depuis PHP 7.

## Logique

Exemple     | Nom         | Résultat
------------|-------------|---------
$a && $b    | And (Et)    | TRUE si $a ET $b sont TRUE.
$a \|\| $b  |	Or (Ou)   |	TRUE si $a OU $b est TRUE.
!$a         | Not (Non)   | TRUE si $a n'est pas TRUE.
$a and $b   | And (Et)    | TRUE si $a ET $b valent TRUE.
$a or $b    | Or (Ou)     | TRUE si $a OU $b valent TRUE.
$a xor $b   | XOR         | TRUE si $a OU $b est TRUE, mais pas les deux en même temps.

## Bits

[doc](https://www.php.net/manual/fr/language.operators.bitwise.php)

Exemple     | Nom      | Résultat
------------|----------|---------
$a & $b     | And (Et) | Les bits positionnés à 1 dans $a ET dans $b sont positionnés à 1.
$a | $b     |	Or (Ou)             |	Les bits positionnés à 1 dans $a OU $b sont positionnés à 1.
$a ^ $b     |	Xor (ou exclusif)   |	Les bits positionnés à 1 dans $a OU dans $b mais pas dans les deux sont positionnés à 1.
~ $a        |	Not (Non)           |	Les bits qui sont positionnés à 1 dans $a sont positionnés à 0, et vice-versa.
$a << $b    |	Décalage à gauche   |	Décale les bits de $a, $b fois sur la gauche (chaque décalage équivaut à une multiplication par 2).
$a >> $b    |	Décalage à droite   |	Décale les bits de $a, $b fois sur la droite (chaque décalage équivaut à une division par 2). 

## Assignation

[doc](https://www.php.net/manual/fr/language.operators.assignment.php)

```php
$fruit = 'apple';
$apple = $fruit; // Ici $apple prend la valeur de $fruit
$myFruit = &$fruit; // $myFruit est une référence à $fruit

echo "$fruit $apple $myFruit"; // Affiche 'apple apple apple'

$fruit = 'peach';

echo "$fruit $apple $myFruit"; // Affiche 'peach apple peach'
```

## Incrémentation, décrémentation

[doc](https://www.php.net/manual/fr/language.operators.increment.php)

Exemple | Nom             | Résultat
--------|-----------------|--------------------------------------
++$a    | Pre-incrémente  | Incrémente $a de 1, puis retourne $a.
$a++    | Post-incrémente | Retourne $a, puis incrémente $a de 1.
--$a    | Pré-décrémente  | Décrémente $a de 1, puis retourne $a.
$a--    | Post-décrémente | Retourne $a, puis décrémente $a de 1.

## String

[doc](https://www.php.net/manual/fr/language.operators.string.php)

* Concaténation :
    * ```php
        $a = "Hello ";
        $b = $a . "World!"; // now $b contains "Hello World!"

        $a = "Hello ";
        $a .= "World!";     // now $a contains "Hello World!"
        ```
    * ```php
        $favoriteFruit = 'pommes';
        $fruits = ['pomme', 'cerise', 'framboise'];
        echo "J'aime bien les $favoriteFruit et les {$fruits[2]}s.\n";
        ```

## Tableau

[doc](https://www.php.net/manual/fr/language.operators.array.php)

Exemple   | Nom           | Résultat
----------|---------------|-----------------------------------------------------------------------------------------------
$a + $b   | Union         | Union de $a et $b.
$a == $b  | Egalité       | TRUE si $a et $b contiennent les mêmes paires clés/valeurs.
$a === $b | Identique     | TRUE si $a et $b contiennent les mêmes paires clés/valeurs dans le même ordre et du même type.
$a != $b  | Inégalité     | TRUE si $a n'est pas égal à $b.
$a <> $b  | Inégalité     | TRUE si $a n'est pas égal à $b.
$a !== $b | Non-identique | TRUE si $a n'est pas identique à $b.