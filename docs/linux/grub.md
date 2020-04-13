# Grub

* [rentry.co](https://rentry.co/hpxxg)
    * Edit code: fAYSZNzF

## Changer le timeout à 1 seconde

* Editer le fichier `/etc/default/grub`.
* Modifier
    ```bash
    GRUB_TIMEOUT=1
    ```
* Ajouter 
    ```bash
    # Adjusted timeout for system which doesn't support recordfail
    GRUB_RECORDFAIL_TIMEOUT=1
    ```