# Manipuler des chaînes de caractères

[Linux Handbook](https://linuxhandbook.com/bash-strings)

Calculer la longueur d'une chaîne :

```bash
longueur=${#nomVariable}
```

Trouver la position d'une chaîne dans une autre (commence par 1) :

```bash
expr index "$haystack" "$needle"
```

Récupérer un fragment d'une chaîne (commence par 0) :

```bash
echo ${nomVariable:début:longueur}
echo ${'Hello world!':0:2} # He
echo ${'Hello world!':5} # world!
```

Remplacer une chaîne par une autre :

```bash
echo ${foss/Fedora/Ubuntu}
```