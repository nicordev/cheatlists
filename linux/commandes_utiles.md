# Commandes

- `cd` change de répertoire courant :

    ```bash
    cd chemin/nomDossier
    ```

- `seq` Générer une série de nombres :

    ```bash
    seq nombreDépart nombreFin
    seq nombreDépart écart nombreFin
    ```

    Exemples :

    - `seq -10 10` affiche les nombres de -10 à 10.
    - `seq -10 2 10` affiche les nombres de -10 à 10 avec un pas de 2.

- `rm` Supprimer des fichiers et dossiers :

    - Supprimer des dossier et tout leur contenu :

        ```bash
        rm -rf nomDossier1 nomDossier2
        ```
    
    - Supprimer tout sauf un fichier :

        ```bash
        rm -v !(nomfichierAConserver) nomDossier1 nomDossier2
        ```

- Afficher un calendrier :

    ```bash
    cal
    ```

