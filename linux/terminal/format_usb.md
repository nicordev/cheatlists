# Formater une clé usb

[source](https://www.unixmen.com/how-to-format-usb-drive-in-the-terminal/)

> Pas testé

1. Voir le chemin de la clé avec `df` dans la colonne *Filesystem*
2. Démonter le lecteur avec `sudo umount /chemin/cléUsb`
3. Formater la clé en *FAT32* avec `sudo mkfs.vfat -n 'nouveauNomCléUsb' -I /chemin/cléUsb` où :
    * `mkfs` la commande pour créer un système de fichier linux.
        * `mkfs.vfat` permet de créer un système de fichier en *FAT32*
        * `-n` pour donner un nom à la clé
        * `I`