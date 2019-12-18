# Manjaro (ArchLinux)

## Installer des paquets

* Avec l'interface graphique pamac
* Avec la commande `pacman`
* En utilisant le paquet `snapd` [snapcraft.io](https://snapcraft.io/docs/installing-snap-on-manjaro-linux)

## Chercher un fichier

* `find /chemin/vers/dossier/départ nomFichier` cherche un fichier dans le dossier demandé

## Services

[doc systemd](https://wiki.archlinux.org/index.php/Systemd#Using_units)

* `systemctl` liste les services actifs
* `systemctl status` affiche le statut
* `systemctl status nomService` affiche le statut d'un service
* `systemctl --failed` affiche les services ayant échoués
* `systemctl start nomService` démarre un service
* `systemctl stop nomService` stoppe un service
* `systemctl restart nomService` redémarre un service
* `systemctl reload nomService` recharge la configuration d'un service
* `systemctl enable nomService` permet à un service de se lancer au démarrage
* `systemctl enable --now nomService` démarre le service dès le démarrage
* `systemctl disable nomService` empêche un service de se lancer au démarrage