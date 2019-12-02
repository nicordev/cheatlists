# Javascript

## Exceptions

```javascript
throw "Votre navigateur est trop pourri. Veuillez en changer."; // génère une exception étant une chaîne de caractères
throw 42;          // génère une exception ayant la valeur 42
throw true;        // génère une exception ayant la valeur true
throw new Error("Votre navigateur est trop pourri. Veuillez en changer.");  // génère un objet Error avec le message "Obligatoire"
```

## Arrow functions

> Une expression de fonction fléchée (arrow function en anglais) permet d’avoir une syntaxe plus courte que les expressions de fonction et ne possède pas ses propres valeurs pour this, arguments, super, ou new.target. Les fonctions fléchées sont souvent anonymes et ne sont pas destinées à être utilisées pour déclarer des méthodes. [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Fonctions/Fonctions_fl%C3%A9ch%C3%A9es)

```js
([param] [, param]) => {
   instructions
}
```
```js
(param1, param2, …, param2) => expression
// équivalent à 
(param1, param2, …, param2) => {
  return expression;
}
```
```js
// Parenthèses non nécessaires quand il n'y a qu'un seul argument
param => expression
```
```js
// Une fonction sans paramètre peut s'écrire avec un couple 
// de parenthèses
() => {
  instructions
}
```
```js
// Gestion des paramètres du reste et paramètres par défaut
(param1, param2, ...reste) => {
  instructions
}
(param1 = valeurDefaut1, param2, …, paramN = valeurDefautN) => { 
  instructions
}
```
```js
// Gestion de la décomposition pour la liste des paramètres
let f = ([a, b] = [1, 2], {x: c} = {x: a + b}) => a + b + c;
f();
```

## Tableaux

* `Array.prototype.slice([début, fin])` renvoie un objet tableau, contenant une copie superficielle (shallow copy) du tableau d'origine ou juste d'une portion [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/slice)
* `Array.prototype.push()` ajoute un ou plusieurs éléments à la fin d'un tableau et retourne la nouvelle taille du tableau. [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/push)
* `Array.prototype.unshift()` ajoute un ou plusieurs éléments au début d'un tableau et renvoie la nouvelle longueur du tableau. [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/unshift)