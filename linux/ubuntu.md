# Linux cheatlist

Liste réalisée en partie à partir [du cours de mateo21 sur OpenClassrooms](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux)

## `sudoers`

- Utiliser sudo sans avoir à taper son mot de passe :

    Modifier le fichier `/etc/sudoers` en super utilisateur en ajoutant à la fin :
    ```bash
    nomUtilisateur ALL=(ALL) NOPASSWD:ALL
    ```
- Réparer le fichier `/etc/sudoers` :

    ```bash
    pkexec visudo
    ```

## Bureau Gnome

* `ctl + alt + flèche haut/bas` change de bureau.
* `ctl + alt + shift + flèche haut/bas` déplace l'application en cours sur un autre bureau.

## Changer l'action de la touche poweroff

> [Réponse](https://askubuntu.com/questions/580902/how-to-change-mapping-for-the-poweroff-key-on-keyboard)

1. Mettre *Settings > Power::Power Button Action* à *Nothing*.
1. `sudo apt install xdotool`
1. `sudo touch /etc/acpi/events/power` créé le fichier power et mettre ce contenu :

    ```
    event=button/power
    action=/etc/acpi/power.sh "%e"
    ```

1. `sudo touch /etc/acpi/power.sh && sudo chmod +x /etc/acpi/power.sh` créé le script power.sh et mettre ce code :

    ```bash
    #!/bin/sh
    xdotool key End
    ```
    ou directement :
    ```bash
    sudo echo "#!/bin/sh \
    xdotool key End" > /etc/acpi/power.sh && sudo chmod +x /etc/acpi/power.sh
    ```
    
1. `sudo acpid restart`
1. Ajouter à la fin de `/etc/pam.d/common-session` :

    ```
    session optional pam_exec.so /usr/sbin/acpid restart
    ```

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
- Exécuter une commande :
    
    ```bash
    nomCommande valeur --nomOption valeur -p valeur -- valeur
    ```

    Le `--` indique la fin des options. Tout ce qui est écrit ensuite sera traité comme des valeurs.

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
- Afficher les utilisateurs :

    ```bash
    cat /etc/passwd
    ```

## Paquets

* `apt-get update` Mettre à jour la liste des paquets
* `apt-get upgrade` Mettre à jour tous les paquets
* `apt-cache search nomDuPaquet` Chercher un paquet
* `apt-get install nomDuPaquet` Installer un paquet

## Fichiers et dossiers

- `pwd` afficher le répertoire courant (present working directory).
- `cd` changer le répertoire courant (change directory) :
    - `cd cheminDossier` sélectionner le dossier `cheminDossier`.
    - `cd` sélectionner le dossier `$HOME` ou `~`.
    - `cd -` retourner au dossier précédent.
* `touch nomDuFichier` Créer un fichier
* `mdkir nomDuDossier` Créer un dossier
* `cat nomDuFichier` Afficher le contenu d'un fichier
* `less nomDuFichier` Afficher le contenu d'un fichier page par page

## Flux de redirection

* `>`, `>>` et `|` Rediriger les résultats d'une commande
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
    - `ps -aux`
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

## Exécuter des programmes en arrière plan

* `nomCommande paramètres &` exécute la commande en arrière plan. Affiche le numéro du processus et l'identifiant du processus (PID).
    * `nomCommande paramètres 2>&1 &` redirige aussi les erreurs.
* `nohup nomCommande paramètres` détache le processus de la console. La sortie est redirigée par défaut vers un fichier `nohup.out` créé dans le dossier courant.
* Passer un processus en cours en arrière plan
    1. `ctl + z` met en pause l'exécution du programme.
    2. `bg` passe le processus mis en pause en arrière plan et le réactive.
* `jobs` affiche la liste des processus en arrière plan.
* `fg %numéroProcessus` passe un processus au premier plan.

## Date

* `date "+%codeDate"` affiche une partie de la date actuelle `%codeDate` :
    * `%W` numéro de la semaine.
    * `%A` nom du jour.
    * On peut ajouter du texte et mettre plusieurs parties :
        * `date "+Nous sommes le %A de la semaine %W"`

## Exécuter un programme à une heure différée

* `at`

## Accès SSH

* Connexion SSH simple
    * `ssh loginUtilisateur@ipServeur` lance la connexion puis demande le mot de passe
    * `logout` ou `ctl + D` déconnecte l'utilisateur
* Authentification par paire de clés
    1. `ssh-keygen -t rsa` ou `dsa` demande une passphrase puis génère une paire de clés privée/publique
        * `~/.ssh/id_rsa.pub` fichier de la clé publique
        * `~/.ssh/id_rsa` fichier de la clé privée
    2. `ssh-copy-id -i id_rsa.pub loginUtilisateur@ipServeur` envoie la clé publique au serveur
    3. `ssh loginUtilisateur@ipServeur` connecte l'utilisteur et demande la passphrase
    4. (optionel) `ssh-add` permet d'ajouter la passphrase
* Transformer son ordi en serveur
    1. `sudo apt-get install openssh-server` installe le serveur SSH
    2. `sudo /etc/init.d/ssh/start` démarre le serveur
    3. `sudo /etc/init.d/ssh/stop` arrête le serveur
* Configuration
    1. Modifier le fichier `/etc/ssh/ssh_config`
    2. `sudo /etc/init.d/ssh reload` prend en compte les changements

## Variables d'environnement

* Editer le fichier `~/.profile`.
* `LANG=fr_FR.UTF-8` modifie la variable d'environnement existante `LANG`
* ```bash
    EDITOR=nano
    export EDITOR
    ```
    créé une nouvelle variable d'environnement `EDITOR`. Peut être écrit sur une ligne : `export EDITOR=nano`

## Flush DNS cache

* `sudo systemd-resolve --flush-caches` flush le cache.
    * `sudo systemd-resolve --statistics` montre que le cache a été vidé.
