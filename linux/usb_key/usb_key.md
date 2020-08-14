# Clés USB

## Afficher les clés présentes

```bash
sudo fdisk -l
```

La première clé est `sdb`, la 2ème `sdc`, etc...

## Formater une clé usb

[source](https://www.unixmen.com/how-to-format-usb-drive-in-the-terminal/)

> Pas testé

1. Voir le chemin de la clé :

    - Avec `df` dans la colonne *Filesystem* :

        ```bash
        df
        ```
    - Avec `fdisk`

        ```bash
        sudo fdisk -l
        ```

2. Démonter le lecteur :
    
    ```bash
    sudo umount /chemin/cléUsb
    ```

3. Formater la clé en *FAT32* :
    `sudo mkfs.vfat -n 'NOUVEAU_NOM_CLE_USB' -I /chemin/cléUsb` où :
    * `mkfs` la commande pour créer un système de fichier linux.
        * `mkfs.vfat` permet de créer un système de fichier en *FAT32*.
        * `-n` pour donner un nom à la clé.
        * `-I` si ça coince sans.

## Créer une clé usb contenant une distribution linux (bootable)

[source](https://ostechnix.com/how-to-create-bootable-usb-drive-using-dd-command/)

Une fois le fichier image `.iso` de la distribution téléchargé, faire :

1. Identifier la clé à utiliser :

    ```bash
    sudo fdisk -l
    ```

    Si une seule clé est présente, elle sera sur `sdb`.

    **Pour la suite on considère que la clé est sur `sdb`**

1. Démonter la clé :

    ```bash
    umount /dev/sdb*
    ```

1. Formater la clé :

    ```bash
    sudo mkfs.vfat /dev/sdb -I
    ```

    `mkfs` permet de générer un système de fichier FAT32.

1. Mettre l'image `.iso` sur la clé :

    ```bash
    dd if=cheminVers/fichierImage.iso of=/dev/sdb
    ```