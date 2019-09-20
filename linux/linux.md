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
