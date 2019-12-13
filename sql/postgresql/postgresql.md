# PostGreSql

## Installation

[Manjaro](https://wiki.archlinux.org/index.php/PostgreSQL)

## Lancement du serveur

> Pour Manjaro exécuter : `systemctl start postgresql.service` pour lancer le serveur et `systemctl enable postgresql.service` pour lancer le serveur au démarrage.

1. `sudo -iu postgres` lance le shell.
2. `initdb -D /var/lib/postgres/data` initialise le cluster de la base de données.
    * `initdb -D /var/lib/postgres/data --locale=fr_FR.UTF-8 -E UTF8` pareil mais en spécifiant une locale `--locale=fr_FR.UTF-8` et un encodage `-E UTF8`.
3. `pg_ctl -D /var/lib/postgres/data -l logfile start` lance le serveur.

## Utilisation

> [Tutoriels](http://www.postgresqltutorial.com/)

1. `sudo -iu postgres` lance le shell.
1. `psql [nomBaseDeDonnées]` lance `psql` [et sélectionne une base de données].
    * `psql -d nomBaseDeDonnées -U  nomUtilisateur -W` se connecte à une base de données avec un utilisateur particulier.

* `SELECT version();` affiche la version de postgresql.
* `\?` affiche les commandes de `psql`.
* `\h nomCommande` affiche de l'aide sur une commande.
* `\g` répète la commande précédente.
* `\i filename` exécute les commandes d'un fichier.
* `\e` ouvre l'éditeur de texte par défaut pour entrer une commande qui sera exécuté à la fermeture de l'éditeur.
* `\q` quitte `psql`.
* Utilisateurs
    * `\du` affiche les utilisateurs et leurs rôles
    * déconnecte les utilisateurs de la base de données sélectionnée :
        ```SQL
        SELECT pg_terminate_backend(pg_stat_activity.pid)
        FROM pg_stat_activity
        WHERE datname = current_database()
        AND pid <> pg_backend_pid();
        ```
* Bases de données
    * `createdb nomBaseDeDonnées` créé une base de données.
    * `dropdb nomBaseDeDonnées` supprime une base de données.
    * `\c nomBaseDeDonnées [nomUtilisateur]` sélectionne une base de données [avec un utilisateur spécifique].
    * `\l` liste les bases de données disponibles.
* Schémas
    * `\dn` liste les schémas existants.
* Tables
    * `\dt` affiche les tables. Equivaut à :
        ```sql
        SELECT
            *
        FROM
            pg_catalog.pg_tables
        WHERE
            schemaname != 'pg_catalog'
        AND schemaname != 'information_schema';
        ```
    * `\d nomTable` ou `\d+ nomTable` affiche les infos d'une table. Equivaut à :
        ```sql
        SELECT
            COLUMN_NAME
        FROM
            information_schema.COLUMNS
        WHERE
            TABLE_NAME = 'nomTable';
        ```
* Fonctions
    * `\df` liste les fonctions disponibles.