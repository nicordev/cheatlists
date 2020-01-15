# SQL

*Note : les portions de code entre [ ] sont facultatives*

## Règles d'écriture

```sql
-- Ceci est un commentaire SQL (marche aussi avec MySQL)
# Ceci est un commentaire MySQL

SELECT 'Hello world!', (5 + 3) * 2, 5 + 3 * 2; -- Ceci est du code SQL affichant Hello world! et le résultat de 2 calculs
```

## Utilisation

* Exécuter un fichier .sql
    * `SOURCE chemin/vers/nom_fichier.sql;` exécute le code SQL contenu dans le fichier.
* Bases de donnée
    * `SHOW DATABASES;` affiche les bases de données disponibles.
    * `CREATE DATABASE nom_base_de_données [CHARSET 'utf8'];` créé une base de données.
    * `DROP DATABASE [IF EXISTS] nom_base_de_données;` supprime une base de données.
    * `USE nom_base_de_données` sélectionne la base de données.
* Tables
    * Informations
        * `SHOW TABLES;` liste les tables de la base de données active.
        * `DESCRIBE nom_table;` liste les colonnes de la table avec leurs caractéristiques.
    * Créer une table
        ```sql
        CREATE TABLE [IF EXISTS] nom_table (
            nom_colonne_1 caractéristiques_colonne_1[, 
            nom_colonne_1 caractéristiques_colonne_2,
            ...
            ],
            [PRIMARY KEY (nom_colonne_clé_primaire)]
        )
        [ENGINE=nom_moteur];
        ```
        * `caractéristiques_colonne_1` s'écrit de cette façon : `type_de_données [NOT NULL] [AUTO_INCREMENT] [DEFAULT valeur_par_défaut]`
        * `ENGINE=nom_moteur;` sélectionne le moteur à utiliser, `InnoDB` ou `MyISAM`. Préférer InnoDB car il gère les clés étrangères.
        * Exemple :
            ```sql
            CREATE TABLE task(
                id INT NOT NULL AUTO_INCREMENT,
                title VARCHAR(1000) NOT NULL,
                content TEXT,
                PRIMARY KEY (id)
            )
            ENGINE=InnoDB;
            ```
    * Supprimer, vider une table
        * `DROP TABLE nom_table;` supprime une table et ses données.
        * `TRUNCATE TABLE nom_table` supprime toutes les données d'une table.
        * `DELETE FROM nom_table` supprime toutes les données d'une table.
    * Supprimer les tables commençant par un préfix particulier
        1. Génèrer une requête pour supprimer toutes les tables :
            ```SQL
            SELECT CONCAT( 'DROP TABLE ', GROUP_CONCAT(table_name) , ';' ) 
            AS statement FROM information_schema.tables 
            WHERE table_schema = 'database_name' AND table_name LIKE 'myprefix_%';
            ```
        2. Exécuter la requête générée.