# PostGreSql

## Installation

[Manjaro](https://wiki.archlinux.org/index.php/PostgreSQL)

## Lancement du serveur

1. `sudo -iu postgres` lance le shell.
2. `initdb -D /var/lib/postgres/data` initialise le cluster de la base de données.
    * `initdb -D /var/lib/postgres/data --locale=fr_FR.UTF-8 -E UTF8` pareil mais en spécifiant une locale `--locale=fr_FR.UTF-8` et un encodage `-E UTF8`.
3. `pg_ctl -D /var/lib/postgres/data -l logfile start` lance le serveur.
    > Pour Manjaro exécuter : `systemctl start postgresql.service` pour lancer le serveur et `systemctl enable postgresql.service` pour lancer le serveur au démarrage.

## Utilisation

* `createdb nomBaseDeDonnées` créé une base de données.
* `dropdb nomBaseDeDonnées` supprime une base de données.
* `psql nomBaseDeDonnées` sélectionne une base de données.