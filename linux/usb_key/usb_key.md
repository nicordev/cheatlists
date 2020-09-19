# Clés USB

## Identifier les clés présentes

```bash
sudo fdisk -l
```

ou

```bash
lsblk
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

## Créer une clé bootable persistante avec `mkusb`

> [Info](https://www.howtogeek.com/howto/14912/create-a-persistent-bootable-ubuntu-usb-flash-drive/)

> Si on créé la clé depuis une autre clé bootable :
>
> ```bash
> sudo add-apt-repository universe
> ```

1. Installer `mkusb` :
    
    ```bash
    sudo add-apt-repository ppa:mkusb/ppa
    sudo apt-get update
    sudo apt install --install-recommends mkusb mkusb-nox usb-pack-efi
    ```

1. Identifier la clé usb : 

    ```bash
    lsblk
    ```

    > sdb, sdc...

1. Lancer `mkusb` :

    ```bash
    mkusb
    ```

1. Choisir `Install (make a boot device)`.
1. Choisir `Persistent live`.
1. Choisir le fichier `.iso` à utiliser.
1. Choisir `usb-pack-efi (default grub from ISO file)`
1. Choisir la proportion de mémoire de la clé à allouer au système de persistence des données.