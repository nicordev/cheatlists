# sed

Permet de modifier le texte d'un fichier.

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

Paramètres :

- `-d` supprime une ligne
- `-p` affiche une ligne
- `-s` remplace une ligne

Remplacer une chaîne par une autre :
    
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

- Modifier le fichier d'origine :

    > Attention : on ne peut pas annuler cette modification.

    ```bash
    sed -i 's/chaîneAModifier/chaîneModifiée/' nomFichier
    ```

    - `-i` pour `inline`. Signifie qu'on va modifier le fichier.

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