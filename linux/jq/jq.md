# jq

- [site](https://stedolan.github.io/jq/)

Affiche tout le contenu d'un fichier :

```
cat myFile | jq '.'
```

Affiche tous les éléments d'un tableau à la racine :

```
cat myFile | jq '.[]'
```

Affiche une propriété :

```
cat myFile | jq '."myProperty"."myOtherProperty"'
```
