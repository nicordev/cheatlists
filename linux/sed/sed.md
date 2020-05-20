# sed

Permet de modifier le texte d'un fichier.

## Utilisation

> Important : `sed` ne modifie pas le fichier d'origine, sauf si on ajoute `-i`.

- Remplacer une chaîne par une autre :
    
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