# stat

Affiche l'état d'un fichier.

Récupérer l'id du propriétaire d'un fichier :

```
stat nomFichier -c %u
stat nomFichier --format=%u
```

Récupérer l'id du groupe d'un fichier :

```
stat nomFichier -c %g
stat nomFichier --format=%g
```