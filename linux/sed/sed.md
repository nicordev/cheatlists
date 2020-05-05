# sed

Permet de modifier le texte d'un fichier.

## Utilisation

- Afficher le contenu d'un fichier modifié par `sed` sans enregistrer les changements :

    ```bash
    cat nomFichier | sed 's/chaîneAModifier/chaîneModifiée/g'
    # Ou
    sed 's/chaîneAModifier/chaîneModifiée/g' nomFichier
    ```

    - `s` pour *substitute*, va appliquer la modification à la première occurence de la `chaîneAModifier` sur toutes les lignes.
    - `g` pour *global*, va appliquer la modification sur toutes les occurences de la `chaîneAModifier`.

- Modifier le fichier d'origine :

    > Attention : on ne peut pas annuler cette modification.

    ```bash
    sed -i 's/chaîneAModifier/chaîneModifiée/g' nomFichier
    ```

    - `-i` pour `inline`. Signifie qu'on va modifier le fichier.