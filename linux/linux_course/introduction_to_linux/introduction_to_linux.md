# Introduction to Linux

- [Dashboard](https://courses.edx.org/dashboard)
- [Linux foundation](https://www.linuxfoundation.org/)
- [Linux distributions](https://lwn.net/Distributions/)

## Avant de commencer

- utiliser `man topicNameHere`.
- `foo` est à remplacer par un nom de fichier.

## C'est parti !

Fichiers stockés de manière hiérarchique avec à la source la racine *root* `/`.

Terminologie :
- kernel (noyau) : contrôle le hardware et permet au hardware de communiquer avec les applications. [Lien vers les versions du kernel Linux](https://www.kernel.org/)
- distribution : ensemble de programmes combinés avec le kernel Linux
- boot loader : programme qui lance l'OS (Operating System)
- service : un programme qui tourne en arrière plan (background process)
- filesystem : méthode d'organisation et de stockage de fichiers (ext4, FAT, XFS, NTFS, Btrfs)
- x window system : boîte à outil standard et protocole pour construire une interface graphique
- desktop environment : GUI (Graphic User Interface) comme GNOME, KDE, Xfce...
- command line : interface pour entrer des commandes
- shell : command line interpreter (sh, bash, zsh)

## Boot process

![](image/chapter03_flowchart_scr15_1.jpg)

0. Power ON
1. `BIOS` (Basic Input/Output System) ou POST (Power On Self Test) :

    Initialise le hardware (écran et clavier), test la mémoire principale

    Ce programme est présent dans une ROM chip sur la carte mère.

1. 2 options : `MBR` ou `UEFI`
    
    - `MBR` (Master Boot Record) 512 bytes :

        1. Regarde les partitions présentes (partition table).
        1. Sélectionne une partition démarrable (bootable partition).
        1. Charge le `second stage boot loader` de la partition (GRUB par exemple) dans la RAM (Random Access Memory)
    
    - `EFI/UEFI` (Unified Extensible Firmware Interface) :

        1. Regarde le Boot Manager enregistré dans ses données pour voir quel application UEFI doit être exécutée et depuis quel partition.

    Le `second stage boot loader` est situés sous `/boot`

1. Choisir l'OS à utiliser (Ubuntu par exemple)
1. Le boot loader charge le kernel de l'OS sélectionné dans la RAM et lui donne le contrôle.

    Le kernel va alors :
    0. se décompresser (si il est compressé, ce qui est souvent le cas)
    1. analyser et vérifier le matériel et ses drivers.
    1. charger le `initramfs` (initialisation RAM filesystem) image qui va monter le système de fichier root en utilisant `udev` (user device) pour trouver et charger les périphériques présents avec leurs drivers.
    1. lancer le programme `mount` qui associe le filesystem à un point particulier dans la hiérarchie (`mount point`).
    1. retirer `initramfs` de la RAM
    1. lancer le programme `/sbin/init` qui va :
        1. monter le vrai système de fichier racine (`root filesystem`). Si des drivers spéciaux sont nécessaires, ils devraient se trouver dans l'image `initramfs`.
        1. lancer des invites de commande de connexion textuelles (`text-mode login prompts`) utilisables aussi dans l'interface graphique via ctl + alt + F1 à F7.

        Autres méthodes :
        - Upstart (abandonée)
        - systemd (utilisée partout)

        Dorénavant, `/sbin/init` pointe vers `/lib/systemd/systemd`

## systemd

Utilise des fichiers de configuration pour indiquer quels services sont démarrés et comment.

Utiliser `systemctl` pour intéragir avec les services :
- Dans la session actuelle :

    ```bash
    sudo systemctl start|stop|restart nomService.service
    ```

- Au démarrage de la prochaine session :

    ```bash
    sudo systemctl enable|disable nomService.service
    ```

## Filesystem

A partition is a physically contiguous section of a disk, or what appears to be so in some advanced setups.

A filesystem is a method of storing/finding files on a hard disk (usually in a partition). 

Theme | Windows | Linux
----- | ------- | -----
Partition | Disk1 | /dev/sda1
Filesystem Type | NTFS/VFAT | EXT3/EXT4/XFS/BTRFS...
Mounting Parameters | DriveLetter | MountPoint
Base Folder (where OS is stored) | C:\ | /
