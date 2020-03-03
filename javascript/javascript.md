# Javascript

## Modules

* ``
* 2 façons d'exporter du code :
    * Mettre `export default NomClasseAExporter` ou `export { nomFonctionAExporter1, nomFonctionAExporter2 }` à la fin du fichier js.
        > Il ne peut y avoir qu'un seul élément `export default`.
    * Ecrire `export default` ou `export` devant la déclaration de l'élément à exporter :
        ```js
        export default class User {
            constructor (name, age) {
                this.name = name;
                this.age = age;
            }
        }

        export function printName(user) {
            console.log(`User's name is ${user.name}.`);
        }

        export function printAge(user) {
            console.log(`User's is ${user.age} years old.`);
        }
        ```
* Import du code :
    * ```js
        import User from '/user.js' // Chemin absolu
        import User from './user.js' // Chemin relatif
        ```

## Types

* Primitive types || Value types
    * String
    * Number
    * Boolean
    * undefined
    * null
        > Note: `typeof null;` donne **"object"**
* Reference types
    * Object
    * Array
    * Function
        ```js
        function greet(name, lastName) { // name et lastName sont des paramètres. Leur valeur par défaut est undefined
           console.log('Hello ' + name + ' ' + lastName);
        }

        greet('bob'); // 'bob' est un argument
        ```

## Strings

* Exemples :
    ```js
    'Hello Bob!'
    "Hello Bob!"
    `Hello ${name}!
    What's up?`
    ```

## Objects

* Notation:
    ```js
    const person = {
        name: 'Bob',
        age: 30
    }
    ```
    * Dot notation:
        ```js
        person.name = 'Sarah';
        console.log(person.name); // Affiche Sarah
        ```
    * Bracket notation:
        ```js
        person['name'] = 'Anaïs';
        console.log(person['name']); // Affiche Anaïs. On aurait pu utiliser une variable pour stocker la clé 'name'.
        ```
* Ajout / Suppression d'une propriété
    * `nomObjet.nomNouvellePropriété = valeurNouvellePropriété` ajoute une propriété à un objet.
    * `delete nomObjet.nomPropriété` retire une propriété à un objet.
* Création d'objets
    * On peut instancier des types primitifs comme ça :
        ```js
        let isOkay = new Boolean(5); // Toute valeur différente de 0 correspond à > 'true'.
        let name = new String('Bob');
        let age = new Number(42);
        ```
    * Propriété `constructor` :

        ```js
        let isOkay = new Boolean(5);
        isOkay.constructor // Retourne 'function Boolean()'.
        ```

        Tous les objets ont cette propriété. Elle pointe vers la fonction qui a été utilisée pour créer l'objet.
    * Factory functions:
        ```js
        function createCircle(radius) {
            return {
                radius,
                draw: function () {
                    console.log(`Draw a circle of ${this.radius}`);
                }
            }
        }

        const circle = createCircle(10);
        ```
    * Constructor function:
        ```js
        function Circle(radius) {
            this.radius = radius;
            this.draw =  function () {
                console.log(`Draw a circle of ${this.radius}`);
            }
        }

        const circleFromConstructor = new Circle(999); // Si on oublie le new, alors 'this' correspondra à l'objet 'Window' dans un navigateur ou 'global' dans node
        ```
* `Object.keys(nomVariable);` retourne un tableaux contenant les noms des propriétés et méthodes de l'objet `nomVariable` :
    ```js
    let circle = new Circle(700);
    let circleKeys = Object.keys(circle);
    ```
* `nomPropriétéOuMéthode in nomVariable` retourne `true` si `nomVariable` contient `nomPropriétéOuMéthode` :
    ```js
    for (let key in nomVariable) {
        console.log(nomVariable[key]);
    }
    ```
* Propriétés privées et closures :
    ```js
    function PrivateCircle(radius) {
        // Private
        let defaultLocation = {
            x: 2,
            y: 4
        }
        let computeOptimumLocation = function (factor) {
            console.log(factor, defaultLocation.x, defaultLocation.y); // Closure can acess private variables.
        }

        // Public
        this.radius = radius;
        this.draw = function () {
            computeOptimumLocation('zog');
            console.log('draw...');
        }
    }
    ```
* Getters and setters
    * Méthode 1 :
        ```js
        function Shape()
        {
            let defaultLocation = {
                x: 10,
                y: 20
            };


            Object.defineProperty(this, 'defaultLocation', {
                get: function () {
                    return defaultLocation;
                },
                set: function (value) {
                    if (!value.x || !value.y) {
                        throw Error('Invalid location.');
                    }

                    defaultLocation = value;
                }
            })
        }

        const Shape = new Shape();

        console.log(Shape.defaultLocation); // Call the getter
        Shape.defaultLocation = {x: 30, y: 40}; // Call the setter
        Shape.defaultLocation = 'zog'; // Throw error
        ```

## Tableaux

* `Array.prototype.slice([début, fin])` renvoie un objet tableau, contenant une copie superficielle (shallow copy) du tableau d'origine ou juste d'une portion [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/slice)
* `Array.prototype.push()` ajoute un ou plusieurs éléments à la fin d'un tableau et retourne la nouvelle taille du tableau. [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/push)
* `Array.prototype.unshift()` ajoute un ou plusieurs éléments au début d'un tableau et renvoie la nouvelle longueur du tableau. [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array/unshift)

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