# sed

[scripts sed](http://sed.sourceforge.net/#scripts)

Permet d'afficher ou de modifier le texte d'un fichier.

```bash
sed [option] 'action1;action2;action3' [fileName]
```

`option` :
- `-i` modifier le fichier `fileName`
- `-n` afficher uniquement les lignes ciblées. *Pratique pour l'action `p`*
- `-e` faire plusieurs actions à la suite. *Répêter `-e` devant chaque action*
- `-f` utiliser du code sed écrit dans un fichier. *Utile pour le shebang d'un script sed : `#! /usr/bin/sed -f`*

`action` :

`'[targets][!]actionLetter[pattern][flags]'`

- `targets` lignes ciblées :
    - `1` cibler la première ligne
    - `$` cibler la dernière ligne
    - `lineNumber1;lineNumber2` cibler plusieurs lignes
    - `lineNumberStart,lineNumberEnd` cibler plusieurs lignes consécutives
    - `/hint1\|hint2/` cibler les lignes comportant les chaînes `hint1` ou `hint2` :
        - *Penser à échapper le pipe : `\|`*
        - Les caractères `/` sont obligatoires. *On ne peut pas les remplacer par un autre caractère comme il est possible de le faire avec le pattern.*
    - `/^$/` cible les lignes vides

    On peut intégrer des actions dans certaines cibles :

    ```bash
    sed '1,6{/Linux/d;}' sed-demo.txt
    ```

    va supprimer les lignes contenant Linux seulement si elles sont entre la 1ère et la 6ème ligne.

    Dans la même veine, on peut supprimer la ligne suivante :

    ```bash
    sed '/System/{N;d;}' sed-demo.txt
    ```

- `!` pour inverser la cible :

    Exemple : supprimer tout sauf les lignes 3 à 10

    ```bash
    sed '3,10!d'
    ```

- `actionLetter` exécute une action :
    - `d` supprimer
    - `p` afficher :
        - uniquement les lignes ciblées avec l'option `-n`
        - tout le contenu avec les lignes ciblées en double
    - `s` remplacer

## Exemple rapide

```bash
echo 'I have three dogs and two cats' | sed -e 's#dog#cat#g' -e 's#cat#elephant#gw nomFichier'
```

Où :
- `-e` permet d'appliquer des modifications successives.
- `s#chaîneARemplacer#chaîneDeRemplacement#flags` remplace des chaînes de caractères par d'autres :
    - flag `g` modifie toutes les occurences
    - flag `w nomFichier` permet d'enregistrer les modifications dans un fichier.

## Utilisation

> **Important : `sed` ne modifie pas le fichier d'origine, sauf si on ajoute `-i`.**

Récupérer un fragment d'une chaîne :

```
cat "$1" | sed 's#.*\"access_token\":\"\([^\"]*\)\".*#\1#'
```

Ici le groupe de capture `\([^\"]*\)` correspond au `\1`

Supprimer une ligne avec `sed <pattern>d` :

- Supprimer la première ligne :

    ```bash
    sed '1d' nomFichier
    ```

- Supprimer la dernière ligne :

    ```bash
    sed '$d' nomFichier
    ```

- Supprimer plusieurs lignes non-consécutives :

    ```bash
    sed '34d;64d;231d' nomFichier
    ```

    Supprime les lignes 34, 64 et 231 du fichier.

- Supprimer plusieurs lignes consécutives :

    ```bash
    sed '<numéroLigneDébut>,<numéroLigneFin>d' nomFichier
    ```

    Exemple :

    ```bash
    sed '5,134d' nomFichier
    ```

    Supprime les lignes 5 à 134

- Combiner le tout :

    ```bash
    sed '1;35;223,2264;$d' nomFichier
    ```


Remplacer une chaîne par une autre avec `s` :

- Changer uniquement la première occurence d'une chaîne :

    ```bash
    sed 's/chaîneAModifier/chaîneModifiée/'
    ```

    - `s` pour *substitute*, va appliquer la modification à la première occurence de la `chaîneAModifier` sur toutes les lignes.
    - Il faut 3 délimiteurs. Souvent `/` est utilisé, mais on peut en utiliser d'autres du moment qu'ils tiennent dans 1 byte (exemple : `_`, `#`, `:`).
    - On peut échapper des caractères avec `\`
    - Données en entrée :

        ```bash
        sed 's/chaîneAModifier/chaîneModifiée/' < nomFichier
        # Ou
        sed 's/chaîneAModifier/chaîneModifiée/' nomFichier
        # Ou
        cat nomFichier | sed 's/chaîneAModifier/chaîneModifiée/'
        # Ou
        echo chaîneComplète | sed 's/chaîneAModifier/chaîneModifiée/'
        ```

- Remplacer toutes les occurences d'une chaîne :

    ```bash
    sed 's/chaîneAModifier/chaîneModifiée/g' nomFichier
    ```

    - `g` pour *global*, va appliquer la modification sur toutes les occurences de la `chaîneAModifier`.

Récupérer des lignes par leur numéro :

- Prototype :
    ```bash
    sed -n "${numéroDébutGroupeDeLignes},${numéroFinGroupeDeLignes}p;${numéroLigne1}p;${numéroLigne2}p" nomFichier
    ```

- Exemples :
    ```bash
    sed -n '1p' nomFichier # Récupère la première ligne du fichier
    sed -n '3,12p' nomFichier # Récupère les lignes 3 à 12.
    sed -n '43p;6p;21' nomFichier # Récupère les lignes 6, 43 et 21.
    sed -n '24,31p;6p;21' nomFichier # Récupère les lignes 24 à 31 et les lignes 6 et 21.
    ```

Chaîner des `sed` :

```bash
cat ./initialFile | sed -n '1p;3p;5p' | sed 's#zog#bob#g' > resultFile
```