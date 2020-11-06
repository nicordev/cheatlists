# bash

## Debug

Activer le debug :

```bash
set -vx
```
Désactiver le debug :

```bash
set +vx
```

## Ecrire un script

```bash
#! /bin/bash

# Ceci est un commentaire

nomFonction() {
    variableGlobale='valeur'
    local variableLocale='valeur'
}

$@ # Contient tous les paramètres passés au script
$0 # Contient le nom du fichier du script
```

1ère ligne :
- définir le chemin du programme et ses paramètres à utiliser pour exécuter le script avec le *shebang*
- pour bash :

    ```bash
    #! /bin/bash
    ```
- pour sed :

    ```bash
    #! /usr/bin/sed -f
    ```
