# Javascript

## Outils

- [yarn](https://yarnpkg.com/) package manager
- [npm](https://www.npmjs.com/) package manager moins bien
- [JSLint](https://www.jslint.com/) linter
- [ESLint](https://eslint.org/) linter
- [Webpack](https://webpack.js.org/) pour regrouper son code dans un minimum de fichiers
- [Babel](https://babeljs.io/) pour transformer son code dans une autre version de javascript

## Scope

* Les variables déclarées sans un mot clé `var`, `let` ou `const` sont déclarées dans le scope global.

## Modules

* HTML :
    ```html
    <script type="module" src="nomFichierModule.js"></script>
    ```
* JS 2 façons d'exporter du code :
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
* JS Import du code :
    * ```js
        import User from '/user.js' // Chemin absolu
        import User from './user.js' // Chemin relatif
        ```

## Erreurs

```js
try {
    // code susceptible à l'erreur ici
} catch (error) {
    // réaction aux erreurs ici
}
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

## String

* Exemples :
    ```js
    'Hello Bob!'
    "Hello Bob!"
    `Hello ${name}!
    What's up?`
    ```
* `"Mon super texte".length` donne le nombre de caractères d'une chaîne.
* `"Mon super texte"[0]` donne le premier caractère d'une chaîne.
* `nomChaîne[nomChaîne.length - 1]` donne le dernier caractère de la chaîne `nomChaîne`.
* Concaténation
    * `"A " + animalName + " is running."`

## Number

- Arrondir :

    ```js
    Number.toFixed(nombreDécimales)
    13.123421.toFixed(2) // Donne "13.12"
    13.125421.toFixed(2) // Donne "13.13"
    ```

    > Transforme en String.

## Object

Notation:

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

Ajout / Suppression d'une propriété

* `nomObjet.nomNouvellePropriété = valeurNouvellePropriété` ajoute une propriété à un objet.
* `delete nomObjet.nomPropriété` retire une propriété à un objet.

Création d'objets

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

`Object.keys(nomVariable);` retourne un tableaux contenant les noms des propriétés et méthodes de l'objet `nomVariable` :

```js
let circle = new Circle(700);
let circleKeys = Object.keys(circle);
```

`nomPropriétéOuMéthode in nomVariable` retourne `true` si `nomVariable` contient `nomPropriétéOuMéthode` :

- Boucle sur les propriétés d'un objet :

    ```js
    for (let key in nomVariable) {
        console.log(nomVariable[key]);
    }
    ```

Propriétés privées et closures :

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

Getters and setters

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

Classes

```js
class BankAccount {
    constructor(owner, balance) {
        this.owner = owner;
        this.balance = balance;
    }

    showBalance() {
        console.log("Solde: " + this.balance + " EUR");
    }

    deposit(amount) {
        console.log("Dépôt de " + amount + " EUR");
        this.balance += amount;
        this.showBalance();
    }

    withdraw(amount) {
        if (amount > this.balance) {
            console.log("Retrait refusé !");
        } else {
            console.log("Retrait de " + amount + " EUR");
            this.balance -= amount;
            this.showBalance();
        }
    }

    static getRandomRate() {
        return Math.floor(Math.random() * 100);
    }
}

console.log(BankAccount.getRandomRate());
```

> If a class method is invoked directly from `DOMElement.addEventListener`, then `this` will refer to the DOM element, not the class.

## Tableaux

* [MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Array)
* `Array.prototype.slice([début, fin])` renvoie un objet tableau, contenant une copie superficielle (shallow copy) du tableau d'origine ou juste d'une portion.
* `Array.prototype.push()` ajoute un ou plusieurs éléments à la fin d'un tableau et retourne la nouvelle taille du tableau.
* `Array.prototype.unshift()` ajoute un ou plusieurs éléments au début d'un tableau et renvoie la nouvelle longueur du tableau.
* `Array.prototype.pop()` supprime le dernier élément d'un tableau et retourne cet élément.
* `Array.prototype.shift()` retire le premier élément d'un tableau et renvoi cet élément.

Parcourir un tableau :

    `for in` et `for of` :

    ```js
    const passengers = [
    "Will Alexander",
    "Sarah Kate'",
    "Audrey Simon",
    "Tao Perkington"
    ];

    for (let i in passengers) {
        console.log("Embarquement du passager " + passengers[i]);
    }

    for (let passenger of passengers) {
        console.log("Embarquement du passager " + passenger);
    }
    ```

Transformer un itérable en `Array` :

```js
const elements = [...document.getElementsByClassName('fruits')];
```

Aplatir un tableau :

```js
const coins = [
    1,
    2,
    3,
    [
        10,
        11,
        12
    ],
    [
        [
            20,
            21,
            22
        ],
        [
            30,
            31,
            32
        ]
    ]
]

console.log(coins.flat(3)) // [1, 2, 3, 10, 11, 12, 20, 21, 22, 30, 31, 32]
```

> Note : si je vois `if (!myArray)`, je remplace par `if (0 === myArray.length)` car en JS, `[]` vaut `true` :
>
> ```
> if ([]) {
>   console.log('plein')
> } else {
>   console.log('vide')
> }
> // Affiche 'plein'
> ```
>
> Contrairement à PHP :
>
> ```
> if ([]) { echo "plein"; } else { echo "vide"; };
> // Affiche 'vide'
> ```

## Set

Liste d'éléments uniques pouvant être construite à partir d'un itérable.

[MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Set)

Enlever les doublons d'un tableaux:

```js
const nombres = [2,3,4,4,2,2,2,4,4,5,5,6,6,7,5,32,3,4,5];
console.log([...new Set(nombres)]);
// affichera [2, 3, 4, 5, 6, 7, 32]
```

## Map

[MDN](https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/Map)

Représente un dictionnaire clé => valeur.

```js
const map = new Map(nomItérable)
```

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

## URL

URL de la page en cours :

```js
let url = window.location.href;
```

