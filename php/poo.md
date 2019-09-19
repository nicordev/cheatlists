# POO en PHP

## Différences avec le procédural

Voici une fonction procédurale :

```
function addTask(array $todoList, string $task)
{
    todoList[] = $task;
}
```

Qu'on appellerait de cette manière :

```
$todoList = ['Dormir', 'Manger', 'Coder'];

addTask($todoList, 'Boire');
```

Et voici son équivalent en POO (on parle alors de méthode, mais c'est le même principe) :

```
class TodoList
{
    public static function addTask(array $todoList, string $task) {
        todoList[] = $task;
    }
}
```

Qu'on appellerait de cette façon :

```
$todoList = ['Dormir', 'Manger', 'Coder'];

TodoList::addTask($todoList, 'Boire');
```

Cette nouvelle manière d'écrire le code permet d'isoler notre fonction addTask() dans notre classe TodoList (on parle d'encapsulation), ce qui a un inconvénient : c'est plus long à écrire, mais plein d'avantages : notre fonction addTask() ne pourra pas entrer en conflit avec une autre fonction portant le même nom (vu qu'on doit écrire le nom de la classe avant) et on va pouvoir écrire d'autres méthodes (méthode = fonction en POO) dans notre classe TodoList qui seront ainsi bien au chaud dans la classe (et pas éparpillées dans notre code comme on a tendance à faire en procédural).

A partir de là, notre classe va pouvoir s'étoffer pour être encore plus puissante :