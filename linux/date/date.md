# Date

`date "+%codeDate"` affiche une partie de la date actuelle `%codeDate` :
* `%W` numéro de la semaine.
* `%A` nom du jour.
* On peut ajouter du texte et mettre plusieurs parties :
    * `date "+Nous sommes le %A de la semaine %W"`

Pour concaténer l'année, le mois et le jour :

```
date "+%Y%m%d"
```