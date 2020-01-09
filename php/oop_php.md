# Programmation orientée objet (POO) en PHP

## Principe de base

En POO, la **classe** correspond au plan de fabrication des **objets**.

Prenons un exemple de la vie réelle, la construction de maisons. On va pouvoir faire plusieurs maisons, mettont une bleu, une rouge et une verte, à partir d'un même plan qu'on appellera `Maison` avec un 'M' majuscule. En POO, les **objets** sont les maisons construites et la **classe** est le plan `Maison`. On dit alors que ces maisons sont des instances de la classe `Maison`.

## Fil rouge

Pour présenter la POO, je vais utiliser un projet de liste de tâche à faire (to do list).

## Similitudes avec le procédural

Voici une fonction classique :

```php
function addTask(array &$todoList, string $task) // Ici le & permet de passer le tableau par référence pour pouvoir modifier son contenu
{
    todoList[] = $task;
}
```

Qu'on appellerait de cette manière :

```php
$todoList = ['Dormir', 'Manger', 'Coder'];

addTask($todoList, 'Boire');
```

Et voici son équivalent en POO (on parle alors de méthode, mais c'est le même principe) :

```php
class TodoList
{
    public static function addTask(array &$todoList, string $task) 
    {
        todoList[] = $task;
    }
}
```

Qu'on appellerait de cette façon :

```php
$todoList = ['Dormir', 'Manger', 'Coder'];

TodoList::addTask($todoList, 'Boire');
```

Cette nouvelle manière d'écrire le code permet d'isoler notre fonction `addTask()` dans notre classe `TodoList` (on parle d'encapsulation). Il y a un inconvénient : c'est plus long à écrire, mais plein d'avantages :
* Toutes les fonctions relatives à la liste de tâche seront écrites dans la classe, ce qui permet de mieux s'organiser et d'avoir un code plus lisible.
* Notre fonction `addTask()` ne pourra pas entrer en conflit avec une autre fonction portant le même nom vu qu'on doit écrire le nom de la classe avant. Si manque de bol on a une autre classe `TodoList` ayant une méthode `addTask()` dans notre projet, alors on ajoutera un namespace (espace de nom) propre à notre classe pour les dissocier (plus d'info là-dessus après).

# Différences avec le procédural

Pour l'instant notre méthode `addTask` est statique et s'utilise comme une fonction classique. Le top, ça serait d'avoir un objet TodoList qui contiendrait des tâches, comme ça on pourrait trimballer notre objet un peu partout dans notre code et toujours avoir la liste des tâches et les méthodes pour la modifier sous la main.

En procédural, ça pourrait être un tableau qu'on appelerait $todoList et on appellerait la fonction `addTask()` :
```php
$todoList = [];
addTask($todoList, "Manger");
addTask($todoList, "Coder");
addTask($todoList, "Dormir");
```

En POO, on va préférer intégrer ce tableau de tâche dans notre classe, comme ceci :

```php
class TodoList
{
    public $tasks = [];

    public function addTask(string $task) {
        $this->tasks[] = $task;
    }
}
```

Notez que notre méthode `addTask` n'est plus statique : on a retiré le mot clé `static` et le paramètre `array &$todoList` a disparu au profit d'une propriété `$tasks` placée dans la classe. Ainsi, chaque objet que l'on va créer à partir de la classe `TodoList` possèdera son propre tableau de tâche à faire, stocké dans la propriété `$tasks`.

On modifie alors la propriété `$tasks` de l'objet dans notre méthode `addTask()` en utilisant `$this->tasks` où `$this` correspond à notre objet.

```php
$todoList = new TodoList();
```

On peut alors utiliser notre méthode `addTask()` pour ajouter les tâches à faire :

```php
$todoList->addTask("Manger");
$todoList->addTask("Coder");
$todoList->addTask("Dormir");
```

Et accéder à la liste des tâches de cette manière :

```php
$tasks = $todoList->tasks;
```