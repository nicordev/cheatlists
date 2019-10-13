# Linux cheatlist

Liste réalisée à partir [du cours de mateo21 sur OpenClassrooms](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux)

## Invite de commande

* `nomUtilisateur@nomOrdinateur:~$`
    * `nomUtilisateur` Nom de l'utilisateur courant
    * `@` Séparateur "at" qui signifie "chez"
    * `nomOrdinateur` Nom de l'ordinateur utilisé
    * `:` Séparateur sans signification particulière
    * `~` Répertoire courant, ici le dossier personnel de l'utilisateur courant
    * `$` Niveau d'autorisation
        * `$` Normal
        * `#` Super utilisateur (pseudonyme *root*)

## Utilisateurs et les droits

* Super utilisateur root
    * `sudo nomCommande` Exécuter une commande en tant que super utilisateur
    * `sudo su` Passer en super utilisateur et le rester (le $ devient # dans l'invite de commande)
        * `exit` Quitter le mode root
* Gestion des utilisateurs #
    * `adduser nomUtilisateur` Ajouter un utilisateur
    * `deluser nomUtilisateur` Supprimer un utilisateur
    * `passwd nomUtilisateur` Changer le mot de passe de l'utilisateur
* Groupes #
    * `usermod -aG nomGroupe nomUtilisateur` Ajoute l'utilisateur au groupe voulu
    * `newgrp nomGroupe` Activer des changements précedemments opérés sur le groupe

## Paquets

* `apt-get update` Mettre à jour la liste des paquets
* `apt-get upgrade` Mettre à jour tous les paquets
* `apt-cache search nomDuPaquet` Chercher un paquet
* `apt-get install nomDuPaquet` Installer un paquet

## Fichiers et dossiers

* `touch nomDuFichier` Créer un fichier
* `mdkir nomDuDossier` Créer un dossier
* `cat nomDuFichier` Afficher le contenu d'un fichier
* `less nomDuFichier` Afficher le contenu d'un fichier page par page

## Flux de redirection

* `\>`, `>>` et `|` Rediriger les résultats d'une commande
    * `commande` Dans la console (par défaut)
    * `commande > nomFichier` Dans un fichier existant ou un nouveau
    * `commande >> nomFichier` A la suite d'un fichier existant ou un nouveau
    * `commande1 | commande2` Dans une autre commande
* `2>`, `2>&1` et `2>>` Rediriger les erreurs
    * `commande 2> nomFichier` Dans un fichier existant ou un nouveau
    * `commande > nomFichier 2>&1` Dans le fichier utilisé par `>`
    * `commande 2>> nomFichier` A la suite d'un fichier existant ou un nouveau
* `<` et `<<` Modifier l'entrée d'une commande
    * `commande paramètre` On entre le paramètre à la suite de la commande
    * `commande < nomFichier` Le contenu du fichier est passé à la commande
    * `commande <<MOT_CLE_DE_FIN texteTapéAuClavier MOT_CLE_DE_FIN` Envoyer progressivement du contenu à la commande au clavier

```bash
sort -n <<MOT_CLE_DE_FIN
1435
32
6
64
MOT_CLE_DE_FIN
```

## Surveiller l'activité du système

* `w` Qui fait quoi ?
* `ps` Lister les processus en cours
    * `ps -ef` Lister tous les processus de tous les utilisateurs de toutes les consoles
    * `ps -ejH` Afficher l'arborescence des processus
    * `ps -u nomUtilisateur` Lister les processus d'un utilisateur
* `top` Lister dynamiquement les processus
    * *q* quitter
    * *h* aide
    * *u* filtre pour un utilisateur
    * *k* tue un processus en donnant son PID
    * *s* change le rafraichissement (défaut 3s)
* *ctl + c* arrête le processus en cours
* `kill pidProcessus1 pidProcessus2` Arrêter un ou plusieurs processus via les PID (disponibles avec `ps` ou `top`)
    `kill -9 pidProcessus` Arrêter un processus brutalement
* `killall nomProcessus` Arrêter tous les processus ayant le nom donné
* `sudo halt` Arrêter l'ordinateur
* `sudo reboot` Redémarrer l'ordinateur
* `sudo shutdown [OPTIONS...] [TIME] [WALL...]` Arrête l'ordinateur ou le redémarre
    * *TIME* heure à laquelle exécuter la commande
        * `hh:mm` Heure précise
        * `now` ou `+0` Maintenant
        * `+unNombre` Dans un certain temps
    * *OPTIONS*
        * `-p` ou `--poweroff` Arrêter l'ordinateur (par défaut)
        * `-H` ou `--halt`
        * `-r` ou `--reboot` Redémarrer
        * `-k` Ne fait rien à par afficher le wall message
        * `-c` Annuler un shutdown programmé

## Variables d'environnement

* `LANG=fr_FR.UTF-8` modifie la variable d'environnement existante `LANG`
*   ```bash
    EDITOR=nano
    export EDITOR
    ```
    créé une nouvelle variable d'environnement `EDITOR`. Peut être écrit sur une ligne : `export EDITOR=nano`